[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$ModuleDir,
    [Parameter(Mandatory)][string]$AndroidJar,
    [Parameter(Mandatory)][string]$D8Path,
    [Parameter(Mandatory)][string]$Aapt2Path,
    [Parameter(Mandatory)][string]$ZipalignPath,
    [Parameter(Mandatory)][string]$ApksignerPath,
    [Parameter(Mandatory)][string]$JavaHome,
    [Parameter(Mandatory)][string]$OutputDir,
    [Parameter(Mandatory)][string]$Keystore,
    [Parameter(Mandatory)][string]$KeyAlias
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

foreach ($path in @($ModuleDir, $AndroidJar, $D8Path, $Aapt2Path, $ZipalignPath,
        $ApksignerPath, $JavaHome, $Keystore)) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required path not found: $path"
    }
}
if (-not $env:APK_KEYSTORE_PASSWORD -or -not $env:APK_KEY_PASSWORD) {
    throw 'Set APK_KEYSTORE_PASSWORD and APK_KEY_PASSWORD in the process environment.'
}

$module = [IO.Path]::GetFullPath($ModuleDir)
$output = [IO.Path]::GetFullPath($OutputDir)
$manifest = Join-Path $module 'AndroidManifest.xml'
$sourceRoot = Join-Path $module 'src'
$stubRoot = Join-Path $module 'stubs'
foreach ($path in @($manifest, $sourceRoot, $stubRoot)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Incomplete module source: $path" }
}

[IO.Directory]::CreateDirectory($output) | Out-Null
$work = Join-Path $output 'xposed-java-work'
$resolvedOutput = [IO.Path]::GetFullPath($output).TrimEnd('\')
$resolvedWork = [IO.Path]::GetFullPath($work)
if (-not $resolvedWork.StartsWith($resolvedOutput + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to clean work directory outside output: $resolvedWork"
}
if (Test-Path -LiteralPath $resolvedWork) {
    Remove-Item -LiteralPath $resolvedWork -Recurse -Force
}

$stubClasses = Join-Path $resolvedWork 'stub-classes'
$moduleClasses = Join-Path $resolvedWork 'module-classes'
$dexDir = Join-Path $resolvedWork 'dex'
foreach ($dir in @($stubClasses, $moduleClasses, $dexDir)) {
    [IO.Directory]::CreateDirectory($dir) | Out-Null
}

$javac = Join-Path $JavaHome 'bin\javac.exe'
$jar = Join-Path $JavaHome 'bin\jar.exe'
$env:JAVA_HOME = [IO.Path]::GetFullPath($JavaHome)
$stubSources = @(Get-ChildItem -LiteralPath $stubRoot -Recurse -Filter '*.java' | ForEach-Object FullName)
$moduleSources = @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -Filter '*.java' | ForEach-Object FullName)
if (-not $stubSources.Count -or -not $moduleSources.Count) { throw 'No Java sources found.' }

& $javac -encoding UTF-8 -source 8 -target 8 -classpath $AndroidJar -d $stubClasses @stubSources
if ($LASTEXITCODE -ne 0) { throw 'Xposed stub compilation failed.' }
$compileClasspath = "$AndroidJar;$stubClasses"
& $javac -encoding UTF-8 -source 8 -target 8 -classpath $compileClasspath -d $moduleClasses @moduleSources
if ($LASTEXITCODE -ne 0) { throw 'Module compilation failed.' }

$moduleClassFiles = @(Get-ChildItem -LiteralPath $moduleClasses -Recurse -Filter '*.class' | ForEach-Object FullName)
& $D8Path --min-api 27 --lib $AndroidJar --lib $stubClasses --output $dexDir @moduleClassFiles
if ($LASTEXITCODE -ne 0) { throw 'D8 failed.' }

$baseApk = Join-Path $resolvedWork 'base.apk'
& $Aapt2Path link -o $baseApk --manifest $manifest -I $AndroidJar --min-sdk-version 27 --target-sdk-version 28
if ($LASTEXITCODE -ne 0) { throw 'aapt2 link failed.' }

Push-Location $module
try {
    & $jar uf $baseApk -C $dexDir classes.dex assets/xposed_init META-INF/xposed/scope.list
    if ($LASTEXITCODE -ne 0) { throw 'jar packaging failed.' }
} finally {
    Pop-Location
}

$aligned = Join-Path $resolvedWork 'aligned.apk'
$signed = Join-Path $output 'xmsf-app-registration-compat.apk'
& $ZipalignPath -f 4 $baseApk $aligned
if ($LASTEXITCODE -ne 0) { throw 'zipalign failed.' }
Copy-Item -LiteralPath $aligned -Destination $signed -Force
& $ApksignerPath sign --v4-signing-enabled false --ks $Keystore --ks-key-alias $KeyAlias `
    --ks-pass env:APK_KEYSTORE_PASSWORD --key-pass env:APK_KEY_PASSWORD $signed
if ($LASTEXITCODE -ne 0) { throw 'apksigner failed.' }
& $ApksignerPath verify --verbose $signed
if ($LASTEXITCODE -ne 0) { throw 'apksigner verification failed.' }

$hash = Get-FileHash -LiteralPath $signed -Algorithm SHA256
[pscustomobject]@{
    Module = Split-Path -Leaf $module
    APK = $signed
    Signed = $true
    SHA256 = $hash.Hash
    Size = (Get-Item -LiteralPath $signed).Length
}

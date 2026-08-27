[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$ModuleDir,
    [Parameter(Mandatory)][string]$ApktoolJar,
    [Parameter(Mandatory)][string]$OutputDir,
    [string]$JavaPath = 'java',
    [string]$ZipalignPath,
    [string]$ApksignerPath,
    [string]$Keystore,
    [string]$KeyAlias
)

$ErrorActionPreference = 'Stop'
$module = [IO.Path]::GetFullPath($ModuleDir)
$apktool = [IO.Path]::GetFullPath($ApktoolJar)
$output = [IO.Path]::GetFullPath($OutputDir)
if (-not (Test-Path -LiteralPath (Join-Path $module 'apktool.yml'))) { throw "Not an Apktool project: $module" }
if (-not (Test-Path -LiteralPath $apktool -PathType Leaf)) { throw "Apktool jar not found: $apktool" }
[IO.Directory]::CreateDirectory($output) | Out-Null

$name = Split-Path -Leaf $module
$unsigned = Join-Path $output "$name-unsigned.apk"
& $JavaPath -jar $apktool b $module -o $unsigned
if ($LASTEXITCODE -ne 0) { throw "Apktool build failed for $name" }

$signRequested = $Keystore -or $KeyAlias -or $ZipalignPath -or $ApksignerPath
if (-not $signRequested) {
    $hash = Get-FileHash -LiteralPath $unsigned -Algorithm SHA256
    [pscustomobject]@{ Module = $name; APK = $unsigned; Signed = $false; SHA256 = $hash.Hash }
    return
}

foreach ($value in @($Keystore, $KeyAlias, $ZipalignPath, $ApksignerPath)) {
    if (-not $value) { throw 'Signing requires Keystore, KeyAlias, ZipalignPath, and ApksignerPath.' }
}
if (-not $env:APK_KEYSTORE_PASSWORD -or -not $env:APK_KEY_PASSWORD) {
    throw 'Set APK_KEYSTORE_PASSWORD and APK_KEY_PASSWORD in the process environment.'
}

$aligned = Join-Path $output "$name-aligned.apk"
$signed = Join-Path $output "$name.apk"
& $ZipalignPath -f 4 $unsigned $aligned
if ($LASTEXITCODE -ne 0) { throw 'zipalign failed.' }
Copy-Item -LiteralPath $aligned -Destination $signed -Force
& $ApksignerPath sign --v4-signing-enabled false --ks $Keystore --ks-key-alias $KeyAlias --ks-pass env:APK_KEYSTORE_PASSWORD --key-pass env:APK_KEY_PASSWORD $signed
if ($LASTEXITCODE -ne 0) { throw 'apksigner failed.' }
& $ApksignerPath verify --verbose $signed
if ($LASTEXITCODE -ne 0) { throw 'apksigner verification failed.' }

$hash = Get-FileHash -LiteralPath $signed -Algorithm SHA256
[pscustomobject]@{ Module = $name; APK = $signed; Signed = $true; SHA256 = $hash.Hash }

[CmdletBinding()]
param(
    [string]$ModuleDir = (Join-Path $PSScriptRoot '..\modules\wechat-fcm-token-bridge'),
    [string]$ApkPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$module = [IO.Path]::GetFullPath($ModuleDir)
$source = Join-Path $module 'src\com\codex\wechatfcm\Hook.java'
$manifest = Join-Path $module 'AndroidManifest.xml'
$scope = Join-Path $module 'META-INF\xposed\scope.list'
$init = Join-Path $module 'assets\xposed_init'
foreach ($path in @($source, $manifest, $scope, $init)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Required module file is missing: $path"
    }
}

$sourceText = Get-Content -LiteralPath $source -Raw
$manifestText = Get-Content -LiteralPath $manifest -Raw
$scopeLines = @(Get-Content -LiteralPath $scope | Where-Object { $_.Trim() })
$initLines = @(Get-Content -LiteralPath $init | Where-Object { $_.Trim() })

$requirements = [ordered]@{
    PackageGuard = $sourceText.Contains('WECHAT.equals(lpparam.packageName)')
    MainProcessGuard = $sourceText.Contains('WECHAT.equals(lpparam.processName)')
    VersionLock = $sourceText.Contains('EXPECTED_VERSION_CODE = 3085L')
    SignerLock = $sourceText.Contains('0fe4ff85c215918396dadc7cd8ce6963339af33d37751a56e54c7206b63a3c7c')
    ThreadLocalOverride = $sourceText.Contains('ThreadLocal<Boolean> FORCE_EMPTY_STORED_TOKEN')
    Scene216Observation = $sourceText.Contains('scene216_result')
    ExpiringMarker = $sourceText.Contains('expires_epoch=') -and $sourceText.Contains('expires > now + 300L')
    ScopeExact = $scopeLines.Count -eq 1 -and $scopeLines[0].Trim() -eq 'com.tencent.mm'
    EntrypointExact = $initLines.Count -eq 1 -and $initLines[0].Trim() -eq 'com.codex.wechatfcm.Hook'
    NonDebuggable = $manifestText.Contains('android:debuggable="false"')
}

$forbidden = [ordered]@{
    DeletesFirebaseInstanceId = $sourceText -match 'deleteInstanceId|FirebaseInstanceId[^\r\n]*\.a\('
    DirectWechatStorageWrite = $sourceText -match 'putString\("fcm_curr_reg_token"|remove\("fcm_curr_reg_token"'
    LogsTokenArgument = $sourceText -match 'LOG_PREFIX[^\r\n]*(currentToken|storedToken)|log\([^\r\n]*(currentToken|storedToken)'
    LogsPayloadValues = $sourceText -match 'entrySet\(|keySet\(|map\.get\('
    UsesForceStop = $sourceText -match 'force-stop|pm clear'
}

$failedRequirements = @($requirements.GetEnumerator() | Where-Object { -not $_.Value })
$failedForbidden = @($forbidden.GetEnumerator() | Where-Object { $_.Value })
if ($failedRequirements.Count -or $failedForbidden.Count) {
    throw "Static safety test failed. Missing=$($failedRequirements.Name -join ',') Forbidden=$($failedForbidden.Name -join ',')"
}

$apk = $null
if ($ApkPath) {
    $apk = [IO.Path]::GetFullPath($ApkPath)
    if (-not (Test-Path -LiteralPath $apk -PathType Leaf)) {
        throw "APK does not exist: $apk"
    }
}

[pscustomobject]@{
    Module = $module
    SourceSafetyPassed = $true
    Scope = $scopeLines[0].Trim()
    VersionCodeLock = 3085
    SignerLock = '0fe4ff85c215918396dadc7cd8ce6963339af33d37751a56e54c7206b63a3c7c'
    Apk = $apk
    ApkSha256 = if ($apk) { (Get-FileHash -LiteralPath $apk -Algorithm SHA256).Hash } else { $null }
}

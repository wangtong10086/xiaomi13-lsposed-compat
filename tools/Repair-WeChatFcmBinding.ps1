[CmdletBinding()]
param(
    [string]$Serial,
    [string]$AdbPath = 'adb',
    [string]$ApkSignerPath,
    [string]$JavaHome = 'E:\Xiaomi13Migration\tools\temurin-jdk17\jdk-17.0.20.1+1',
    [string]$ModuleApk = (Join-Path $PSScriptRoot '..\out\wechat-fcm-token-bridge.apk'),
    [string]$BackupRoot = 'E:\Xiaomi13Migration',
    [switch]$Observe,
    [switch]$Rebind,
    [switch]$Apply,
    [ValidateRange(30, 180)][int]$TimeoutSeconds = 90
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$wechat = 'com.tencent.mm'
$modulePackage = 'com.codex.wechatfcmtokenbridge'
$expectedVersionCode = 3085L
$expectedSigner = '0fe4ff85c215918396dadc7cd8ce6963339af33d37751a56e54c7206b63a3c7c'
$controlDir = '/data/local/tmp/wechat-fcm-token-bridge'
$controlFile = "$controlDir/rebind.once"
$logPrefix = 'WechatFcmTokenBridge:'

if ($Observe -and $Rebind) {
    throw '-Observe and -Rebind are mutually exclusive.'
}
if ($Apply -and -not ($Observe -or $Rebind)) {
    throw '-Apply requires -Observe or -Rebind.'
}

function Resolve-Executable {
    param([Parameter(Mandatory)][string]$Value, [Parameter(Mandatory)][string]$Name)
    $command = Get-Command -Name $Value -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    if (Test-Path -LiteralPath $Value -PathType Leaf) {
        return (Resolve-Path -LiteralPath $Value).Path
    }
    throw "$Name was not found at '$Value'."
}

$script:Adb = Resolve-Executable -Value $AdbPath -Name 'adb'

function Invoke-Adb {
    param([Parameter(Mandatory)][string[]]$Arguments, [switch]$AllowFailure)
    $output = & $script:Adb @Arguments 2>&1
    $code = $LASTEXITCODE
    $lines = @($output | ForEach-Object { $_.ToString() })
    if ($code -ne 0 -and -not $AllowFailure) {
        throw "adb failed with exit code ${code}: $($lines -join ' ')"
    }
    return $lines
}

if (-not $Serial) {
    $devices = @(Invoke-Adb -Arguments @('devices', '-l') |
        Where-Object { $_ -match '^([^\s]+)\s+device\b' })
    if ($devices.Count -ne 1) {
        throw "Expected exactly one authorized ADB device; found $($devices.Count)."
    }
    $Serial = ([regex]::Match($devices[0], '^([^\s]+)')).Groups[1].Value
}

function Invoke-Device {
    param([Parameter(Mandatory)][string[]]$Arguments, [switch]$AllowFailure)
    return Invoke-Adb -Arguments (@('-s', $Serial, 'shell') + $Arguments) `
        -AllowFailure:$AllowFailure
}

function Invoke-Root {
    param([Parameter(Mandatory)][string]$Command, [switch]$AllowFailure)
    $quoted = "'" + $Command.Replace("'", "'`"'`"'") + "'"
    return Invoke-Adb -Arguments @('-s', $Serial, 'shell', 'su', '-c', $quoted) `
        -AllowFailure:$AllowFailure
}

function Get-PackageDump {
    param([Parameter(Mandatory)][string]$Package)
    return @(Invoke-Device -Arguments @('dumpsys', 'package', $Package) -AllowFailure)
}

function Get-VersionCode {
    param([AllowEmptyCollection()][AllowEmptyString()][string[]]$Dump = @())
    $line = $Dump | Where-Object { $_ -match 'versionCode=(\d+)' } | Select-Object -First 1
    if (-not $line -or $line -notmatch 'versionCode=(\d+)') { return -1L }
    return [int64]$Matches[1]
}

function Get-Stopped {
    param([Parameter(Mandatory)][AllowEmptyString()][string[]]$Dump)
    $line = $Dump | Where-Object { $_ -match '^\s*User 0:' } | Select-Object -First 1
    if ($line -match 'stopped=(true|false)') { return [bool]::Parse($Matches[1]) }
    return $null
}

function Resolve-ApkSigner {
    if ($ApkSignerPath) {
        return Resolve-Executable -Value $ApkSignerPath -Name 'apksigner'
    }
    $command = Get-Command -Name 'apksigner' -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    $known = 'E:\Xiaomi13Migration\20260827-camera-processing-fix\tools\android-sdk\build-tools-36\android-16\apksigner.bat'
    if (Test-Path -LiteralPath $known -PathType Leaf) { return $known }
    throw 'apksigner was not found; pass -ApkSignerPath.'
}

function Invoke-ApkSigner {
    param([Parameter(Mandatory)][string[]]$Arguments)
    if (-not (Test-Path -LiteralPath (Join-Path $JavaHome 'bin\java.exe') -PathType Leaf)) {
        throw "JavaHome does not contain bin\\java.exe: $JavaHome"
    }
    $previous = $env:JAVA_HOME
    try {
        $env:JAVA_HOME = [IO.Path]::GetFullPath($JavaHome)
        $apksigner = Resolve-ApkSigner
        $output = @(& $apksigner @Arguments 2>&1 | ForEach-Object { $_.ToString() })
        return [pscustomobject]@{ ExitCode = $LASTEXITCODE; Lines = $output }
    } finally {
        if ($null -eq $previous) { Remove-Item Env:JAVA_HOME -ErrorAction SilentlyContinue }
        else { $env:JAVA_HOME = $previous }
    }
}

function Get-InstalledSignerDigest {
    $paths = @(Invoke-Device -Arguments @('pm', 'path', $wechat) |
        ForEach-Object { if ($_ -match '^package:(.+)$') { $Matches[1] } })
    if (-not $paths.Count) { throw 'WeChat APK path is unavailable.' }
    $base = $paths | Where-Object { $_ -match '/base\.apk$' } | Select-Object -First 1
    if (-not $base) { $base = $paths[0] }
    $stage = Join-Path ([IO.Path]::GetTempPath()) ('wechat-signer-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $stage | Out-Null
    $local = Join-Path $stage 'base.apk'
    try {
        Invoke-Adb -Arguments @('-s', $Serial, 'pull', $base, $local) | Out-Null
        $verification = Invoke-ApkSigner -Arguments @('verify', '--print-certs', $local)
        $lines = $verification.Lines
        if ($verification.ExitCode -ne 0) { throw 'apksigner verification of installed WeChat failed.' }
        $line = $lines | Where-Object {
            $_ -match '^Signer #1 certificate SHA-256 digest:\s*([0-9a-fA-F]+)\s*$'
        } | Select-Object -First 1
        if (-not $line -or $line -notmatch '([0-9a-fA-F]{64})\s*$') {
            throw 'Installed WeChat signer digest was not found.'
        }
        return $Matches[1].ToLowerInvariant()
    } finally {
        if (Test-Path -LiteralPath $stage) {
            Remove-Item -LiteralPath $stage -Recurse -Force
        }
    }
}

function Get-ModuleEvents {
    param([long]$SinceEpochMs = 0L)
    $lines = [System.Collections.Generic.List[string]]::new()
    foreach ($line in (Invoke-Device -Arguments @('logcat', '-d', '-v', 'epoch') -AllowFailure)) {
        if ($line.Contains($logPrefix)) { $lines.Add($line.Trim()) }
    }
    $rootLogCommand = "grep -h '$logPrefix' /data/adb/lspd/log/*.log /data/adb/lspd/log/modules_*.log 2>/dev/null | tail -n 200"
    foreach ($line in (Invoke-Root -Command $rootLogCommand -AllowFailure)) {
        if ($line.Contains($logPrefix)) { $lines.Add($line.Trim()) }
    }
    return @($lines | Select-Object -Unique | Where-Object {
        if ($SinceEpochMs -le 0L) { return $true }
        if ($_ -match 'epoch_ms=(\d+)') { return [int64]$Matches[1] -ge $SinceEpochMs }
        return $false
    })
}

function Get-Audit {
    $dump = Get-PackageDump -Package $wechat
    $version = Get-VersionCode -Dump $dump
    $signer = Get-InstalledSignerDigest
    $wechatProcesses = @(Invoke-Device -Arguments @('ps', '-A', '-o', 'NAME') -AllowFailure |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -match '^com\.tencent\.mm(?::[^\s]+)?$' })
    $moduleDump = Get-PackageDump -Package $modulePackage
    $moduleInstalled = if (@($moduleDump | Where-Object { $_ }).Count) {
        (Get-VersionCode -Dump @($moduleDump | Where-Object { $_ })) -gt 0
    } else { $false }
    $markerPresent = ((Invoke-Root -Command "if [ -f $controlFile ]; then echo true; else echo false; fi" `
        -AllowFailure | Select-Object -Last 1) -eq 'true')
    return [ordered]@{
        CollectedAt = (Get-Date).ToString('o')
        Serial = $Serial
        RootAvailable = ((Invoke-Root -Command 'id' | Select-Object -First 1) -match 'uid=0')
        WeChatVersionCode = $version
        WeChatVersionAccepted = $version -eq $expectedVersionCode
        WeChatSignerMatch = $signer -eq $expectedSigner
        WeChatStopped = Get-Stopped -Dump $dump
        WeChatProcessCount = $wechatProcesses.Count
        ModuleInstalled = $moduleInstalled
        ControlMarkerPresent = $markerPresent
        Privacy = [ordered]@{
            TokenReadByController = $false
            MessageDataRead = $false
            RawXlogRead = $false
        }
    }
}

function Assert-Guards {
    param([Parameter(Mandatory)][System.Collections.IDictionary]$Audit)
    if (-not $Audit.RootAvailable) { throw 'Root shell is unavailable.' }
    if (-not $Audit.WeChatVersionAccepted) {
        throw "WeChat versionCode $($Audit.WeChatVersionCode) does not match lock $expectedVersionCode."
    }
    if (-not $Audit.WeChatSignerMatch) { throw 'WeChat Tencent signer guard failed.' }
}

function Backup-InstalledModule {
    $paths = @(Invoke-Device -Arguments @('pm', 'path', $modulePackage) -AllowFailure |
        ForEach-Object { if ($_ -match '^package:(.+)$') { $Matches[1] } })
    if (-not $paths.Count) { return $null }
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $destination = Join-Path $BackupRoot "$stamp-wechat-fcm-bridge"
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    $index = 0
    foreach ($path in $paths) {
        Invoke-Adb -Arguments @('-s', $Serial, 'pull', $path,
            (Join-Path $destination "previous-module-$index.apk")) | Out-Null
        $index++
    }
    return $destination
}

function Install-Module {
    $apk = [IO.Path]::GetFullPath($ModuleApk)
    if (-not (Test-Path -LiteralPath $apk -PathType Leaf)) {
        throw "Signed module APK was not found: $apk"
    }
    $verification = Invoke-ApkSigner -Arguments @('verify', '--verbose', $apk)
    if ($verification.ExitCode -ne 0) { throw 'Module APK signature verification failed.' }
    $backup = Backup-InstalledModule
    $installOutput = Invoke-Adb -Arguments @('-s', $Serial, 'install', '-r', $apk)
    if (-not ($installOutput | Where-Object { $_ -eq 'Success' })) {
        throw "Module install did not report success: $($installOutput -join ' ')"
    }
    return $backup
}

function Configure-LSPosedScope {
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $database = '/data/adb/lspd/config/modules_config.db'
    $backup = "/data/adb/lspd/config/modules_config.db.before-wechat-fcm-bridge-$stamp"
    $backupCommand = "test -f $database && cp -p $database $backup && chmod 0600 $backup"
    Invoke-Root -Command $backupCommand | Out-Null

    $enable = (Invoke-Root -Command "/data/adb/lspd/cli modules enable $modulePackage --json") -join "`n"
    if ($enable -notmatch '"success"\s*:\s*true') {
        throw "Vector CLI did not enable the module: $enable"
    }
    $scopeResult = (Invoke-Root -Command "/data/adb/lspd/cli scope set $modulePackage $wechat/0 --json") -join "`n"
    if ($scopeResult -notmatch '"success"\s*:\s*true') {
        throw "Vector CLI did not set the module scope: $scopeResult"
    }
    $scopeAudit = (Invoke-Root -Command "/data/adb/lspd/cli scope ls $modulePackage --json") -join "`n"
    $scopeObject = $scopeAudit | ConvertFrom-Json
    $exactScope = @($scopeObject.data | Where-Object {
        $_.APP_PACKAGE -eq $wechat -and [int]$_.USER_ID -eq 0
    })
    if (-not $scopeObject.success -or $exactScope.Count -ne 1 -or @($scopeObject.data).Count -ne 1) {
        throw "Vector CLI scope verification failed: $scopeAudit"
    }
    return $backup
}

function Get-LaunchComponent {
    $line = Invoke-Device -Arguments @(
        'cmd', 'package', 'resolve-activity', '--brief',
        '-a', 'android.intent.action.MAIN',
        '-c', 'android.intent.category.LAUNCHER',
        $wechat) | Where-Object { $_ -match '^com\.tencent\.mm/' } | Select-Object -Last 1
    if (-not $line) { throw 'WeChat launcher activity was not resolved.' }
    return $line.Trim()
}

function Start-WeChatSafely {
    $component = Get-LaunchComponent
    Invoke-Device -Arguments @('am', 'kill', $wechat) -AllowFailure | Out-Null
    Invoke-Device -Arguments @('am', 'start', '-n', $component) | Out-Null
}

function Return-HomeAndKill {
    Invoke-Device -Arguments @('input', 'keyevent', '3') -AllowFailure | Out-Null
    Start-Sleep -Seconds 2
    Invoke-Device -Arguments @('am', 'kill', $wechat) -AllowFailure | Out-Null
}

function Write-ControlMarker {
    $nonce = [guid]::NewGuid().ToString('N')
    $expires = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds() + [Math]::Min($TimeoutSeconds + 30, 210)
    $stage = Join-Path ([IO.Path]::GetTempPath()) ('wechat-fcm-control-' + $nonce)
    $remoteStage = "/data/local/tmp/wechat-fcm-rebind-$nonce.tmp"
    try {
        [IO.File]::WriteAllLines($stage, @(
            'action=rebind',
            "nonce=$nonce",
            "expires_epoch=$expires"
        ), [Text.UTF8Encoding]::new($false))
        Invoke-Root -Command "mkdir -p $controlDir && chmod 0755 $controlDir" | Out-Null
        Invoke-Adb -Arguments @('-s', $Serial, 'push', $stage, $remoteStage) | Out-Null
        Invoke-Root -Command "chown root:root $remoteStage && chmod 0644 $remoteStage && mv $remoteStage $controlFile" | Out-Null
    } finally {
        Invoke-Root -Command "rm -f $remoteStage" -AllowFailure | Out-Null
        if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Force }
    }
}

function Remove-ControlMarker {
    Invoke-Root -Command "rm -f $controlFile $controlFile.tmp" -AllowFailure | Out-Null
}

$audit = Get-Audit
Assert-Guards -Audit $audit

if (-not ($Observe -or $Rebind)) {
    [ordered]@{
        Mode = 'Audit'
        Apply = $false
        Audit = $audit
        RecentModuleEvents = @(Get-ModuleEvents | Select-Object -Last 30)
    } | ConvertTo-Json -Depth 8
    return
}

if (-not $Apply) {
    [ordered]@{
        Mode = if ($Observe) { 'Observe' } else { 'Rebind' }
        Apply = $false
        Audit = $audit
        ProposedChanges = if ($Observe) {
            @('Install or upgrade the signed bridge module',
              'Launch WeChat once without force-stop',
              'Collect metadata-only module events',
              'Return home and use am kill')
        } else {
            @('Create one expiring rebind marker',
              'Launch WeChat once without force-stop',
              'Wait for native scene 216 result',
              'Remove the marker in all outcomes')
        }
        ForbiddenOperations = @('force-stop', 'pm clear', 'Firebase IID deletion', 'WeChat database edit')
    } | ConvertTo-Json -Depth 8
    return
}

if ($Observe) {
    $backup = Install-Module
    $lsposedBackup = Configure-LSPosedScope
    $startedAt = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
    Start-WeChatSafely
    Start-Sleep -Seconds 15
    $events = @(Get-ModuleEvents -SinceEpochMs $startedAt)
    Return-HomeAndKill
    Start-Sleep -Seconds 3
    $post = Get-Audit
    $guardAccepted = [bool]($events | Where-Object {
        $_ -match 'event=guard outcome=accepted'
    })
    [ordered]@{
        Mode = 'Observe'
        Applied = $true
        PreviousModuleBackup = $backup
        LSPosedConfigBackup = $lsposedBackup
        ModuleGuardAccepted = $guardAccepted
        RequiresLSPosedActivation = -not $guardAccepted
        Events = $events
        PostAudit = $post
        ForceStopUsed = $false
        TokenPrinted = $false
    } | ConvertTo-Json -Depth 8
    return
}

if (-not $audit.ModuleInstalled) {
    throw 'The bridge module is not installed. Run -Observe -Apply first and enable only com.tencent.mm/0 in LSPosed.'
}

$startedAt = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
$markerRemovedAfterAccept = $false
try {
    Write-ControlMarker
    Start-WeChatSafely
    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    $events = @()
    do {
        Start-Sleep -Seconds 2
        $events = @(Get-ModuleEvents -SinceEpochMs $startedAt)
        if (-not $markerRemovedAfterAccept -and ($events | Where-Object {
            $_ -match 'event=control outcome=accepted|event=rebind outcome=accepted'
        })) {
            Remove-ControlMarker
            $markerRemovedAfterAccept = $true
        }
        $resultEvent = $events | Where-Object {
            $_ -match 'event=scene216_result outcome=(success|failure)'
        } | Select-Object -Last 1
    } while (-not $resultEvent -and (Get-Date) -lt $deadline)

    $success = [bool]($resultEvent -and $resultEvent -match 'outcome=success')
    Return-HomeAndKill
    Start-Sleep -Seconds 3
    $post = Get-Audit
    [ordered]@{
        Mode = 'Rebind'
        Applied = $true
        Scene216Succeeded = $success
        ResultObserved = [bool]$resultEvent
        ControlMarkerRemovedAfterAccept = $markerRemovedAfterAccept
        Events = $events
        PostAudit = $post
        ForceStopUsed = $false
        DirectWechatStorageWriteUsed = $false
        TokenPrinted = $false
    } | ConvertTo-Json -Depth 8
    if (-not $success) {
        throw 'Native scene 216 did not return success; no delivery test is authorized yet.'
    }
} finally {
    Remove-ControlMarker
}

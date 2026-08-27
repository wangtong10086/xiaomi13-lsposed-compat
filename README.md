# Xiaomi 13 LSPosed compatibility modules

Three narrowly scoped modules used to restore Xiaomi application behavior on a customized Xiaomi 13 (`fuxi`) running Android 16.

| Module | Scope | Purpose |
| --- | --- | --- |
| `camera-native-hook` | `com.android.camera` | camera2 hidden-API exemption and Android 16 `TotalCaptureResult` bridge used by Xiaomi Camera |
| `market-download-compat` | `com.xiaomi.market` | restores the DownloadManager filename cursor access expected by Xiaomi Market |
| `miui-intent-fix` | Xiaomi Account, TSM, NFC/eSE, and `system` | Xiaomi account/TSM compatibility, eSE routing, double-power Xiaomi cards, triple-power Google Wallet |

The Apktool projects are the exact rebuildable smali representation extracted from the validated APKs. `reference/miui-intent-fix-java` is a JADX view for navigation only; it is not the canonical build source.

## Build

Install Java, Apktool 3.0.3, and Android build-tools. Build unsigned output with:

```powershell
./tools/Build-ApktoolModule.ps1 -ModuleDir ./modules/market-download-compat -ApktoolJar '<path-to-apktool.jar>' -OutputDir ./out
```

Signing requires an external keystore and environment variables; no key is stored in this repository. See `tools/Build-ApktoolModule.ps1` help.

## Install/upgrade

1. Verify the APK SHA-256.
2. Install the APK without copying another device's framework database.
3. Enable only the documented scope.
4. Reboot and inspect logs for the module's activation message.
5. Test the affected feature and unrelated features in the same app.

Known-good signed APKs are release assets. Their checksums are in `RELEASES.md`.

Because these modules hook private implementation details, re-review them after every Android, Xiaomi app, LSPosed, or Vector update.

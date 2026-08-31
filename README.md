# Xiaomi 13 LSPosed compatibility modules

Six narrowly scoped modules used to restore application behavior on a customized Xiaomi 13 (`fuxi`) running Android 16.

| Module | Scope | Purpose |
| --- | --- | --- |
| `camera-native-hook` | `com.android.camera` | camera2 hidden-API exemption and Android 16 `TotalCaptureResult` bridge used by Xiaomi Camera |
| `lark-mipush-token-bridge` | `com.ss.android.lark` main process | completes Feishu's own server-side MiPush token-binding callback after XMSF registration |
| `market-download-compat` | `com.xiaomi.market` | restores the DownloadManager filename cursor access expected by Xiaomi Market |
| `miui-intent-fix` | Xiaomi Account, TSM, NFC/eSE, and `system` | Xiaomi account/TSM compatibility, eSE routing, double-power Xiaomi cards, triple-power Google Wallet |
| `wechat-fcm-token-bridge` | `com.tencent.mm` main process | metadata-only native FCM tracing and an exact-version, one-shot call through WeChat's own token-registration RPC |
| `xmsf-app-registration-compat` | `system`/`android`; temporary exact-version app scope | bounded app-owned XMSF registration for reviewed packages plus Alipay callback-component protection |

Most modules are exact rebuildable Apktool/smali projects. `xmsf-app-registration-compat` is a small Java module built against local Xposed API stubs; the stubs are compile-time-only and are not packaged. `reference/miui-intent-fix-java` is a JADX view for navigation only.

## Build

Install Java, Apktool 3.0.3, and Android build-tools. Build unsigned output with:

```powershell
./tools/Build-ApktoolModule.ps1 -ModuleDir ./modules/market-download-compat -ApktoolJar '<path-to-apktool.jar>' -OutputDir ./out
```

Signing requires an external keystore and environment variables; no key is stored in this repository. See `tools/Build-ApktoolModule.ps1` help.

Build the Java-based XMSF or WeChat module with `tools/Build-XposedJavaModule.ps1`; it requires local Android platform/build-tools paths and the same external signing inputs.

## Install/upgrade

1. Verify the APK SHA-256.
2. Install the APK without copying another device's framework database.
3. Enable only the documented scope.
4. Reboot and inspect logs for the module's activation message.
5. Test the affected feature and unrelated features in the same app.

Known-good signed APKs are release assets. Their checksums are in `RELEASES.md`.

Because these modules hook private implementation details, re-review them after every Android, Xiaomi app, LSPosed, or Vector update.

MiPush registration findings for reviewed Android 16 applications are documented in `docs/xmsf-registration-android16.md`. The matrix distinguishes module injection, server registration, app-private regId persistence, and actual delivery; do not treat them as one signal.

The exact-version WeChat repair and privacy-safe validation procedure is documented in `docs/wechat-fcm-token-bridge.md`.

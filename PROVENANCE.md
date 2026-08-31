# Source provenance

- Canonical module sources are Apktool 3.0.3 projects reconstructed from the final locally validated APKs.
- `camera-native-hook`, `market-download-compat`, and `lark-mipush-token-bridge` were authored as compact smali modules for observed compatibility gaps.
- `xmsf-app-registration-compat` is original Java source built against compile-only Xposed stubs. Exact-version behavior was derived from local control-flow, manifest, runtime ClassLoader, and XMSF event review. The optional Douyin bridge reads only the installed Vector 0.6.1 compatibility profile at runtime; no application bytecode, Vector APK, credential value, RegID, token, or message is vendored.
- `wechat-fcm-token-bridge` is original Java source built against compile-only Xposed stubs. Its exact-version hooks were derived from the locally installed Google Play WeChat 8.0.72 (`versionCode=3085`) control flow and verified at runtime. It calls only WeChat's own registration path; no WeChat bytecode, Firebase token, payload, account data, or proprietary binary is vendored.
- `lark-mipush-token-bridge` was derived from the control flow in the locally installed Feishu 7.75.15 APK. No Feishu or Xiaomi bytecode, credentials, registration tokens, account data, or proprietary binaries are vendored.
- `miui-intent-fix` was preserved as exact smali plus a non-canonical JADX reference view.
- APK signatures and signing keys are intentionally excluded. Rebuilding changes the signing certificate unless the original private key is supplied externally.
- Empty Apktool resource package metadata produced by decoding resource-minimal APKs was normalized to the manifest package so Apktool 3.0.3 can rebuild with `aapt2`.
- Xiaomi, Android, Magisk, LSPosed, Vector, and app binaries are not vendored.

The checked-in scope files are part of the review surface. Expanding a scope should be treated as a security-sensitive code change.

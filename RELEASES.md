# Known-good signed APKs

> [!WARNING]
> These files are prerelease artifacts validated only on the exact local build lineage documented by this repository. Before installation, verify the SHA-256, signing certificate, target application version, Android/ROM version, LSPosed version, and configured scope. A hash match does not prove compatibility with a different build.

| Artifact | Size | SHA-256 |
| --- | ---: | --- |
| `fuxi-camera-native-hook-v2.apk` | 16,959 bytes | `8f5ab538583bc8edc6bec50b213cd74c90d14766eb6878d4b0d8f4a41651ba5a` |
| `lark-mipush-token-bridge.apk` | 16,923 bytes | `1329e1a87cdd500e5edcc4a23418d4cf1ef1b58acaab9327270216f4e89788cc` |
| `xiaomi-market-download-compat-v1.apk` | 16,923 bytes | `b276dc1327388f078958c2e954cc3080dee0800b25a1de27319610de2b71508d` |
| `miuiintentfix.apk` | 45,593 bytes | `2fc3d1cdb4212aa74c4e85fe30c70a7e95d16c5fdad9045f20705174b8a4aa92` |
| `xmsf-app-registration-compat.apk` | 25,120 bytes | `0303c9ff6598f6e7471ba12af9dd818f7d1ac49ccc4fb124b85987232324b519` |

The release APKs are the locally validated installed lineage. A locally rebuilt APK can have equivalent bytecode but a different certificate and hash, and therefore may not upgrade the installed package. Signing keys are not published.

## Wallet cleanup update: local build, source-only delivery

`miui-intent-fix` 2.6.9-cleanup (versionCode 30) was built and installed locally.
No release or APK asset is published for this update. It uses the maintenance
signing lineage established by the separately authorized component reinstall;
it is not an in-place upgrade of the old `miuiintentfix.apk` certificate above.

| Variant | Size | SHA-256 |
| --- | ---: | --- |
| Production `miui-intent-fix.apk` | 62,102 bytes | `d63e567bd3a6b7cdcd7a1cd18ba93dc337f40a93afcc5df3522fad28da87617b` |

Signing certificate SHA-256:
`66182646268bb3fec768c804776969d6743119052d95118ff8f720b18c5f051d`.
The default APK excludes wallet diagnostic classes, one-time signature-migration
hooks and Xposed API stubs. The existing Magisk overlay remains version 2.4/6.
See the [investigation and device validation](docs/xiaomi-wallet-compat-android16.md)
for the exact wallet/framework/Provider guards and remaining acceptance limits.

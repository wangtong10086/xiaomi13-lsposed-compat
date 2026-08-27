# Source provenance

- Canonical module sources are Apktool 3.0.3 projects reconstructed from the final locally validated APKs.
- `camera-native-hook` and `market-download-compat` were authored as compact smali modules for the observed Android 16 compatibility gaps.
- `miui-intent-fix` was preserved as exact smali plus a non-canonical JADX reference view.
- APK signatures and signing keys are intentionally excluded. Rebuilding changes the signing certificate unless the original private key is supplied externally.
- Empty Apktool resource package metadata produced by decoding resource-minimal APKs was normalized to the manifest package so Apktool 3.0.3 can rebuild with `aapt2`.
- Xiaomi, Android, Magisk, LSPosed, Vector, and app binaries are not vendored.

The checked-in scope files are part of the review surface. Expanding a scope should be treated as a security-sensitive code change.

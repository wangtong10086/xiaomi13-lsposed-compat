# Contributing

[简体中文](CONTRIBUTING.zh-CN.md)

Contributions must keep every hook minimal, version-locked where necessary, and limited to documented packages/processes.

1. Describe the exact device, ROM, Android, LSPosed, module, and target-app versions. Use public build identifiers only.
2. Explain why the platform or application behavior fails, which method is hooked, and why a smaller scope is insufficient.
3. Treat any `system` hook, scope expansion, signer/version guard removal, token handling, or persistence change as security-sensitive.
4. Do not commit proprietary APK/DEX/framework code, decompiled third-party sources, signing keys, certificates with private keys, registration IDs, tokens, account data, message content, private databases, serial numbers, or raw logs.
5. Preserve compile-only stubs as stubs. Do not package Xposed API classes into an APK.
6. Run PowerShell parsing, the WeChat token-bridge safety test, Java compilation, and relevant Apktool rebuild/install tests.
7. Record SHA-256 and signing-certificate fingerprints for tested APKs, but never publish the private key.

A compatibility issue should include sanitized activation evidence, exact scope, expected/actual behavior, and a clean disable/uninstall rollback result.

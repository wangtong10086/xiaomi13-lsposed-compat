# Xiaomi account, eSE, and wallet gestures

Scopes:

- `com.xiaomi.account`
- `com.android.se`
- `com.miui.tsmclient`
- `com.android.nfc`
- `system`

The module combines related compatibility state that crosses Xiaomi Account, TSM, NFC/eSE routing, and system-server power-key handling. Its gesture state machine waits 300 ms to distinguish:

- double power: Xiaomi TSM quick-card activity;
- triple power: Google Wallet;
- other press counts: leave normal behavior to the system policy path.

The system scope is required for the power-key controller and should not be copied to unrelated packages. The module also contains file-based emergency disable switches under `/data/local/tmp`; inspect the exact names in `XiaomiAccountHook` before an upgrade.

Wallet cards, account tokens, eSE credentials, and app-private databases are not
part of this repository. Preserve existing wallet data during a compatible module
upgrade; a file backup cannot reverse secure-element or remote card operations.

Version 2.3 adds a **小米卡包** launcher entry inside this same package. It opens
the official quick-card screen used by the power gesture. Version 2.6.9 retains the
verified official-wallet separate-UID parser, account compatibility, read-only
signed-key bridge and narrowly scoped transit device-ID mapping. Completed
signature-migration hooks and experimental encrypted-request observations have
been removed from production code.

Build this module with `tools/Build-MiuiIntentFix.py`: it combines the original
smali with Java additions from `compat-src`. The generic Apktool wrapper cannot
build these additions by itself. See [wallet compatibility notes](../../docs/xiaomi-wallet-compat-android16.md)
for the HMA provider exception, existing Magisk module update, signing migration,
validation boundaries and rollback procedure.

The default build excludes `diagnostics-src` and its Xposed entry points. Pass
`--include-diagnostics` with a separate output directory to build reproduction
probes; they still require their individual opt-in markers and exact target
versions. No new Vector module is needed. `stubs` is only for CI compilation and
must never be packaged. Check the final APK with `tools/Check-MiuiIntentFixApk.py`
(add the same diagnostic flag when checking that variant).

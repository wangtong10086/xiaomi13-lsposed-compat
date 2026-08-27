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

Wallet cards, account tokens, eSE credentials, and app-private databases are not part of this repository and should be re-provisioned through the corresponding service.

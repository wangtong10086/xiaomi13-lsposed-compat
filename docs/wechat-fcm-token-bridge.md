# WeChat native FCM token bridge

This module is a bounded repair and diagnostic aid for the reviewed Google Play WeChat 8.0.72 build (`versionCode=3085`) on the Xiaomi 13 Android 16 configuration. It is not a generic WeChat hook. Both the version code and Tencent signing-certificate SHA-256 must match before any hook is installed.

## Root cause and repair

The Firebase client had a current token and WeChat had an equal stored registration token, while Google Play services reported an available FCM transport. WeChat's registration entry therefore returned through its equal-token short circuit and did not send scene 216 (`/cgi-bin/micromsg-bin/androidfcmreg`) again. A one-shot repair marker makes the stored-token getter appear empty only on the thread invoking WeChat's own registration method. The original method then dispatches scene 216 and persists a successful result itself.

The module never deletes the Firebase instance ID, logs or hashes a token, writes WeChat storage, reads a message value, or changes package stopped state. Its message-callback trace records only whether a payload exists and the number of data keys.

## Build and static validation

Build with `tools/Build-XposedJavaModule.ps1`, using `modules/wechat-fcm-token-bridge` as the module directory and external signing inputs. Then run:

```powershell
./tools/Test-WeChatFcmTokenBridge.ps1
```

The static test checks the exact package/version/signer guards, the single-package scope, the expiring control marker, thread-local override, metadata-only logging, and forbidden storage/token operations.

## Device workflow

Audit or install observation mode first:

```powershell
./tools/Repair-WeChatFcmBinding.ps1 -Serial '<adb-serial>' -AdbPath '<adb.exe>'
./tools/Repair-WeChatFcmBinding.ps1 -Observe -Serial '<adb-serial>' -AdbPath '<adb.exe>' -Apply
```

Enable exactly `com.tencent.mm/0` through the installed LSPosed/Vector CLI, then reboot once if a newly installed module was not injected. Observation must show an accepted guard and equal, present current/stored tokens without printing either value.

Arm the one-shot native registration only after that observation:

```powershell
./tools/Repair-WeChatFcmBinding.ps1 -Rebind -Serial '<adb-serial>' -AdbPath '<adb.exe>' -Apply
```

Success requires `event=scene216_result outcome=success`. The controller removes the marker after acceptance and again in `finally`, returns home, and uses only `am kill`. It does not use `force-stop` or `pm clear`.

## Delivery validation and rollback

A successful scene 216 response is not delivery proof. With Thanox delegation disabled, establish `process_count=0` and `stopped=false`, send a numbered message, and require all of the following:

- a fresh FCM transport timestamp;
- `event=fcm_message_callback outcome=completed throwable=false`;
- exactly one user-visible notification whose click opens the correct conversation;
- no WeChat process three minutes after processing.

If the WeChat version or signer changes, disable the module and re-review the private call graph before updating any lock. To roll back the module itself, disable it with the official LSPosed/Vector module command and reboot; do not edit the module database directly. Restoring the pre-install module database backup is an offline recovery path only.

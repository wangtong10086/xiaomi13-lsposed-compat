# Feishu MiPush token bridge

## Failure boundary

On Feishu 7.75.15 (`com.ss.android.lark`), the external MiPush module successfully produced a non-empty XMSF registration ID and XMSF maintained its port 5222 connection. Messages still did not arrive while every Feishu process was absent. Opening Feishu fetched the same message immediately through its foreground channel.

Decompilation of the locally installed base APK showed that Feishu's normal Xiaomi registration callback continues with:

```text
MIPushMessageHandler.onCommandResult(...)
  -> PushSupporter.thirdService()
  -> registerSenderSuccessAndUploadToken(context, MiPushAdapter.getMiPush(), regId)
```

The external MiPush module's forced-registration path stopped after obtaining the registration ID. Its ByteDance `/cloudpush/update_sender/` compatibility hook targets the legacy `AppLogNetworkClient` class and emitted no hook or cloud-push events on this Feishu build. Registration at XMSF therefore did not prove that Feishu's server knew the token.

Reference APK used for control-flow review only:

- version: Feishu 7.75.15;
- base APK SHA-256: `50D144D21151BA76EADA039C0D01AE3B229A5B38F494AFD99223E89583DAB3E1`;
- the APK is not included in this repository.

## Repair

`lark-mipush-token-bridge` is a legacy Xposed/LSPosed module scoped only to `com.ss.android.lark`. It ignores Feishu subprocesses, waits for a non-empty registration ID, then invokes the same Feishu-owned callback shown above. It does not implement its own upload protocol and does not log or persist the token.

The callback is attempted once per main-process lifetime. Readiness failures are retried for at most one minute. A successful in-process invocation produces:

```text
LarkMiPushTokenBridge: Feishu server token-binding callback completed
```

This log proves method completion, not end-to-end message delivery.

## Validation

1. Install the signed module, enable it, and set the only scope to `com.ss.android.lark/0`.
2. Start Feishu once and wait for the completion log.
3. Return home and terminate all Feishu processes without force-stopping the package. Confirm `stopped=false`.
4. Send a unique numbered message from another active session.
5. Without opening Feishu, require both a new XMSF receive event and a user-visible notification or a newly started Feishu receiver process.
6. Repeat after reboot and after a network transition. Do not treat foreground synchronization as a push success.

Re-review class and method names after every Feishu update. Disable this module if Feishu restores its complete native Xiaomi registration path.

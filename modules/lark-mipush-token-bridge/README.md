# Lark MiPush Token Bridge

Scope: `com.ss.android.lark` main process only.

Feishu 7.75.15 contains a complete Xiaomi push adapter, but the external MiPush compatibility module can register with XMSF without invoking Feishu's business callback. This module waits for a non-empty `MiPushClient.getRegId(...)`, then invokes Feishu's own `PushSupporter.thirdService().registerSenderSuccessAndUploadToken(...)` method.

The token is neither logged nor persisted by this module. The callback is attempted once per Feishu main-process lifetime and retried only while required classes or the token are not ready.

Re-review after Feishu updates because the bridge deliberately targets private implementation classes.

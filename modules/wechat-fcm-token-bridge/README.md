# WeChat FCM Token Bridge

Scope: `com.tencent.mm` main process only.

This module is locked to the reviewed Google Play WeChat 8.0.72 build
(`versionCode=3085`) and Tencent signer SHA-256
`0fe4ff85c215918396dadc7cd8ce6963339af33d37751a56e54c7206b63a3c7c`.
It observes WeChat's native Firebase initialization, token registration, scene
216 result, and message callback without logging tokens or payload values.

The optional repair is armed only by an unexpired
`/data/local/tmp/wechat-fcm-token-bridge/rebind.once` marker. When the current
Firebase token equals WeChat's stored registered token, the module makes
`x82.f.b()` return an empty value only on the current thread while invoking
WeChat's own `x82.b.c(currentToken)`. This selects WeChat's existing
`/cgi-bin/micromsg-bin/androidfcmreg` scene 216 branch. It does not delete the
Firebase instance ID or directly write WeChat storage.

Disable and re-review the module after any WeChat update. A successful scene
216 callback proves only Tencent registration RPC completion; downstream FCM
delivery still requires a separate end-to-end test.

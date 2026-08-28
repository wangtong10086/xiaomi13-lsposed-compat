# XMSF registration compatibility on Android 16

This note records a bounded registration audit on Xiaomi 13 (`fuxi`), Android 16, Vector 2.2, MiPushFramework/XMSF 0.6.1, and the MiPush Xposed module 0.6.1. It contains no device serial, credentials, tokens, registration IDs, private databases, or application data.

## Acceptance boundary

A target is registered only when all of the following are true:

1. the application reports or persists a non-empty MiPush regId;
2. XMSF records a new `EVENT` row with `type=21` and `result=0`;
3. `REGISTERED_APPLICATION.registered_type=1` remains true after the temporary scope is removed and the original root-hiding state is restored.

An XMSF `type=2` event is only a dispatched attempt. An established TCP 5222 socket proves transport health, not application registration or notification delivery.

## Reviewed targets

| Package | Observed result | Compatibility boundary |
| --- | --- | --- |
| `com.anjuke.android.app` 322403 | registered; delivery pending | Its private `mipush` preferences already held app-owned credentials but no RegID. The bounded module called the app's own SDK, after which XMSF recorded `type=21/result=0`, the app persisted a RegID, and `registered_type=1` remained true after scope and denylist restoration. |
| `com.lietou.mishu` 13081 | not registered | Neither static dex inspection nor a bounded runtime ClassLoader trace found `MiPushClient`. No registration row was fabricated. |
| `com.ss.android.ugc.aweme` 400201 | not registered | The installed APK has 56 dex files but no `MiPushClient` definition. A 60-second runtime ClassLoader trace with stock MIUI properties also found no dynamically loaded SDK. The installed Vector profile contains a credential override, but credentials alone cannot create a working receive chain when the app build does not load the SDK. |
| `com.MobileTicket` 280 | not registered | The protected app exposed `MiPushClient` after startup, but no app-owned credential metadata or private preference appeared and the app issued no native registration during the bounded window. |
| `cn.gov.tax.its` 20303 | not registered | The protected app exposed `MiPushClient`, but neither its native path nor the exact-version compatibility window produced app-owned credentials or a registration request. |
| `com.chinamworld.main` 2351 | not registered | The protected app exposed `MiPushClient`, but neither its native path nor the exact-version compatibility window produced app-owned credentials or a registration request. |
| `com.eg.android.AlipayGphone` 212210 | registered; XMSF-to-app downlink verified | The compatibility module exposed stock `V816/816` values only in a one-shot registration window, resolved credentials through Alipay's own metadata helper, and called its bundled MiPush SDK. A fresh `type=21/result=0`, registration-time app-private RegID, native callback, and token-binding callback were observed. With temporary scope already removed and the original denylist restored, a later backend send produced XMSF `type=0/result=0` and started/reached the Alipay processes. A UID-checked system-server guard prevents Alipay from disabling only its Xiaomi receiver and two message handlers. |

No target app credential value was guessed, copied into source, or logged. For the exact reviewed Douyin build, the bounded bridge can read the matching public compatibility profile from the installed Vector 0.6.1 APK, but the value never leaves the target process and no registration was attempted because the SDK was absent. No XMSF registration or event row was inserted or edited.

## Vector 0.6.1 dispatch finding

The installed Vector module was loaded into dynamically scoped third-party processes, but its `FakeDevice` and force-register hooks did not run. Source and installed-bytecode review showed why: the libxposed entry's current-process resolver covers its fixed system/XMSF targets, while arbitrary third-party apps depend on later package callbacks. With dynamic scope loading, that callback may already have passed. The compatibility module therefore performs only a root-marked, exact-version one-shot action; it does not replace or permanently widen Vector.

## Safe registration window

Use `push/Register-XmsfTarget.ps1` for the general audit. Use `push/Repair-XmsfAppRegistration.ps1` only for a reviewed package/version. Both tools are read-only by default; the repair workflow creates private backups and restores every exact target-package denylist entry plus temporary compatibility scope in `finally`. `push/Register-XmsfViaVector.ps1` is retained as a fail-closed diagnostic reproducer for the Vector dispatch issue, not as the preferred repair path.

Do not add `com.miui.nextpay` or `com.xiaomi.payment`: they are internal Xiaomi payment helpers rather than user-facing notification targets. Do not disable Shamiko, Zygisk Assistant, or the global hiding stack to make registration easier.

## Remaining boundaries

- Dynamic ClassLoader observation and Android 16 MIUI property-return hooks are implemented only inside the root-marked process lifetime.
- Apps without an SDK or app-owned credential source cannot be made into valid XMSF clients by inserting database rows, borrowing another app's SDK, or transplanting another package's credentials.
- For apps without manifest/private credentials, invoke only the application's own credential flow. Do not commit app IDs, app keys, RegIDs, or server tokens.
- Extend the compatibility module one reviewed package/version at a time; never turn the seven-package audit allowlist into a shared credential or generic force-register profile.

After any compatibility-module change, repeat the three registration checks, reboot once, restore hiding, and then run a numbered offline delivery test. Registration and real notification delivery are separate milestones.

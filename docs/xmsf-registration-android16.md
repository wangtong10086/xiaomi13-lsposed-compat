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
| `com.anjuke.android.app` | not registered | MiPush SDK was visible, but the force-register resolver found no standard credential metadata. The app also gates its native Wuba MiPush path on `ro.miui.ui.version.name`; presenting the stock `V816` value for one process lifetime did not cause its server-provided access info to arrive. |
| `com.lietou.mishu` | not registered | Vector injected the main process, but the MiPush module did not find an eligible SDK in that process class loader. |
| `com.ss.android.ugc.aweme` | not registered | The dedicated Douyin profile loaded, but `MiPushClient` remained in an unloaded dynamic dex through all eight bounded retries. |
| `com.MobileTicket` | not registered | Vector injected the main process, but the automatic profile did not find an eligible SDK in that process class loader. |
| `cn.gov.tax.its` | not registered | The tax fallback ran, but its Android 16 property compatibility path failed while treating `ro.build.hw_emui_api_level` as a field. No standard MiPush credential metadata was available. |
| `com.chinamworld.main` | not registered | MiPush SDK detection reached the force-register path, but no standard credential metadata was available. |
| `com.eg.android.AlipayGphone` | partial only | Forced `registerPush` calls produced repeatable XMSF `type=21/result=0` and `registered_type=1` after one soft XMSF reconnect. The app's private `mipush.xml` still had no regId, so this does not meet acceptance. Temporarily enabling the Xiaomi receiver and two message-handler services produced another successful XMSF result but still no private regId; the original disabled-component state was restored. |

No target app credentials were guessed, extracted into source, logged, or reused. No XMSF registration or event row was inserted or edited.

## Safe registration window

Use `push/Register-XmsfTarget.ps1` from the `xiaomi13-lineage-customization` repository. The tool has a fixed seven-package allowlist, is read-only by default, and restores both the exact main-process denylist entry and the original MiPush module scope.

Do not add `com.miui.nextpay` or `com.xiaomi.payment`: they are internal Xiaomi payment helpers rather than user-facing notification targets. Do not disable Shamiko, Zygisk Assistant, or the global hiding stack to make registration easier.

## Required future fixes

- Add dynamic class-loader observation for applications that load `MiPushClient` after the initial application class loader, while keeping hooks package-specific.
- Replace the tax fallback's invalid Android 16 field mutation with a reviewed property-return hook.
- For apps without manifest credentials, invoke only the application's own credential flow. Do not commit app IDs, app keys, regIds, or server tokens.
- For Alipay, trace the registration-result delivery from XMSF into its `:push` process before changing component state again. `registered_type=1` alone is not sufficient.

After any compatibility-module change, repeat the three registration checks, reboot once, restore hiding, and then run a numbered offline delivery test. Registration and real notification delivery are separate milestones.

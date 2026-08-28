# XMSF app registration compatibility

Steady-state scope: `system` and `android`. A reviewed application is added only by the bounded host workflow and removed afterward.

The module is inert unless one of these root-controlled one-shot files exists:

- `/data/local/tmp/xmsf-app-registration-compat/<package>.register.once`
- `/data/local/tmp/xmsf-app-registration-compat/<package>.unregister.once`

During that bounded process lifetime it can expose the stock `fuxi` MIUI version properties (`V816` / `816`), observe dynamically loaded MiPush SDK classes, and call only the target application's own SDK. Alipay resolves credentials through its own metadata helper. Anjuke uses its existing app-private credential preferences. The exact reviewed Douyin profile may resolve its public compatibility credential from the separately installed Vector 0.6.1 APK through a root-created symlink; no credential value is copied into this repository, logged, or persisted by the module.

| Package | Version code | Mutation outcome |
| --- | ---: | --- |
| `com.eg.android.AlipayGphone` | 212210 | registered; token binding and later XMSF-to-app downlink verified |
| `com.anjuke.android.app` | 322403 | registered; delivery test pending |
| `com.ss.android.ugc.aweme` | 400201 | reviewed but not registered; SDK absent at rest and runtime |
| `com.MobileTicket` | 280 | reviewed but not registered; app-owned credential unavailable |
| `com.lietou.mishu` | 13081 | reviewed but not registered; SDK unavailable |
| `cn.gov.tax.its` | 20303 | reviewed but not registered; app-owned credential unavailable |
| `com.chinamworld.main` | 2351 | reviewed but not registered; app-owned credential unavailable |

The `android` scope installs one permanent fail-closed guard in system server. It rejects component-disable requests only when the remote caller identifies as Alipay, has an application UID, and targets one of the three reviewed Xiaomi callback components. Root, shell, system, other packages, other Alipay components, and enable/default-state requests are not intercepted.

Use the host-side `Repair-XmsfAppRegistration.ps1` workflow. Do not create a marker or Vector-path symlink manually: the workflow is responsible for backups, component state, all target-package Magisk denylist entries, temporary scope, stopped state, and marker removal.

This build deliberately fails closed on every unreviewed package version. A package is not considered registered unless XMSF returns a new successful registration result, `registered_type=1` persists, and the application has a RegID. No code path writes those database facts directly.

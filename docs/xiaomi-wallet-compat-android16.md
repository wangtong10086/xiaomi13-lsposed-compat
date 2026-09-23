# 小米卡包：Android 16 兼容修复

目标设备为 Xiaomi 13（fuxi）、Android 16、Magisk 30.7、Vector 2.2（3080）。
本次沿用 `miui-intent-fix` 与 `xiaomi_tsm_privapp_fix`，不新增模块 ID。

**当前仍未完成全部修复。** 2026-09-24 已在用户授权后将 Debug 签名版 1755
迁移为官方签名版 1835，保留原 UID 和数据目录；迁移后银联初始化和芯片比对均返回成功；撤除银联观测注入及修复延迟强杀后，
用户进一步确认银行卡已能正确添加。交通卡设备标识兼容处理后，用户确认云端
交通卡已移入成功；新开卡订单接口也返回成功，但不等于付费发行完成。云端门卡尚未验收。

## 现象与证据

| 现象 | 已定位的阻断点 | 处理位置 |
| --- | --- | --- |
| 没有正式应用图标 | TSM APK 未声明 MAIN/LAUNCHER 入口 | 现有 Vector 组件增加转发 Activity |
| NextPay 打开银行卡流程时崩溃 | `Phone.getCplc` 访问 `NPProvider`，缺少 `com.miui.tsmclient.permission.CONTENT_PROVIDER` | 现有 TSM Magisk 模块挂载原签名 NextPay 为特权应用 |
| 卡片会话报错 15 | HMA 将 VAID Provider 所在包隐藏，TSM 得到空设备标识 | 仅修改 TSM 的 HMA 模板引用 |
| 后台服务崩溃 | `AutoRechargeService` 写 `persist.nfc_cfg.selectcard` 被 SELinux 拒绝 | 原 Magisk 模块的 NFC 属性规则 |
| 支付组件准备报错 10 | AOSP SecureElement 不支持 OEM `getSpiSignedPK` 入口；MTD 启动标签/策略缺失 | 原 Vector 组件桥接只读入口，原 Magisk 模块恢复 OEM 服务 |
| 快速添加银行卡无反应 | 银联初始化回调 `1000111109`，权限校验失败；旧 TSM 使用 Debug 签名 | 官方版初始化及后续芯片比对均返回 `0000`；用户确认银行卡已能正确添加 |
| 交通卡移入与新开卡后端 201 | 两条业务请求的设备标识不兼容；原值为 UUID 形态的 41 字符 deviceId | 原模块内仅对两条请求做稳定的 21 字符映射；两接口均返回 200，用户确认云端卡已移入 |
| 旧预加载确认逻辑错误 | 成功预加载确认被改成最终移入确认 | 已撤掉改写；它不是官方 1835 后续 201 的充分解释 |

原失败版本：TSM 25.06.13.1.f / 1755；迁移目标：25.10.14.1.f / 1835。
NextPay 保持 24.04.23.1 / 1470。
旧 TSM APK 并非官方原签名包：SHA-256 为
`c48ba0c5686e879c49416f0be3d18ae840e2f255f406345eab26e95bbe785e5c`，
签名证书 SHA-256 为
`5e645e27fe93cc2c0e8fca507cce0b99479bd94cca89b54568c294fb77ef357d`，
DN 为 `CN=Android Debug, O=Android, C=US`。这份安装包在本次修复之前已存在；
本次没有重签名或卸载 TSM。NextPay 则已单独确认保留小米原签名。
手机上的 `com.miui.securitycenter` 是现有版本 0.2 的兼容 Provider 组件，
不是完整的小米安全中心。它已经实现 `/vaid`，本次没有修改其标识生成算法。

### VAID 因果链

`DeviceInfoImpl.getDeviceId` 调用 `IdentifierManager`，经
`IdProviderImpl.getVAID` 查询 `content://com.miui.idprovider/vaid`。
TSM 的 HMA `root_tools` 模板包含了 `com.miui.securitycenter`，因此系统虽然
注册了 Provider，TSM 仍记录 `Failed to find provider info` 并得到空值。
`DeviceUtils.g` 将空值传入会话创建方法；其空值分支在请求发送前抛出错误 15。

修复保留原 `root_tools`，派生 `root_tools_wallet_compat`，只删除 Provider
所在包，并且仅将 TSM 切换到派生模板。原银行应用的作用域和模板保持不变。
`tools/Repair-WalletHmaConfig.py` 可以从导出的配置生成这一修改；输出文件应
保存在仓库之外。原模板发生变化后应重新运行，刷新派生模板。

通过恢复隐藏、再次放行的对照验证 Provider 可见性。诊断直接在 TSM 进程
读取本地 VAID，避免为了测试标识而发起开卡。只记录空值/长度，不记录标识。

| 单项对照 | Provider 缺失日志 | VAID | TSM 设备标识 |
| --- | --- | --- | --- |
| 恢复原隐藏模板 | 3 次 | null | null |
| 仅放行 Provider | 0 次 | 长度 36 | 长度 41（含 `vaid_` 前缀） |

两轮冷启动均无进程崩溃，其他应用的 HMA 配置与备份一致。

用户发起的一次交通卡移入已经进入会话和预加载阶段，预加载返回 `resultCode: 0`；
这不等同于完整移入完成。中间账户读取异常被现有缓存恢复，不能单凭该异常
堆栈判定最终操作失败，也不需要据此伪造账户校验结果。

### 支付准备：本机签名公钥的两个阻断点

调用链为 `h1.j → z5.e.z → z5.a.b0 → h6.f.y → b3.q → s6.f.b().e()`，
最终调用 `MiNfcAdapter.getSpiSignedPK`。OEM 框架用 ASCII `getSpiSignedPK`
作为虚拟通道标识；AOSP 实现把它当作真实 AID 发往安全芯片，导致通道打开失败。
新增 `WalletSignedKeyBridge` 仅在指定 SecureElement APK 哈希匹配时工作，
限定 TSM 包/调用 UID、eSE1、空读取请求和通道所有者 UID/PID。虚拟通道只调用
真实厂商 HAL 的 `FFFFABCD` 读取入口，不构造密钥或签名，不改普通 APDU 通道。

第一轮桥接到达 HAL 后，仍因 OEM MTD 服务不存在而返回空设备标识和无效签名。
开机日志证明 `/odm/bin/mtd@1.3` 被标为 `vendor_file`，无 init 域转换，无法启动。
为未修改的 OEM 程序恢复独立进程域、执行标签和必要权限后，服务成功注册，
真实 TEE 返回设备标识及非零 DER 签名。整个过程保持 SELinux Enforcing。

桥接初版又暴露一个协议判断错误：该 HAL 返回 ASCII 参数文本，并非带 `9000`
状态字的普通 APDU。修正后按厂商接口原样返回文本；结构检查只拒绝缺失、重复字段、
空标识、错误 Base64 或无效 DER，不声称完成密码学验签。最终真实性仍由原服务器
校验。2026-09-24 03:55 本地只读测试得到长度 357；03:57 用户触发的实际流程中，
两次 `preparePayApplet` 最终返回 0，原 `signedPK is null` 不再出现。

### 银联初始化：旧签名失败与官方包迁移

修复本地签名读取后，用户仍报告快速添加无反应。同期回调仍是
`1000111109`（初始化接口 `10001`、错误来源 `1`、权限错误 `1109`）。
静态代码表明：UnionPay 服务从 Binder 调用 UID 获取包名，再计算已装 APK 的
证书 SHA-1，作为 `UPAddonInitParam.hostHash` 发往初始化服务。
旧版签名与小米官方签名不同，是强嫌疑，但在完成请求观测或原签名包对照前，
不能把“签名不同”写成已经充分证明的唯一原因，也不能把失败阶段笼统称为 InfoCompare。

04:08 的只读探针补齐了运行时证据：两次 `init` 都观测到
`signer=installed-debug`，返回 `resp=1109, threw=false`，没有进入 InfoCompare。
因此可确定权限拒绝发生在携带 Debug 证书摘要的远程初始化请求上，而不是之后的
芯片比对。仍需官方签名包对照，才能排除服务端其他白名单条件。

04:41，用户复测路径中的真实请求观测到 `signer=official-xiaomi`，初始化
返回 `resp=0000`，随后首次进入 InfoCompare，仍返回 `resp=0000`，两者均无异常。
因此官方包迁移排除了原初始化权限阻断，真实芯片比对也通过；没有伪造响应或跳过
服务器检查。替换同时将版本从 1755 升到 1835，因此这不是只改变证书的单变量
实验，不能据此排除全部版本差异。银行卡发行及用户页面结果仍需单独验收。

| 实际请求对照 | 请求签名分类 | 初始化响应 | 后续芯片比对 |
| --- | --- | --- | --- |
| 旧 1755，04:08 | installed-debug | 1109 | 未进入 |
| 官方 1835，04:41 | official-xiaomi | 0000 | 0000 |

本地另有来自原厂 ROM 的官方 1835 包，其证书 SHA-256 为
`c9009d01ebf9f5d0302bc71b2fe9aa9a47a432bba17308a3111b75d7b2149025`。
它声明 `android.uid.nfc` 共享 UID；当前移植包去掉了该声明。因此恢复官方包还
需要解决 ROM 的共享 UID/签名迁移与版本兼容问题，不能简单覆盖或清空应用数据。

迁移期间的 `WalletOfficialPackageCompat` 曾实现默认关闭的迁移入口：
限定当前 framework/services JAR 哈希、TSM 包名和已核验官方 1835 APK 哈希，
只在解析该 APK 时保留独立 UID，不让它加入 NFC 的共享 UID。签名迁移还要求
独立的 root 所有、不可被组/其他用户写入的标记，内容为不超过未来 15 分钟的
Unix 到期时间。仅接受已知旧 Debug 证书向真实小米证书的单向迁移，且排除共享 UID，
保留正常安装、数据及权限处理。它不向银联报告假证书、不接受任意 APK 签名。
正式迁移必须同步替换原 Magisk 模块内的 TSM 系统副本，避免下次启动与数据分区
签名冲突；需保留完整 APK/应用数据备份并单独验收，不得只覆盖数据分区 APK。

启用标记：`/data/local/tmp/xiaomi-wallet-official-package.enabled`；
短期迁移标记：`/data/local/tmp/xiaomi-wallet-signature-migration.enabled`。
迁移钩子还要求在 system_server 加载时存在 root 所有的
`/data/local/tmp/xiaomi-wallet-migration-support.enabled`；删除并重启后，仅安装
独立 UID 解析钩子，不再安装签名校验相关钩子。短期标记必须使用系统可读的
`system_data_file` 标签；不为此扩大 system_server 对临时文件类型的读取权限。
用户已明确允许官方卡包迁移和重启。更换签名后不能假设 AndroidKeyStore 和历史卡片状态能够
靠文件备份完整回滚；不得自动卸载、清空钱包或承诺无损迁移。

以下记录迁移准备阶段曾处理的两类独立检查；30 版已删除这些一次性钩子，
现在只保留按原框架及官方 APK 哈希校验的独立 UID 解析器：

- 仅在 `InstallPackageHelper.preparePackage` 当前线程正在处理指定官方 APK、
  且短时标记有效时，接受两张已知证书之间的更新能力检查（1/8）。不改变共享 UID
  能力（2）或通用权限签名能力（4）。线程状态在方法返回/异常时清理。
- 自定义权限归属只接受“当前钱包重新声明自己已有的权限”，要求新旧包名均为
  `com.miui.tsmclient`，原证书和新证书均匹配，并且新包使用独立 UID。
  不改变权限保护级别、其他权限所有者或预先改写已安装包的签名。

已记录的安装准备对照：无短期标记时，官方包被正常签名检查拒绝；标记文件标签错误
时，迁移守卫拒绝；未处理同包权限归属时，被 `MIPUSH_RECEIVE` 声明冲突拒绝。
各次失败后，卡包版本仍为 1755，签名仍为原 Debug 证书，UID/数据目录所有者仍为
10264。最终核对阶段另发现 disabled-system 记录没有签名，按原框架对
`SigningDetails.UNKNOWN` 的处理补齐分支，不接受任意不同证书。

2026-09-24 04:35，官方 APK 覆盖安装返回 `Success`，已安装 APK 的 SHA-256
与源官方包一致，版本为 1835，数据目录所有者仍为原 UID 10264。同步替换了
原 Magisk 模块中的系统 APK，并删除短期迁移标记和迁移钩子启动标记。
04:37 重启日志确认 `migration hooks absent`，仅保留指定官方 APK 的独立 UID
解析兼容。发现系统副本仍命中旧 1755 的解析缓存后，备份并仅删除
`/data/system/package_cache/*/MiuiTsmClient-*` 对应的单个缓存，再次启动扫描；
这与清空应用数据无关。应用、卡片及密钥状态仍需分别验收，不把目录保留等同于完整功能正常。

官方 1835 的账户类从 `w4.*` 改为 `x4.*`。`WalletOfficialRuntimeCompat`
锁定官方 APK 哈希，使用新类名恢复原有账户元数据兼容；同账户现有 token 缓存才可
复用。官方版本跳过旧版混淆类钩子，避免把旧类名套用到不相干的新类上。
元数据仍来自正常账户服务或本机已有授权缓存，不构造账户凭据。

### 迁移后：人脸风险提示与银行卡最终验收

用户反馈已经越过原卡住位置，完成自行发起的人脸流程后提示设备存在风险。
当前前台属于 `com.unionpay.tsmservice.mi/.activity.RealNameAuthActivity`；
尚未取得准确错误码，不能把它与旧初始化 `1109` 混为同一故障。

静态分析区分两条后续链：

- 卡包 `a6.y` 创建实名参数时调用 `RootUtils`（`m2.d()`）。本次日志中三项
  基础检查均为 false；这只说明该组检查的结果，不代表所有设备完整性检查通过。
- 银联 `UPBioManager` 根据服务端配置启动百度昊天 `HTH`，通过
  `devRiskParamDownload → HTH.getSafeData → devRiskAnalyze` 进行设备风险分析，
  另有活体检测及最终 `base/mobile/facecheck`。精确失败节点仍需错误码或仅记录
  阶段/结果的观测，不能开启会输出身份资料、照片 token 和设备安全数据的全量 SDK 日志。

初始化观测本身曾临时向银联进程注入 Vector 模块，也可能影响后续环境检测。
已删除观测标记，撤回银联临时作用域，并结束旧银联进程，恢复原五个作用域。
没有伪造设备风险、活体或实名校验结果。随后用户确认银行卡已能正确添加，
这项功能按用户实际结果验收。由于撤除观测和修复延迟强杀发生在同轮，且未取得
风险提示的准确错误码，不能反推已单独证明是哪一项消除了此前的人脸风险提示。

### 支付准备 1010033：旧启动脚本定时杀掉 SecureElement

同轮 `preparePayApplet` 出现 `1010033`（通用系统错误），堆栈进入
`android.se.omapi.Channel.transmit` 并出现无消息的 `IllegalStateException`。
当前框架在 Binder `RemoteException` 时转换为该异常；这不等同于设备风险提示。

04:41:45.389，系统记录 `com.android.se`（PID 4330）死亡；退出记录为
`SIGNALED / status=9`，并非 Java 崩溃。已有 `/data/adb/service.d/91-esepower-fix.sh`
的日志在同一秒记录 `delayed ... restart`，被杀 PID 同为 4330。脚本开机恢复服务后
另起后台任务等待 75 秒，再无条件 `kill -9` SecureElement，恰好打断在途 APDU。
04:41:45.501 卡包随后报错，因果链与时间、PID 均吻合。

已备份该脚本并仅删除延迟强杀子任务，保留原开机 esepower/HAL 恢复逻辑。
源码为 `device-scripts/91-esepower-fix.sh`，覆盖已有同名脚本，不新增模块。
2026-09-24 04:51 再次重启后，Vector 日志显示兼容组件在初始 SecureElement
进程中加载；开机完成后第 25、55、95、125 秒的 PID 一致，旧延迟窗口已跨过，
启动脚本没有再次记录延迟重启。手机 shell 语法检查和仓库差异检查通过。
这验证了启动脚本修复；还不能替代真实银行卡、交通卡和门卡流程验收。

### 交通卡：撤掉错误的预加载确认改写

03:17 的 `startTransferIn` 返回 `success=false, errCode=201`，同时旧补丁把
`pretransferIn` 改为 `transferIn`，并注入跨请求缓存的订单号。官方逻辑原本跳过
成功预加载阶段的确认；改写会过早上报最终成功，可能污染并发操作。
现已将 `repairShenzhenTransferConfirm` 恢复为空操作，保留其他账户兼容逻辑。
这是已确认的本地缺陷，但截至 05:00 官方 1835 的复测仍失败，当时不能宣称交通卡已修复。

04:59:56，预加载成功后，`transferCard/startTransferIn` 返回业务错误 201。
05:00:30 和 05:00:33，另一条新卡流程的 `sporder/v2/create` 同样返回 201。
对应错误描述为“未知错误”；SecureElement 进程仍是重启后的同一 PID，MTD 正常。
这将当前问题定位到远端业务响应，不能再把它等同于已修复的本机通道中断。

两条入口分别使用 `i5.f` 与 `j6.c/j6.h` 请求实现。前者经 OkHttp 与
`k8.f.b` 加密，响应在 `i5.a.G` 解密后处理；后者经 `k8.f.c/e` 传输。
`WalletTransitDiagnostics` 为指定官方 APK 加入默认关闭的只读观测：仅允许两个
精确 HTTPS 路由，记录公开版本字段、标识长度、账户/凭据是否齐全、设备标识与
本地读取是否一致及数字响应码。标记为
`/data/local/tmp/xiaomi-wallet-transit-diagnostics.enabled`，每进程最多 160 条。
不读取或记录卡号、凭据原值、订单号、响应正文，不修改请求或结果，不自动下单。
探针直接复用卡包原有 Vector 作用域，不向银联或其他应用增加注入。

05:08 本地观测：deviceModel=fuxi，设备标识为长度 41 的 VAID，
miuiSystemVersion=OS3.0.2.0.WMCCNXM，但 hyperOSVersion 为空、romType=OTHER。
05:12 的真实移入请求确认：HyperOS 字段未发送，romType=OTHER；设备标识与本地一致，
账户 cookie 与请求 userId 一致，token/serviceToken/ph 均存在。HTTP 成功，但业务码
仍是 201，响应不含 data/errInfo。字段存在不能证明凭据一定有效，也不能仅据此
认定缺失的版本字段就是 201 的唯一原因。

05:14 已部署并启用 27 版的受控候选：仅在指定官方 APK、fuxi、已有系统版本
恰为 OS3.0.2.0.WMCCNXM、原 HyperOS 字段为空且存在独立启用标记时，
在 d3.c() 返回现有系统版本。Versions.d() 自行计算 ROM 类型。
它不改非空元数据、全局属性、设备标识、账户或服务端响应。
候选标记为 /data/local/tmp/xiaomi-wallet-hyperos-metadata.enabled。冷启动后本地观测
HyperOS 版本已补齐，romType=STABLE；账户字段、设备标识和服务器响应逻辑未变。
候选 APK SHA-256：9d9808341217d316623297180e22ac6439ea0d8eec66786ee6e7640cd97de86c。
A/B 对照分别冷启动卡包，避免静态缓存影响。05:14:33 的真实请求已发送补齐后的
HyperOS 字段和 romType=STABLE，但服务端仍返回 201，且不含 data/errInfo；用户
确认仍显示“未知错误”。因此该候选无效，已删除启用标记并冷启动卡包恢复基线，
未写入 Magisk 开机脚本。29 版已移除该无效实验代码，文档保留负面结果。

该次失败后的 1010033 对应 InterruptedException，发生在接口返回 201 之后；
SecureElement PID 未变。它与此前开机脚本造成的进程退出不同，当前证据更符合
失败后的任务取消，不能倒置因果关系。

### 交通卡：设备标识对照与已验证的移入修复

静态核对原厂 SecurityCenter 的 IdProvider：常规 VAID 由持久化随机密钥与调用方
签名做 HMAC-SHA256，再取 16 位小写十六进制；平台签名分支可读取持久化 VAID。
当前兼容 Provider 0.2 则按包名和 Android ID 生成 36 位 UUID。卡包原样添加
`vaid_` 前缀，因此观测到 41 字符。最初仅凭静态差异，不能证明服务端拒绝该格式。
云端卡片查询在失败前后均有待移入产品；嵌套订单状态为已支付、无需付款。
这些字段仍不能证明订单的所有后台条件均有效。

28 版在现有兼容组件内准备独立开关
`/data/local/tmp/xiaomi-wallet-transit-id-format.enabled`。仅在 fuxi、官方 1835
APK 哈希匹配、方法为 POST、且 URL 精确等于上述两个交通卡接口时，
`WalletTransitIdFormatExperiment` 在原有 `k8.f.b` 加密前复制参数映射，
对符合 `vaid_` 加小写 UUID 格式的 deviceId 去掉连字符并取前 16 位十六进制。
原请求对象、本机 Provider、账户缓存、银行卡接口与 SE 数据不被改写；其余参数
原样保留，由官方实现加密及计算请求签名。日志仅记录路由、长度及加密后解密比对
的布尔结果，不输出任何标识或密钥。

这是请求标识映射，不是恢复原厂 VAID，也不是复现原厂的密钥与签名算法。
长度和标识值同时改变，无法仅凭客户端对照区分服务端长度校验与设备绑定处理，
不能声称掌握服务器内部异常。28 版实验未加入开机脚本，移除标记立即停止
对后续请求的处理。离线 19 项用合成数据验证两条允许路由、拒绝银行及相似 URL、
拒绝未知标识格式、保留其余参数和不改原映射。

05:31 已覆盖安装 28 版并仅启用该格式实验；HyperOS 候选仍关闭。本机只读检查
确认原 deviceId 仍为 41 字符，SecureElement 仍是原 PID，兼容组件原有作用域不变。
Java/D8/Apktool 构建、APK 签名检查、PowerShell 解析、WeChat 安全检查通过。
APK SHA-256：887503586bdc5bc52911b0fe1f7aec2d67920c948f0c372353511a0e265812a7。
05:31:57 的 startTransferIn 与 05:32:57 的 createOrder 均确认加密后的候选标识
比对成功，随后分别返回业务码 200，且带回 data。此时 HyperOS 候选未启用，
账户、芯片、卡包签名及本地 Provider 均未修改。用户随后明确确认“云端交通卡已
移入成功”。新开卡仅确认订单创建成功，未代用户付款或完成发行。

29 版将相同映射整理为 `WalletTransitIdFormatCompat`，额外核对兼容 Provider
APK SHA-256 为 de57aa85d979ca9c801f71737c635df100b21da15408e7ecd35d410a0b25c1de。
未知 Provider 不启用；已有 16 位标识和不匹配格式的标识不处理。原 Magisk 模块
2.4 增加显式配置文件 `enable-transit-id-format-compat`，仅在官方钱包 APK 哈希
匹配时于开机重建运行标记；不增加模块 ID。其余请求的 deviceId 保持原值。
29 版 APK SHA-256：7f8cd964529e382410ff54a5b8017738ff42c9f633d2a38604c70e90031f5f9a。

05:38 已覆盖安装 29 版并更新原 Magisk 模块。冷启动后 providerHashMatched=true，
本机 deviceId 仍为 41 字符，旧 HyperOS 分支不再存在。单独执行开机脚本的标记维护
段，验证删除的运行标记可按配置重建；未重新执行 SELinux/MTD 初始化，未重启整机。
SecureElement 仍为相同 PID，SELinux Enforcing，root、开发者和 ADB 保持开启，
插电常亮设置为原值 0。已关闭临时 WalletTransitDiagnostics，保留兼容处理。
未为了测试正式版再次移出或移入已成功的卡；29 版与成功实验使用同一映射，
新增的是 Provider 哈希限制与持久化配置。整机重启后的端到端验收尚未执行。

关闭方法：删除 Magisk 模块目录中的上述配置文件，并删除
`/data/local/tmp/xiaomi-wallet-transit-id-format.enabled`。下一次请求即恢复原参数；
这不会撤销已完成的卡片移入或恢复服务器状态，不应为了负面对照反复移出已成功的卡片。


## 实现与边界

### 2.6.9 清理版与重启验证

30 版正式 APK 只注册原账户兼容、签名公钥桥接及官方钱包解析三个入口。
钱包/流程/银联/交通卡四组探针移到诊断源码目录，只有显式诊断构建才包含；
正式交通卡处理不再为实验比对额外解密自己的请求。已完成的一次性签名迁移钩子
及其启用分支被删除，独立 UID 解析器、账户逻辑、芯片桥接、交通卡映射及版本
校验保持保留。正式版和诊断版均通过 APK 内容检查，37 项合成数据回归测试通过。

正式 APK SHA-256：d63e567bd3a6b7cdcd7a1cd18ba93dc337f40a93afcc5df3522fad28da87617b，
版本名 2.6.9-cleanup、版本码 30。沿用原维护签名覆盖安装，不卸载钱包或银行应用。
重启后官方钱包的 active/disabled-system 记录仍为 1835，数据 UID 仍为 10264；
两个必要运行标记重建正常、Provider 哈希匹配、MTD running、SELinux Enforcing。
HMA 两份配置、原作用域及 eSE 启动脚本哈希不变；root、开发者模式、ADB 保持开启，
插电常亮仍为 0。SecureElement 跨过旧 75 秒窗口后 PID 稳定。
用户明确确认重启后原银行卡与已移入交通卡均正常显示，未重复开卡、移卡或付款。
相机及 HSBC HK、ZA、渣打均完成冷启动检查，用户进一步确认三家银行登录入口
均正常；仅查看登录页/生物识别提示，未代用户输入资料或验证身份。

清理采用明确清单：手机删除钱包 UI 转储，清空九个可再生的相关日志，释放
577,510 字节；必要解析/交通卡标记和账户 ph 缓存保留。电脑删除 235 个顶层清理
项目（目录内还含子文件），共 482,284,428 字节的旧构建、原始日志、界面转储、
第三方反编译副本及重复分析材料。仓库外保留约 32 MB 的私有最小回滚材料，
包含稳定版 29、当前设备模块/配置、必要迁移前材料及维护签名资料，校验通过。

启用模块数仍为 28 个 Magisk、13 个 Vector，没有新增模块。被禁用并标记删除的
`zn_magisk_compat` 在重启后仍存在；其描述和 ZygiskNext 清理/卸载脚本确认归属于
框架管理的临时兼容状态，保留该目录和框架管理脚本，不把它作为独立的钱包调试
模块强行移除。代理、银行、相机、推送的正式组件及其他项目工作目录不在本次清理范围。

本次 GitHub 交付仅包含源码和脱敏文档；不上传私有回滚材料、诊断日志、密钥或 APK。

### 运行范围

- 正式“小米卡包”入口显式转发到官方 `ui.quick.DoubleClickActivity`，使用
  `ACTION_VIEW` 和固定的 `https://tsmclient.mi.com/swiping` 地址。重复打开保持
  卡包显示；不能直接复用电源双击动作，否则第二次打开会触发关闭。它也不会转到仅显示交通卡列表的入口。
  不接受外部传入的目标组件或转发任意 extras。
- Vector 保留 `system`、`com.android.nfc`、`com.android.se`、
  `com.miui.tsmclient`、`com.xiaomi.account` 五个原作用域。
- NextPay 保留官方 APK、签名、数据及已有更新。其 Provider 权限为
  `signature|privileged`；不取消 Provider 的访问检查，不改为公开 Provider。
- NFC 属性属于 `nfc_prop`。规则允许 `priv_app` 对该属性类型执行必要写入，
  并允许连接属性服务；规则并非按单个应用隔离。没有放开 `default_prop`，
  SELinux 保持 Enforcing。
- 没有新增电话权限，没有修改 Provider 返回的 VAID、IMEI或服务器响应；
  两条交通卡请求内的 deviceId 使用上述兼容映射。卡片操作仍由官方流程执行。
- 下列诊断源码仅在 `--include-diagnostics` 构建中包含，不进入正式 APK。
  `WalletDiagnostics` 默认关闭，锁定 TSM APK SHA-256，仅记录阶段、线程、
  空值/长度及异常类型，最多 200 条事件。启用文件为
  `/data/local/tmp/xiaomi-wallet-diagnostics.enabled`；删除后停止记录，冷启动后
  不安装探针。另有最多 1000 条的流程元数据探针。仅在额外创建
  `/data/local/tmp/xiaomi-wallet-signed-key-read.enabled` 时，才在恢复页面后做一次
  本地 HAL 签名公钥读取；不提交网络请求或开卡。
- `WalletUnionPayDiagnostics` 需独立标记和临时 UnionPay 作用域，锁定服务 APK
  SHA-256。只分类请求中的签名（已装 Debug / 小米官方 / 其他）并读取数字响应码，
  最多 50 条；不修改参数、返回值或回调，不记录正文、账户、卡号或标识。
  观测完成后删除标记、撤回临时作用域并重启相关应用。

持久化复测曾暴露一处策略格式问题：Magisk 需要空格分隔的
`allow source target class permission`，不能照搬 `.te` 文件的 `target:class`。
该版本解析错误甚至返回状态 0，因此不能只检查退出码。最终规则逐条检查解析输出，
并保留原模块的早期 live-policy 加载脚本，重启后还需确认实际应用不再崩溃。

NextPay 在重启后已被系统识别为更新过的特权系统应用，三个原本声明的 TSM
Provider/公共服务/分组权限均已授予。银行卡资料和身份验证由用户自行完成；
用户最新反馈已能正确添加银行卡，助手没有代填资料或执行身份验证。

## 构建

原模块 smali 保持为正式源代码；新增兼容处理使用 `compat-src` 中的 Java，
观测源码单独放在 `diagnostics-src`，正式构建不包含这些类或其 Xposed 入口。
使用 Python 3.9+、JDK、Apktool 3.0.3、Android SDK build-tools 和仅编译用途的
Xposed API 82 JAR：

```sh
python3 tools/Build-MiuiIntentFix.py \
  --apktool /path/to/apktool.jar \
  --android-jar /path/to/android.jar \
  --build-tools /path/to/build-tools \
  --xposed-api /path/to/xposed-api-82.jar \
  --output /private/build/miui-intent-fix
```

签名时再指定 `--keystore` 和 `--alias`，密码通过 `APK_KEYSTORE_PASSWORD`、
`APK_KEY_PASSWORD` 环境变量传递。构建在输出目录合并原 smali DEX 和新增 Java DEX，
不打包 Xposed API。通用 `Build-ApktoolModule.ps1` 会拒绝遗漏 Java 部分的构建。
复现实验时显式追加 `--include-diagnostics` 并使用独立输出目录；它只包含探针，
不会自动创建运行标记、增加作用域、发起网络请求或安装已移除的签名迁移钩子。

Magisk 部分见 `magisk/xiaomi_tsm_privapp_fix/README.md`。其中是对现有模块的
覆盖更新，不是可独立安装、包含专有 APK 的完整模块包。

## 验证与恢复

执行以下本地验证（也已将 Java/合成数据测试接入 `Static (Windows)`）：

```sh
python3 tools/Test-WalletJava.py --android-jar /path/to/android.jar --output ./out/wallet-tests
python3 tools/Check-MiuiIntentFixApk.py /private/build/miui-intent-fix/miui-intent-fix.apk
```

第一项分别编译正式源码、诊断源码及编译桩，执行 4 项 HMA、14 项签名格式和
19 项交通卡请求隔离测试；数据均为合成数据。第二项检查 APK 的真实 DEX 类定义
和 Xposed 入口，拒绝意外打包的探针、Xposed 桩和已完成的迁移钩子；诊断变体检查
须追加 `--include-diagnostics`。还需完成 Apktool 构建、签名校验、Shell/PowerShell
解析和仓库规定的微信桥接安全测试。

设备验收分开记录：桌面入口、权限实际授予、NFC 属性写入、VAID 对照、流程页面、
用户完成的真实开卡/移入结果。重启后重复关键检查，并回归银行登录入口、相机和
Google Wallet。没有完成真实开卡的项目不得写为“已完全修复”。

本机旧兼容模块的原签名私钥未找到。经用户明确授权，采用现有维护密钥对同包名
组件重新安装，并恢复五个原作用域。该操作不卸载 TSM、NextPay 或银行应用。
后续版本使用新维护密钥正常覆盖升级；回退旧签名 APK 需要再次同包名重新安装。

回滚前保留完整旧模块、旧兼容 APK、组件数据及 Vector 作用域备份；HMA 回滚
仅恢复 TSM 的模板引用，避免覆盖用户对其他应用的后续修改。恢复旧 Magisk 模块
后重启。配置/软件回滚不会撤销已经发生的开卡、付款或安全芯片状态变化。

原始日志、标识、账户材料、私钥以及小米专有 APK 均不提交本仓库。

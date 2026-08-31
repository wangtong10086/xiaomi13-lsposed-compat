# Xiaomi 13 LSPosed 兼容模块

[English](README.md) | 简体中文

本仓库包含六个范围严格受限的模块，用于定制 Xiaomi 13（`fuxi`）Android 16 环境中的应用兼容。

> [!WARNING]
> Release APK 是**预发布、精确版本兼容工件**。安装前必须核对文档中的应用/ROM/LSPosed 版本、APK SHA-256、签名证书与 Hook 作用域。不要为了让模块加载而放宽作用域或移除版本/签名守卫。

| 模块 | 作用域 | 用途 |
| --- | --- | --- |
| `camera-native-hook` | `com.android.camera` | 为 Xiaomi Camera 提供 camera2 hidden-API 豁免与 Android 16 `TotalCaptureResult` 桥接 |
| `lark-mipush-token-bridge` | `com.ss.android.lark` 主进程 | XMSF 注册后完成飞书自身的 MiPush token 绑定回调 |
| `market-download-compat` | `com.xiaomi.market` | 恢复 Xiaomi Market 预期的 DownloadManager 文件名 cursor 访问 |
| `miui-intent-fix` | Xiaomi Account、TSM、NFC/eSE 与 `system` | 账户/TSM 兼容、eSE 路由、双击电源 Xiaomi 卡包、三击电源 Google Wallet |
| `wechat-fcm-token-bridge` | `com.tencent.mm` 主进程 | 仅元数据 FCM 跟踪，并通过微信自己的 RPC 做精确版本、一次性 token 注册 |
| `xmsf-app-registration-compat` | `system`/`android`；临时精确应用作用域 | 对审阅过的应用执行有边界的应用自有 XMSF 注册，并保护支付宝回调组件 |

大部分模块是可重建的 Apktool/smali 工程。`xmsf-app-registration-compat` 与 `wechat-fcm-token-bridge` 使用原始 Java 源码及只参与编译、不打包的 Xposed API stub。`reference/miui-intent-fix-java` 是便于导航的非规范 JADX 视图。

## 构建

安装 Java、Apktool 3.0.3 与 Android build-tools。smali 模块可通过以下方式生成未签名 APK：

```powershell
./tools/Build-ApktoolModule.ps1 -ModuleDir ./modules/market-download-compat -ApktoolJar '<path-to-apktool.jar>' -OutputDir ./out
```

签名需要外部 keystore 与环境变量；仓库不保存密钥。Java 模块使用 `tools/Build-XposedJavaModule.ps1` 构建，并需要本地 Android platform/build-tools 与相同的外部签名输入。

## 安装与升级

1. 校验 APK SHA-256 与签名证书。
2. 不复制其他设备的框架数据库，直接安装 APK。
3. 只启用文档规定的作用域。
4. 重启后检查模块激活日志。
5. 同时验证目标功能与同一应用内的无关功能。

本地验证的签名 APK 作为预发布附件提供，校验值见 [RELEASES.md](RELEASES.md)。使用其他密钥重建的 APK 不能视为现有安装的原位升级。

这些模块 Hook 私有实现细节。每次更新 Android、Xiaomi 应用、LSPosed 或 Vector 后都必须重新审阅。Android 16 MiPush 注册矩阵见 `docs/xmsf-registration-android16.md`；它区分模块注入、服务端注册、应用私有 regId 持久化与真实送达，不能把它们当作同一个信号。微信精确版本修复与隐私安全验收见 `docs/wechat-fcm-token-bridge.md`。

## 贡献、安全与来源

提交 PR 前请阅读 [CONTRIBUTING.zh-CN.md](CONTRIBUTING.zh-CN.md)。扩展作用域、移除签名/版本守卫或新增 `system` Hook 都属于安全敏感改动。漏洞请按 [SECURITY.md](SECURITY.md) 私密报告。源码来源及排除内容见 [PROVENANCE.md](PROVENANCE.md)。

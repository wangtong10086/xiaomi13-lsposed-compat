# Security policy / 安全政策

## Reporting / 报告方式

Use GitHub private vulnerability reporting for scope escapes, unsafe `system` hooks, signer/version-guard bypasses, sensitive-data logging, or unintended application behavior. Do not publish a working exploit or private artifact in an issue.

如发现作用域逃逸、不安全的 `system` Hook、签名/版本守卫绕过、敏感数据日志或意外应用行为，请使用 GitHub 私密漏洞报告。不要在 Issue 中公开可用利用方式或私有工件。

Provide the affected commit/release, public version identifiers, exact configured scope, minimal reproduction, impact, and sanitized logs. Never send signing keys, credentials, Firebase/MiPush/XMSF tokens or registration IDs, account data, message content, contacts, device serials, or raw private databases.

请提供受影响提交/Release、公开版本标识、精确配置作用域、最小复现、影响及脱敏日志。切勿发送签名密钥、凭据、Firebase/MiPush/XMSF token 或注册 ID、账户数据、消息正文、联系人、设备序列号或原始私有数据库。

## Supported versions / 支持范围

Only the latest `main` source and explicitly documented prerelease artifacts are reviewed. Each module may support only one exact application/signing lineage; its code guards and module documentation are authoritative.

仅审阅最新 `main` 源码及明确记录的预发布工件。每个模块可能只支持一个精确应用/签名链，其代码守卫和模块文档具有优先效力。

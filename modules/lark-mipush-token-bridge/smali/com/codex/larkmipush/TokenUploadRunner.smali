.class final Lcom/codex/larkmipush/TokenUploadRunner;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private static volatile completed:Z

.field private final application:Landroid/app/Application;

.field private attempts:I

.field private final classLoader:Ljava/lang/ClassLoader;

.method constructor <init>(Landroid/app/Application;Ljava/lang/ClassLoader;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/codex/larkmipush/TokenUploadRunner;->application:Landroid/app/Application;

    iput-object p2, p0, Lcom/codex/larkmipush/TokenUploadRunner;->classLoader:Ljava/lang/ClassLoader;

    const/4 v0, 0x0

    iput v0, p0, Lcom/codex/larkmipush/TokenUploadRunner;->attempts:I

    return-void
.end method

.method private scheduleRetry()V
    .locals 4

    iget v0, p0, Lcom/codex/larkmipush/TokenUploadRunner;->attempts:I

    const/16 v1, 0xc

    if-ge v0, v1, :exhausted

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    const-wide/16 v1, 0x1388

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :exhausted
    const-string v0, "LarkMiPushTokenBridge: token binding not ready after 12 attempts"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method public run()V
    .locals 8

    sget-boolean v0, Lcom/codex/larkmipush/TokenUploadRunner;->completed:Z

    if-nez v0, :return

    iget v0, p0, Lcom/codex/larkmipush/TokenUploadRunner;->attempts:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/codex/larkmipush/TokenUploadRunner;->attempts:I

    :try_start
    const-string v0, "com.xiaomi.mipush.sdk.MiPushClient"

    iget-object v1, p0, Lcom/codex/larkmipush/TokenUploadRunner;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "getRegId"

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/codex/larkmipush/TokenUploadRunner;->application:Landroid/app/Application;

    aput-object v5, v3, v4

    invoke-static {v0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :retry

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :retry

    const-string v1, "com.xm.MiPushAdapter"

    iget-object v3, p0, Lcom/codex/larkmipush/TokenUploadRunner;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    const-string v3, "getMiPush"

    const/4 v5, 0x0

    new-array v6, v5, [Ljava/lang/Object;

    invoke-static {v1, v3, v6}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    instance-of v3, v1, Ljava/lang/Integer;

    if-eqz v3, :retry

    const-string v3, "com.bytedance.push.PushSupporter"

    iget-object v6, p0, Lcom/codex/larkmipush/TokenUploadRunner;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v3, v6}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    const-string v6, "thirdService"

    new-array v7, v5, [Ljava/lang/Object;

    invoke-static {v3, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :retry

    const-string v6, "registerSenderSuccessAndUploadToken"

    const/4 v7, 0x3

    new-array v7, v7, [Ljava/lang/Object;

    iget-object v5, p0, Lcom/codex/larkmipush/TokenUploadRunner;->application:Landroid/app/Application;

    aput-object v5, v7, v4

    aput-object v1, v7, v2

    const/4 v1, 0x2

    aput-object v0, v7, v1

    invoke-static {v3, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/codex/larkmipush/TokenUploadRunner;->completed:Z

    const-string v0, "LarkMiPushTokenBridge: Feishu server token-binding callback completed"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void

    :retry
    invoke-direct {p0}, Lcom/codex/larkmipush/TokenUploadRunner;->scheduleRetry()V
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_all

    return-void

    :catch_all
    move-exception v0

    iget v1, p0, Lcom/codex/larkmipush/TokenUploadRunner;->attempts:I

    const/4 v2, 0x1

    if-ne v1, v2, :schedule_after_error

    const-string v1, "LarkMiPushTokenBridge: first token-binding attempt failed; retrying"

    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :schedule_after_error
    invoke-direct {p0}, Lcom/codex/larkmipush/TokenUploadRunner;->scheduleRetry()V

    :return
    return-void
.end method

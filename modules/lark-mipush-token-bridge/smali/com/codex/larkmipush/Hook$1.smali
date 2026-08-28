.class final Lcom/codex/larkmipush/Hook$1;
.super Lde/robv/android/xposed/XC_MethodHook;

.field private final classLoader:Ljava/lang/ClassLoader;

.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    iput-object p1, p0, Lcom/codex/larkmipush/Hook$1;->classLoader:Ljava/lang/ClassLoader;

    return-void
.end method

.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 5

    :try_start
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    instance-of v1, v0, Landroid/app/Application;

    if-eqz v1, :return

    check-cast v0, Landroid/app/Application;

    new-instance v1, Lcom/codex/larkmipush/TokenUploadRunner;

    iget-object v2, p0, Lcom/codex/larkmipush/Hook$1;->classLoader:Ljava/lang/ClassLoader;

    invoke-direct {v1, v0, v2}, Lcom/codex/larkmipush/TokenUploadRunner;-><init>(Landroid/app/Application;Ljava/lang/ClassLoader;)V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    const-wide/16 v2, 0x1388

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    const-string v0, "LarkMiPushTokenBridge: token binding scheduled"

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_all

    :return
    return-void

    :catch_all
    move-exception v0

    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    return-void
.end method

.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installSystemPowerWalletGestureHook(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 173
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 213
    :try_start_0
    const-string v0, "xiaomi_power_wallet_decision"

    .line 214
    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getObjectExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    .line 216
    if-eqz v0, :cond_1

    iget-boolean v0, v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->consumePowerKey:Z

    if-nez v0, :cond_0

    goto :goto_0

    .line 219
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    const-string v1, "value"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->setBooleanField(Ljava/lang/Object;Ljava/lang/String;Z)V

    .line 220
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 224
    goto :goto_1

    .line 217
    :cond_1
    :goto_0
    return-void

    .line 221
    :catchall_0
    move-exception p1

    .line 222
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "system power gesture interception failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 223
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 225
    :goto_1
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6

    .line 177
    :try_start_0
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$200()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 178
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$300()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    move-result-object p1

    const-string v0, "hook_disabled"

    invoke-virtual {p1, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelAndReset(Ljava/lang/String;)V

    .line 179
    return-void

    .line 181
    :cond_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v1, "mWalletDoubleTapPowerEnabled"

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v0

    .line 183
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v3, "isUserSetupComplete"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    .line 184
    invoke-static {v2, v3, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 183
    invoke-virtual {v1, v2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 186
    if-eqz v0, :cond_2

    if-nez v1, :cond_1

    goto :goto_0

    .line 191
    :cond_1
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v4

    check-cast v0, Landroid/view/KeyEvent;

    .line 193
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$300()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    move-result-object v1

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 195
    invoke-virtual {v0}, Landroid/view/KeyEvent;->getEventTime()J

    move-result-wide v3

    .line 196
    invoke-virtual {v0}, Landroid/view/KeyEvent;->isLongPress()Z

    move-result v5

    .line 193
    invoke-virtual {v1, v2, v3, v4, v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->onPowerKeyDown(Ljava/lang/Object;JZ)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    move-result-object v1

    .line 197
    const-string v2, "xiaomi_power_wallet_decision"

    invoke-virtual {p1, v2, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setObjectExtra(Ljava/lang/String;Ljava/lang/Object;)V

    .line 198
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "power gesture eventTime="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {v0}, Landroid/view/KeyEvent;->getEventTime()J

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " deviceId="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 199
    invoke-virtual {v0}, Landroid/view/KeyEvent;->getDeviceId()I

    move-result v2

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " flags=0x"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 200
    invoke-virtual {v0}, Landroid/view/KeyEvent;->getFlags()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " taps="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->tapCount:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " action="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 198
    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 207
    goto :goto_2

    .line 187
    :cond_2
    :goto_0
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$300()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    move-result-object p1

    .line 188
    if-eqz v0, :cond_3

    const-string v0, "user_setup_incomplete"

    goto :goto_1

    :cond_3
    const-string v0, "wallet_setting_disabled"

    .line 187
    :goto_1
    invoke-virtual {p1, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelAndReset(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 189
    return-void

    .line 203
    :catchall_0
    move-exception p1

    .line 204
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$300()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    move-result-object v0

    const-string v1, "event_hook_failure"

    invoke-virtual {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelAndReset(Ljava/lang/String;)V

    .line 205
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "system power gesture observation failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 206
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 208
    :goto_2
    return-void
.end method

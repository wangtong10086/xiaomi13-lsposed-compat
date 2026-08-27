.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->scheduleCommitLocked(Ljava/lang/Object;Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

.field final synthetic val$action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field final synthetic val$gestureService:Ljava/lang/Object;

.field final synthetic val$token:J


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;JLdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 348
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    iput-wide p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$token:J

    iput-object p4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    iput-object p5, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$gestureService:Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 351
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->access$600(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 352
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->access$700(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)Ljava/lang/Runnable;

    move-result-object v1

    if-ne v1, p0, :cond_4

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->access$800(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)J

    move-result-wide v1

    iget-wide v3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$token:J

    cmp-long v1, v1, v3

    if-eqz v1, :cond_0

    goto/16 :goto_2

    .line 355
    :cond_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->access$702(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    .line 356
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    sget-object v2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->access$902(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 357
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 358
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$200()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 359
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "power gesture commit skipped token="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$token:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason=hook_disabled"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 361
    return-void

    .line 364
    :cond_1
    :try_start_1
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    if-ne v0, v1, :cond_2

    .line 365
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$gestureService:Ljava/lang/Object;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$1000(Ljava/lang/Object;)Z

    goto :goto_0

    .line 366
    :cond_2
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    if-ne v0, v1, :cond_3

    .line 367
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$gestureService:Ljava/lang/Object;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$1100(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 374
    :cond_3
    :goto_0
    goto :goto_1

    .line 369
    :catchall_0
    move-exception v0

    .line 370
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "power gesture commit failed token="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$token:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " action="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;->val$action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " error="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 372
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 370
    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 373
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 375
    :goto_1
    return-void

    .line 353
    :cond_4
    :goto_2
    :try_start_2
    monitor-exit v0

    return-void

    .line 357
    :catchall_1
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v1
.end method

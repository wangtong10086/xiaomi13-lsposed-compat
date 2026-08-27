.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

.field final synthetic val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 749
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 752
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v0, v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$1400(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 753
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$1902(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Z)Z

    .line 754
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2000(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-wide v3, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$cycleToken:J

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2100(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_1

    .line 755
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2200(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    move-result-object v1

    iget-object v3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v3, v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$decision:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    iget-object v4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    iget-boolean v4, v4, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->success:Z

    iget-object v5, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    iget-boolean v5, v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->recoverySucceeded:Z

    invoke-virtual {v1, v3, v4, v5}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onApplyResult(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;ZZ)V

    .line 759
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    iget-boolean v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->success:Z

    if-eqz v1, :cond_0

    .line 760
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    iget-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    iget-object v2, v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->originalDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2302(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    goto :goto_0

    .line 761
    :cond_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->val$result:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    iget-boolean v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->recoverySucceeded:Z

    if-eqz v1, :cond_2

    .line 762
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2302(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    goto :goto_0

    .line 765
    :cond_1
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2200(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    move-result-object v1

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onNfcCycleReset()V

    .line 766
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2302(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    .line 768
    :cond_2
    :goto_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;->this$1:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    const-string v2, "apply_complete"

    invoke-static {v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2400(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/String;)V

    .line 769
    monitor-exit v0

    .line 770
    return-void

    .line 769
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

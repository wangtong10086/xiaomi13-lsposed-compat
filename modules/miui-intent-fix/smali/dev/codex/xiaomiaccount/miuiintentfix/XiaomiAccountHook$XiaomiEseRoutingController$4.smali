.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->submitApplyLocked(Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

.field final synthetic val$cycleToken:J

.field final synthetic val$decision:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

.field final synthetic val$eseRoute:I

.field final synthetic val$manager:Ljava/lang/Object;

.field final synthetic val$routingOptionManager:Ljava/lang/Object;


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 744
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$manager:Ljava/lang/Object;

    iput-object p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$routingOptionManager:Ljava/lang/Object;

    iput p4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$eseRoute:I

    iput-object p5, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$decision:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    iput-wide p6, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$cycleToken:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 747
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$manager:Ljava/lang/Object;

    iget-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$routingOptionManager:Ljava/lang/Object;

    iget v3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$eseRoute:I

    iget-object v4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->val$decision:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    invoke-static {v0, v1, v2, v3, v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$1800(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    move-result-object v0

    .line 749
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->access$2500(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;

    invoke-direct {v2, p0, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4$1;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 772
    return-void
.end method

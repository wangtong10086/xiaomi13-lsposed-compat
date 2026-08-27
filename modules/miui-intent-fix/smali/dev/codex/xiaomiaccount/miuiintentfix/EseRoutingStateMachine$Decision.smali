.class final Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;
.super Ljava/lang/Object;
.source "EseRoutingStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Decision"
.end annotation


# instance fields
.field final action:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

.field final reason:Ljava/lang/String;

.field final record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V
    .locals 0

    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 95
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    .line 96
    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    .line 97
    iput-object p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->reason:Ljava/lang/String;

    .line 98
    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .line 102
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Decision{action="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", record="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 103
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    if-nez v1, :cond_0

    const-string v1, "none"

    goto :goto_0

    :cond_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->fingerprint()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", reason=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->reason:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 102
    return-object v0
.end method

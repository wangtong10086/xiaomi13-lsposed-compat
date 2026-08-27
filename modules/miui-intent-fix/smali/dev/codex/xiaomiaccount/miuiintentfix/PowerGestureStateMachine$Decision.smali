.class final Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;
.super Ljava/lang/Object;
.source "PowerGestureStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Decision"
.end annotation


# instance fields
.field final action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field final consumePowerKey:Z

.field final tapCount:I


# direct methods
.method constructor <init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->tapCount:I

    .line 25
    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 26
    iput-boolean p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->consumePowerKey:Z

    .line 27
    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .line 31
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Decision{tapCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->tapCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", action="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", consumePowerKey="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->consumePowerKey:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

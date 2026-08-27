.class final Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;
.super Ljava/lang/Object;
.source "PowerGestureStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;,
        Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
    }
.end annotation


# static fields
.field static final DEFAULT_MAX_INTERVAL_MS:J = 0x12cL


# instance fields
.field private lastEventTime:J

.field private final maxIntervalMs:J

.field private tapCount:I


# direct methods
.method constructor <init>(J)V
    .locals 2

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->lastEventTime:J

    .line 42
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-lez v0, :cond_0

    .line 45
    iput-wide p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->maxIntervalMs:J

    .line 46
    return-void

    .line 43
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "maxIntervalMs must be positive"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method


# virtual methods
.method onPowerDown(JZ)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;
    .locals 6

    .line 49
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    .line 50
    invoke-virtual {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->reset()V

    .line 51
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, v0, p2, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    return-object p1

    .line 54
    :cond_0
    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->lastEventTime:J

    const-wide/16 v3, 0x0

    cmp-long p3, v1, v3

    if-gez p3, :cond_1

    const-wide v1, 0x7fffffffffffffffL

    goto :goto_0

    :cond_1
    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->lastEventTime:J

    sub-long v1, p1, v1

    .line 55
    :goto_0
    cmp-long p3, v1, v3

    const/4 v3, 0x1

    if-ltz p3, :cond_2

    iget-wide v4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->maxIntervalMs:J

    cmp-long p3, v1, v4

    if-gez p3, :cond_2

    .line 56
    iget p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    add-int/2addr p3, v3

    iput p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    goto :goto_1

    .line 58
    :cond_2
    iput v3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    .line 60
    :goto_1
    iput-wide p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->lastEventTime:J

    .line 62
    iget p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    packed-switch p1, :pswitch_data_0

    .line 74
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    iget p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, p2, p3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    return-object p1

    .line 70
    :pswitch_0
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    const/4 p2, 0x5

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, p2, p3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    .line 71
    invoke-virtual {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->reset()V

    .line 72
    return-object p1

    .line 68
    :pswitch_1
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    const/4 p2, 0x4

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, p2, p3, v3}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    return-object p1

    .line 66
    :pswitch_2
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    const/4 p2, 0x3

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, p2, p3, v3}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    return-object p1

    .line 64
    :pswitch_3
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    const/4 p2, 0x2

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-direct {p1, p2, p3, v3}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;-><init>(ILdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Z)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method reset()V
    .locals 2

    .line 79
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->lastEventTime:J

    .line 80
    const/4 v0, 0x0

    iput v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->tapCount:I

    .line 81
    return-void
.end method

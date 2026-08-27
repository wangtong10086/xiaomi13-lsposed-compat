.class final Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "PowerWalletGestureController"
.end annotation


# instance fields
.field private generation:J

.field private handler:Landroid/os/Handler;

.field private final lock:Ljava/lang/Object;

.field private pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field private pendingCommit:Ljava/lang/Runnable;

.field private final stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;


# direct methods
.method private constructor <init>()V
    .locals 3

    .line 300
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 301
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->lock:Ljava/lang/Object;

    .line 302
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;

    const-wide/16 v1, 0x12c

    invoke-direct {v0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;-><init>(J)V

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;

    .line 306
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    return-void
.end method

.method synthetic constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;)V
    .locals 0

    .line 300
    invoke-direct {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;-><init>()V

    return-void
.end method

.method static synthetic access$600(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)Ljava/lang/Object;
    .locals 0

    .line 300
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->lock:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic access$700(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)Ljava/lang/Runnable;
    .locals 0

    .line 300
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic access$702(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    .line 300
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic access$800(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;)J
    .locals 2

    .line 300
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    return-wide v0
.end method

.method static synthetic access$902(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
    .locals 0

    .line 300
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    return-object p1
.end method

.method private cancelPendingLocked(Ljava/lang/String;)V
    .locals 4

    .line 385
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->handler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    .line 386
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->handler:Landroid/os/Handler;

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 387
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "power gesture cancelled token="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " action="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 391
    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    .line 392
    sget-object p1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 393
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    .line 394
    return-void
.end method

.method private scheduleCommitLocked(Ljava/lang/Object;Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;I)V
    .locals 10

    .line 342
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "superseded_by_tap_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelPendingLocked(Ljava/lang/String;)V

    .line 343
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->handler:Landroid/os/Handler;

    if-nez v0, :cond_0

    .line 344
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->handler:Landroid/os/Handler;

    .line 346
    :cond_0
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    const-wide/16 v2, 0x1

    add-long v6, v0, v2

    iput-wide v6, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->generation:J

    .line 347
    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingAction:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 348
    new-instance v4, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;

    move-object v5, p0

    move-object v9, p1

    move-object v8, p2

    invoke-direct/range {v4 .. v9}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController$1;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;JLdev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;Ljava/lang/Object;)V

    iput-object v4, v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    .line 377
    iget-object p1, v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->handler:Landroid/os/Handler;

    iget-object p2, v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->pendingCommit:Ljava/lang/Runnable;

    const-wide/16 v0, 0x136

    invoke-virtual {p1, p2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 378
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "power gesture scheduled token="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " taps="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " action="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " delayMs="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 382
    return-void
.end method


# virtual methods
.method cancelAndReset(Ljava/lang/String;)V
    .locals 2

    .line 332
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 333
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->reset()V

    .line 334
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelPendingLocked(Ljava/lang/String;)V

    .line 335
    monitor-exit v0

    .line 336
    return-void

    .line 335
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method onPowerKeyDown(Ljava/lang/Object;JZ)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;
    .locals 2

    .line 312
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 313
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;

    .line 314
    invoke-virtual {v1, p2, p3, p4}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;->onPowerDown(JZ)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;

    move-result-object p2

    .line 315
    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    iget-object p4, p2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {p4}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->ordinal()I

    move-result p4

    aget p3, p3, p4

    packed-switch p3, :pswitch_data_0

    goto :goto_0

    .line 321
    :pswitch_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "tap_count_"

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget p3, p2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->tapCount:I

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->cancelPendingLocked(Ljava/lang/String;)V

    .line 322
    goto :goto_0

    .line 318
    :pswitch_1
    iget-object p3, p2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    iget p4, p2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Decision;->tapCount:I

    invoke-direct {p0, p1, p3, p4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;->scheduleCommitLocked(Ljava/lang/Object;Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;I)V

    .line 319
    nop

    .line 327
    :goto_0
    monitor-exit v0

    return-object p2

    .line 328
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

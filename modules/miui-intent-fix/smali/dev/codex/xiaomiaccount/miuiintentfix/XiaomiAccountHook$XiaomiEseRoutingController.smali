.class final Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "XiaomiEseRoutingController"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;,
        Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;
    }
.end annotation


# instance fields
.field private cardEmulationManager:Ljava/lang/Object;

.field private context:Landroid/content/Context;

.field private deferredTrigger:Ljava/lang/String;

.field private deviceHost:Ljava/lang/Object;

.field private volatile frameworkRoutingMutationGeneration:J

.field private generation:J

.field private handler:Landroid/os/Handler;

.field private volatile internalRoutingOperation:Z

.field private final lock:Ljava/lang/Object;

.field private nfcCycleGeneration:J

.field private nfcReady:Z

.field private operationInFlight:Z

.field private ownedRoutingDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

.field private pendingReconcile:Ljava/lang/Runnable;

.field private routingExecutor:Ljava/util/concurrent/ExecutorService;

.field private settingsObserver:Landroid/database/ContentObserver;

.field private final stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 473
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 474
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    .line 475
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-direct {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;-><init>()V

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    return-void
.end method

.method synthetic constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;)V
    .locals 0

    .line 473
    invoke-direct {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;-><init>()V

    return-void
.end method

.method static synthetic access$1300(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/String;)V
    .locals 0

    .line 473
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcile(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1400(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ljava/lang/Object;
    .locals 0

    .line 473
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic access$1500(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ljava/lang/Runnable;
    .locals 0

    .line 473
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic access$1502(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    .line 473
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    return-object p1
.end method

.method static synthetic access$1600(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)J
    .locals 2

    .line 473
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    return-wide v0
.end method

.method static synthetic access$1700(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/String;J)V
    .locals 0

    .line 473
    invoke-direct {p0, p1, p2, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->reconcileLocked(Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic access$1800(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;
    .locals 0

    .line 473
    invoke-direct {p0, p1, p2, p3, p4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->performApplyRouting(Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$1902(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Z)Z
    .locals 0

    .line 473
    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    return p1
.end method

.method static synthetic access$2000(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Z
    .locals 0

    .line 473
    iget-boolean p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcReady:Z

    return p0
.end method

.method static synthetic access$2100(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)J
    .locals 2

    .line 473
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    return-wide v0
.end method

.method static synthetic access$2200(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;
    .locals 0

    .line 473
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    return-object p0
.end method

.method static synthetic access$2300(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;
    .locals 0

    .line 473
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->ownedRoutingDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    return-object p0
.end method

.method static synthetic access$2302(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;
    .locals 0

    .line 473
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->ownedRoutingDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    return-object p1
.end method

.method static synthetic access$2400(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/String;)V
    .locals 0

    .line 473
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleAfterOperationLocked(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2500(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)Landroid/os/Handler;
    .locals 0

    .line 473
    iget-object p0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$2602(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Z)Z
    .locals 0

    .line 473
    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    return p1
.end method

.method static synthetic access$2700(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Z
    .locals 0

    .line 473
    invoke-direct {p0, p1, p2, p3, p4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->recoverRoutingInternal(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Z

    move-result p0

    return p0
.end method

.method private cancelPendingLocked(Ljava/lang/String;)V
    .locals 4

    .line 636
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    .line 637
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 638
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "eSE routing reconcile cancelled token="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 641
    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    .line 642
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    .line 643
    return-void
.end method

.method private commitRouting(Ljava/lang/Object;)I
    .locals 2

    .line 927
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "callRoutingOverridedOrRecovered"

    invoke-static {p1, v1, v0}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 929
    instance-of v0, p1, Ljava/lang/Number;

    if-eqz v0, :cond_0

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->intValue()I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x2

    :goto_0
    return p1
.end method

.method private fetchActiveNfcees()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 934
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deviceHost:Ljava/lang/Object;

    if-eqz v0, :cond_1

    .line 938
    :try_start_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deviceHost:Ljava/lang/Object;

    const-string v1, "dofetchActiveNfceeList"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 940
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_0

    .line 943
    check-cast v0, Ljava/util/Map;

    return-object v0

    .line 941
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "active NFCEE result is not a Map"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 944
    :catchall_0
    move-exception v0

    .line 945
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "active NFCEE query failed"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 935
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "NFC device host unavailable"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private isTsmInstalledAndEnabled()Z
    .locals 3

    .line 1028
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "com.miui.tsmclient"

    invoke-virtual {v1, v2, v0}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    .line 1029
    iget-boolean v0, v1, Landroid/content/pm/ApplicationInfo;->enabled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    .line 1030
    :catchall_0
    move-exception v1

    .line 1031
    return v0
.end method

.method private performApplyRouting(Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;
    .locals 16

    .line 787
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    move-object/from16 v4, p4

    const-string v5, "apply_failure"

    .line 788
    nop

    .line 789
    nop

    .line 790
    iget-wide v6, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->frameworkRoutingMutationGeneration:J

    .line 791
    const/4 v8, 0x1

    iput-boolean v8, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    .line 793
    const/4 v9, 0x0

    const/4 v10, 0x0

    :try_start_0
    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->capture(Ljava/lang/Object;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    move-result-object v11
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 794
    :try_start_1
    iget-wide v12, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->frameworkRoutingMutationGeneration:J

    cmp-long v0, v6, v12

    if-nez v0, :cond_4

    .line 798
    const-string v0, "getDefaultFelicaRoute"

    new-array v12, v9, [Ljava/lang/Object;

    invoke-static {v3, v0, v12}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    .line 799
    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 800
    const-string v12, "overrideDefaultRoute"

    .line 801
    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    .line 800
    invoke-static {v3, v12, v13}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 802
    const-string v12, "overrideDefaultIsoDepRoute"

    .line 803
    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    .line 802
    invoke-static {v3, v12, v13}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 804
    const-string v12, "overrideDefaultTechRoute"

    .line 805
    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    filled-new-array {v13, v14}, [Ljava/lang/Object;

    move-result-object v13

    .line 804
    invoke-static {v3, v12, v13}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 806
    invoke-direct/range {p0 .. p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->commitRouting(Ljava/lang/Object;)I

    move-result v12
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 807
    if-nez v12, :cond_0

    move v13, v8

    goto :goto_0

    :cond_0
    move v13, v9

    .line 808
    :goto_0
    if-eqz v13, :cond_2

    :try_start_2
    iget-wide v14, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->frameworkRoutingMutationGeneration:J

    cmp-long v6, v6, v14

    if-nez v6, :cond_1

    .line 809
    invoke-virtual {v11, v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->matches(Ljava/lang/Object;)Z

    move-result v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v6, :cond_2

    .line 810
    :cond_1
    nop

    .line 811
    :try_start_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "eSE routing apply rejected because framework defaults changed during transient override original="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 812
    invoke-virtual {v11}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->describe()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " current="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 814
    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->capture(Ljava/lang/Object;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    move-result-object v7

    invoke-virtual {v7}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->describe()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 811
    invoke-static {v6}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move v13, v9

    goto :goto_1

    .line 825
    :catchall_0
    move-exception v0

    goto/16 :goto_3

    .line 816
    :cond_2
    :goto_1
    if-nez v13, :cond_3

    .line 817
    :try_start_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "eSE routing commit rejected result="

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " record="

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v6, v4, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    .line 818
    invoke-virtual {v6}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->fingerprint()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 817
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    goto :goto_2

    .line 820
    :cond_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "eSE routing applied record="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v4, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    invoke-virtual {v7}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->fingerprint()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " type="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v4, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    iget-object v7, v7, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->type:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " eSE=0x"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 822
    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " felica=0x"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 823
    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 820
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 830
    :goto_2
    if-nez v13, :cond_5

    .line 831
    goto :goto_4

    .line 795
    :cond_4
    :try_start_5
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v6, "framework routing changed while defaults were captured"

    invoke-direct {v0, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 825
    :catchall_1
    move-exception v0

    move v13, v9

    goto :goto_3

    :catchall_2
    move-exception v0

    move v13, v9

    move-object v11, v10

    .line 826
    :goto_3
    :try_start_6
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "eSE routing apply failed record="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v4, v4, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    invoke-virtual {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->fingerprint()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " error="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 827
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 826
    invoke-static {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 828
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 830
    if-nez v13, :cond_5

    .line 831
    :goto_4
    invoke-direct {v1, v2, v3, v5, v11}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->recoverRoutingInternal(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Z

    move-result v8

    .line 834
    :cond_5
    iput-boolean v9, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    .line 835
    nop

    .line 836
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;

    .line 837
    if-eqz v13, :cond_6

    move-object v10, v11

    :cond_6
    invoke-direct {v0, v13, v8, v10}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;-><init>(ZZLdev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)V

    .line 836
    return-object v0

    .line 830
    :catchall_3
    move-exception v0

    if-nez v13, :cond_7

    .line 831
    invoke-direct {v1, v2, v3, v5, v11}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->recoverRoutingInternal(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Z

    .line 834
    :cond_7
    iput-boolean v9, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    .line 835
    throw v0
.end method

.method private reconcileLocked(Ljava/lang/String;J)V
    .locals 16

    .line 646
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-wide/from16 v3, p2

    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    const-string v5, "eSE routing reconcile deferred token="

    const-string v6, " trigger="

    if-eqz v0, :cond_5

    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 651
    :cond_0
    iget-boolean v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    if-eqz v0, :cond_1

    .line 652
    iput-object v2, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 653
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " reason=operation_in_flight"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 655
    return-void

    .line 658
    :cond_1
    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    .line 659
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 658
    const-string v7, "TSM_CARD_ACTIVATE_RECORD"

    invoke-static {v0, v7}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 660
    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    .line 661
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 660
    const-string v7, "codex_xiaomi_ese_routing_enabled"

    const/4 v8, 0x1

    invoke-static {v0, v7, v8}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    const/4 v7, 0x0

    if-eqz v0, :cond_2

    move v10, v8

    goto :goto_0

    :cond_2
    move v10, v7

    .line 662
    :goto_0
    invoke-direct {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->isTsmInstalledAndEnabled()Z

    move-result v11

    .line 668
    :try_start_0
    iget-object v0, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    const-string v12, "mRoutingOptionManager"

    invoke-static {v0, v12}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 670
    iget-object v12, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    const-string v13, "mRoutingChangeFuture"

    invoke-static {v12, v13}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    .line 672
    if-eqz v12, :cond_3

    .line 673
    iput-object v2, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 674
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " reason=framework_routing_in_flight"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 677
    const-string v0, "framework_routing_in_flight"

    invoke-direct {v1, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 678
    return-void

    .line 680
    :cond_3
    const-string v5, "getRouteForSecureElement"

    const-string v12, "eSE1"

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v0, v5, v12}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Number;

    .line 681
    invoke-virtual {v5}, Ljava/lang/Number;->intValue()I

    move-result v5

    .line 682
    nop

    .line 684
    invoke-direct {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->fetchActiveNfcees()Ljava/util/Map;

    move-result-object v12

    iget-object v13, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    .line 685
    invoke-virtual {v13}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v13

    const-string v14, "com.nxp.mifare"

    invoke-virtual {v13, v14}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v13

    iget-object v14, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    .line 686
    invoke-virtual {v14}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v14

    const-string v15, "android.hardware.nfc.ese"

    invoke-virtual {v14, v15}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v14

    .line 682
    invoke-static {v5, v12, v13, v14}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver;->resolve(ILjava/util/Map;ZZ)Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    move-result-object v15

    .line 688
    iget-object v12, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    const-string v13, "mForegroundUid"

    invoke-static {v12, v13}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v12
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 690
    const/4 v13, -0x1

    if-eq v12, v13, :cond_4

    move v14, v8

    goto :goto_1

    :cond_4
    move v14, v7

    .line 696
    :goto_1
    nop

    .line 698
    iget-object v8, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    .line 702
    invoke-virtual {v15}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->isAvailable()Z

    move-result v12

    iget-boolean v13, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcReady:Z

    .line 698
    invoke-virtual/range {v8 .. v14}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->reconcile(Ljava/lang/String;ZZZZZ)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    move-result-object v7

    .line 705
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "eSE routing reconcile token="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " action="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v7, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " reason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v7, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->reason:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " frameworkRoute=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 709
    invoke-static {v5}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " resolvedRoute=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v15, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->route:I

    .line 710
    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " routeReason="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v15, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->reason:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " owned="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    .line 712
    invoke-virtual {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 705
    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 714
    sget-object v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

    iget-object v3, v7, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->action:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    goto :goto_2

    .line 724
    :pswitch_0
    iget-object v2, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    iget-object v4, v7, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->reason:Ljava/lang/String;

    iget-wide v5, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->submitRecoveryLocked(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;J)V

    .line 729
    goto :goto_2

    .line 716
    :pswitch_1
    move-object v3, v0

    iget-object v2, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    iget v4, v15, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->route:I

    move-object v5, v7

    iget-wide v6, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    invoke-direct/range {v1 .. v7}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->submitApplyLocked(Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;J)V

    .line 722
    nop

    .line 734
    :goto_2
    return-void

    .line 691
    :catchall_0
    move-exception v0

    .line 692
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "eSE routing reflection failed token="

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " error="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 693
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 692
    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 694
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 695
    return-void

    .line 647
    :cond_5
    :goto_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " reason=manager_unavailable"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 649
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private recoverRoutingInternal(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)Z
    .locals 3

    .line 903
    const/4 v0, 0x0

    if-eqz p4, :cond_0

    .line 904
    :try_start_0
    invoke-virtual {p4, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->restoreIfChanged(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 905
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "eSE routing restored in-memory framework defaults before recovery "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 906
    invoke-virtual {p4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->describe()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    .line 905
    invoke-static {p4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 908
    :cond_0
    const-string p4, "recoverOverridedRoutingTable"

    new-array v1, v0, [Ljava/lang/Object;

    invoke-static {p2, p4, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 910
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->commitRouting(Ljava/lang/Object;)I

    move-result p1

    .line 911
    if-eqz p1, :cond_1

    .line 912
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "eSE routing recovery rejected reason="

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p4, " result="

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 914
    return v0

    .line 916
    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "eSE routing recovered native defaults reason="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 917
    const/4 p1, 0x1

    return p1

    .line 918
    :catchall_0
    move-exception p1

    .line 919
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "eSE routing recovery failed reason="

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " error="

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    .line 920
    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 919
    invoke-static {p2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 921
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 922
    return v0
.end method

.method private scheduleAfterOperationLocked(Ljava/lang/String;)V
    .locals 1

    .line 890
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 891
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 892
    iget-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcReady:Z

    if-eqz v0, :cond_1

    .line 893
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 895
    :cond_1
    return-void
.end method

.method private scheduleReconcile(Ljava/lang/String;)V
    .locals 1

    .line 600
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 601
    :try_start_0
    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 602
    monitor-exit v0

    .line 603
    return-void

    .line 602
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method private scheduleReconcileLocked(Ljava/lang/String;)V
    .locals 4

    .line 606
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    if-nez v0, :cond_0

    .line 607
    return-void

    .line 609
    :cond_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    .line 610
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 612
    :cond_1
    iget-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->generation:J

    .line 613
    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$3;

    invoke-direct {v2, p0, v0, v1, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$3;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;JLjava/lang/String;)V

    iput-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    .line 632
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->pendingReconcile:Ljava/lang/Runnable;

    const-wide/16 v1, 0x64

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 633
    return-void
.end method

.method private submitApplyLocked(Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;J)V
    .locals 10

    .line 742
    const/4 v1, 0x1

    iput-boolean v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    .line 744
    :try_start_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->routingExecutor:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move v6, p3

    move-object v7, p4

    move-wide v8, p5

    invoke-direct/range {v2 .. v9}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$4;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;ILdev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;J)V

    invoke-interface {v0, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 779
    goto :goto_0

    .line 774
    :catchall_0
    move-exception v0

    move-object p1, v0

    .line 775
    const/4 p2, 0x0

    iput-boolean p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    .line 776
    iget-object p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {p3, p4, p2, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onApplyResult(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;ZZ)V

    .line 777
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "eSE routing worker rejected apply: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 778
    const-string p1, "apply_worker_rejected"

    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleAfterOperationLocked(Ljava/lang/String;)V

    .line 780
    :goto_0
    return-void
.end method

.method private submitRecoveryLocked(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;J)V
    .locals 8

    .line 845
    const/4 v0, 0x1

    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    .line 847
    :try_start_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->routingExecutor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$5;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-wide v6, p4

    :try_start_1
    invoke-direct/range {v1 .. v7}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$5;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;J)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 886
    goto :goto_1

    .line 881
    :catchall_0
    move-exception v0

    goto :goto_0

    :catchall_1
    move-exception v0

    move-object v2, p0

    :goto_0
    move-object p1, v0

    .line 882
    const/4 p2, 0x0

    iput-boolean p2, v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->operationInFlight:Z

    .line 883
    iget-object p3, v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {p3, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onRecoverResult(Z)V

    .line 884
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "eSE routing worker rejected recovery: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 885
    const-string p1, "recovery_worker_rejected"

    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleAfterOperationLocked(Ljava/lang/String;)V

    .line 887
    :goto_1
    return-void
.end method


# virtual methods
.method attach(Landroid/content/Context;Ljava/lang/Object;)V
    .locals 3

    .line 493
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 494
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    if-eqz v1, :cond_0

    .line 495
    monitor-exit v0

    return-void

    .line 497
    :cond_0
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    .line 498
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {p1, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    .line 499
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$1;

    invoke-direct {p1, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$1;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)V

    invoke-static {p1}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->routingExecutor:Ljava/util/concurrent/ExecutorService;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 508
    :try_start_1
    const-string p1, "mCardEmulationManager"

    invoke-static {p2, p1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    .line 510
    const-string p1, "mDeviceHost"

    invoke-static {p2, p1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deviceHost:Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 513
    goto :goto_0

    .line 511
    :catchall_0
    move-exception p1

    .line 512
    :try_start_2
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "eSE routing initial manager lookup deferred: "

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 516
    :goto_0
    :try_start_3
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$2;

    iget-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->handler:Landroid/os/Handler;

    invoke-direct {p1, p0, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$2;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;Landroid/os/Handler;)V

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->settingsObserver:Landroid/database/ContentObserver;

    .line 522
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    const-string p2, "TSM_CARD_ACTIVATE_RECORD"

    .line 523
    invoke-static {p2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->settingsObserver:Landroid/database/ContentObserver;

    .line 522
    const/4 v2, 0x0

    invoke-virtual {p1, p2, v2, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 526
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->context:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    const-string p2, "codex_xiaomi_ese_routing_enabled"

    .line 527
    invoke-static {p2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->settingsObserver:Landroid/database/ContentObserver;

    .line 526
    invoke-virtual {p1, p2, v2, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 530
    const-string p1, "eSE routing controller attached; observing TSM_CARD_ACTIVATE_RECORD and codex_xiaomi_ese_routing_enabled"

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 537
    goto :goto_1

    .line 533
    :catchall_1
    move-exception p1

    .line 534
    :try_start_4
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "eSE routing settings observer unavailable: "

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    .line 535
    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 534
    invoke-static {p2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 536
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 538
    :goto_1
    monitor-exit v0

    .line 539
    return-void

    .line 538
    :catchall_2
    move-exception p1

    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    throw p1
.end method

.method onFrameworkRecovery()V
    .locals 2

    .line 567
    iget-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    if-eqz v0, :cond_0

    .line 568
    return-void

    .line 570
    :cond_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 571
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onExternalRecovery()V

    .line 572
    const-string v1, "framework_routing_recovered"

    invoke-direct {p0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 573
    monitor-exit v0

    .line 574
    return-void

    .line 573
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method onFrameworkRoutingChangeCompleted()V
    .locals 2

    .line 591
    iget-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    if-eqz v0, :cond_0

    .line 592
    return-void

    .line 594
    :cond_0
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 595
    :try_start_0
    const-string v1, "framework_routing_change_completed"

    invoke-direct {p0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 596
    monitor-exit v0

    .line 597
    return-void

    .line 596
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method onFrameworkRoutingOptionsOverwritten()V
    .locals 5

    .line 577
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 578
    :try_start_0
    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->frameworkRoutingMutationGeneration:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->frameworkRoutingMutationGeneration:J

    .line 579
    iget-boolean v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->internalRoutingOperation:Z

    if-eqz v1, :cond_0

    .line 580
    const-string v1, "framework_routing_overwritten_during_apply"

    iput-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 581
    const-string v1, "eSE routing detected concurrent framework routing overwrite"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 582
    monitor-exit v0

    return-void

    .line 584
    :cond_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onExternalRecovery()V

    .line 585
    const/4 v1, 0x0

    iput-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->ownedRoutingDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    .line 586
    const-string v1, "framework_routing_overwritten"

    invoke-direct {p0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 587
    monitor-exit v0

    .line 588
    return-void

    .line 587
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method onNfcDisabled(Ljava/lang/Object;)V
    .locals 5

    .line 552
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 553
    :try_start_0
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    if-nez v1, :cond_0

    .line 554
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    .line 556
    :cond_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcReady:Z

    .line 557
    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    .line 558
    const/4 p1, 0x0

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->deferredTrigger:Ljava/lang/String;

    .line 559
    const-string v1, "nfc_disabled"

    invoke-direct {p0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cancelPendingLocked(Ljava/lang/String;)V

    .line 560
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onNfcCycleReset()V

    .line 561
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->ownedRoutingDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    .line 562
    const-string p1, "eSE routing runtime state reset because NFC was disabled"

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 563
    monitor-exit v0

    .line 564
    return-void

    .line 563
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method onNfcEnabled(Ljava/lang/Object;)V
    .locals 5

    .line 542
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 543
    :try_start_0
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->cardEmulationManager:Ljava/lang/Object;

    .line 544
    const/4 p1, 0x1

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcReady:Z

    .line 545
    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->nfcCycleGeneration:J

    .line 546
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->stateMachine:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;

    invoke-virtual {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->onNfcCycleReset()V

    .line 547
    const-string p1, "nfc_enabled"

    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->scheduleReconcileLocked(Ljava/lang/String;)V

    .line 548
    monitor-exit v0

    .line 549
    return-void

    .line 548
    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

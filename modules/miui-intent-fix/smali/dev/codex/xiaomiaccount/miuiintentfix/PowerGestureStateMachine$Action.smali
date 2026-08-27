.class final enum Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
.super Ljava/lang/Enum;
.source "PowerGestureStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "Action"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field public static final enum CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field public static final enum NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field public static final enum SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

.field public static final enum SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;


# direct methods
.method private static synthetic $values()[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
    .locals 4

    .line 11
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    sget-object v2, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    sget-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    filled-new-array {v0, v1, v2, v3}, [Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 12
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    const-string v1, "NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 13
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    const-string v1, "SCHEDULE_XIAOMI"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 14
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    const-string v1, "SCHEDULE_GOOGLE"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 15
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    const-string v1, "CANCEL_WALLETS"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    .line 11
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->$values()[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    move-result-object v0

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->$VALUES:[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 11
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
    .locals 1

    .line 11
    const-class v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    return-object p0
.end method

.method public static values()[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;
    .locals 1

    .line 11
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->$VALUES:[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v0}, [Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    return-object v0
.end method

.class synthetic Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1008
    name = null
.end annotation


# static fields
.field static final synthetic $SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

.field static final synthetic $SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 714
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->values()[Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

    const/4 v0, 0x1

    :try_start_0
    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

    sget-object v2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->APPLY:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->ordinal()I

    move-result v2

    aput v0, v1, v2
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    :goto_0
    const/4 v1, 0x2

    :try_start_1
    sget-object v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

    sget-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->RECOVER:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->ordinal()I

    move-result v3

    aput v1, v2, v3
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v2

    :goto_1
    const/4 v2, 0x3

    :try_start_2
    sget-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$EseRoutingStateMachine$Action:[I

    sget-object v4, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-virtual {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->ordinal()I

    move-result v4

    aput v2, v3, v4
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    :catch_2
    move-exception v3

    .line 315
    :goto_2
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->values()[Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    move-result-object v3

    array-length v3, v3

    new-array v3, v3, [I

    sput-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    :try_start_3
    sget-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    sget-object v4, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_XIAOMI:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->ordinal()I

    move-result v4

    aput v0, v3, v4
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_3

    :catch_3
    move-exception v0

    :goto_3
    :try_start_4
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    sget-object v3, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->SCHEDULE_GOOGLE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->ordinal()I

    move-result v3

    aput v1, v0, v3
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_4

    :catch_4
    move-exception v0

    :goto_4
    :try_start_5
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->CANCEL_WALLETS:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->ordinal()I

    move-result v1

    aput v2, v0, v1
    :try_end_5
    .catch Ljava/lang/NoSuchFieldError; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_5

    :catch_5
    move-exception v0

    :goto_5
    :try_start_6
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$39;->$SwitchMap$dev$codex$xiaomiaccount$miuiintentfix$PowerGestureStateMachine$Action:[I

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;

    invoke-virtual {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/PowerGestureStateMachine$Action;->ordinal()I

    move-result v1

    const/4 v2, 0x4

    aput v2, v0, v1
    :try_end_6
    .catch Ljava/lang/NoSuchFieldError; {:try_start_6 .. :try_end_6} :catch_6

    goto :goto_6

    :catch_6
    move-exception v0

    :goto_6
    return-void
.end method

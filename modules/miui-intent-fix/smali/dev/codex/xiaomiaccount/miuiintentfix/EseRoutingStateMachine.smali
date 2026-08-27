.class final Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;
.super Ljava/lang/Object;
.source "EseRoutingStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;,
        Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;,
        Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;
    }
.end annotation


# instance fields
.field private blockedApplyKey:Ljava/lang/String;

.field private lastDesiredKey:Ljava/lang/String;

.field private ownsRouting:Z

.field private recoveryBlocked:Z


# direct methods
.method constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static same(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    .line 204
    if-nez p0, :cond_1

    if-nez p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    :goto_0
    return p0
.end method


# virtual methods
.method onApplyResult(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;ZZ)V
    .locals 1

    .line 168
    const/4 v0, 0x1

    if-eqz p2, :cond_0

    .line 169
    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    .line 170
    const/4 p1, 0x0

    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->blockedApplyKey:Ljava/lang/String;

    .line 171
    const/4 p1, 0x0

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 172
    return-void

    .line 174
    :cond_0
    iget-object p2, p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    if-nez p2, :cond_1

    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->lastDesiredKey:Ljava/lang/String;

    goto :goto_0

    :cond_1
    iget-object p1, p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;->record:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    invoke-virtual {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->key()Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->blockedApplyKey:Ljava/lang/String;

    .line 175
    xor-int/lit8 p1, p3, 0x1

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    .line 176
    xor-int/lit8 p1, p3, 0x1

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 177
    return-void
.end method

.method onExternalRecovery()V
    .locals 1

    .line 189
    const/4 v0, 0x0

    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    .line 190
    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 191
    return-void
.end method

.method onNfcCycleReset()V
    .locals 2

    .line 194
    const/4 v0, 0x0

    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    .line 195
    const/4 v1, 0x0

    iput-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->blockedApplyKey:Ljava/lang/String;

    .line 196
    iput-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 197
    return-void
.end method

.method onRecoverResult(Z)V
    .locals 0

    .line 180
    if-eqz p1, :cond_0

    .line 181
    const/4 p1, 0x0

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    .line 182
    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    goto :goto_0

    .line 184
    :cond_0
    const/4 p1, 0x1

    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 186
    :goto_0
    return-void
.end method

.method ownsRouting()Z
    .locals 1

    .line 200
    iget-boolean v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    return v0
.end method

.method reconcile(Ljava/lang/String;ZZZZZ)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;
    .locals 6

    .line 120
    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->parse(Ljava/lang/String;)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    move-result-object v0

    .line 121
    const/4 v1, 0x0

    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    move v2, v1

    .line 122
    :goto_0
    const/4 v3, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->key()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_1
    move-object v4, v3

    .line 124
    :goto_1
    iget-object v5, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->lastDesiredKey:Ljava/lang/String;

    invoke-static {v5, v4}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->same(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 125
    iput-object v4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->lastDesiredKey:Ljava/lang/String;

    .line 126
    iput-object v3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->blockedApplyKey:Ljava/lang/String;

    .line 127
    iput-boolean v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    .line 130
    :cond_2
    if-nez p5, :cond_3

    .line 131
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "nfc_not_ready"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1

    .line 134
    :cond_3
    if-nez v2, :cond_9

    .line 136
    if-nez p2, :cond_4

    .line 137
    const-string p1, "feature_disabled"

    goto :goto_2

    .line 138
    :cond_4
    if-nez p3, :cond_5

    .line 139
    const-string p1, "tsm_unavailable"

    goto :goto_2

    .line 140
    :cond_5
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_6

    .line 141
    const-string p1, "invalid_record"

    goto :goto_2

    .line 143
    :cond_6
    const-string p1, "no_active_card"

    .line 145
    :goto_2
    iget-boolean p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    if-eqz p2, :cond_7

    iget-boolean p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    if-nez p2, :cond_7

    .line 146
    new-instance p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->RECOVER:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    invoke-direct {p2, p3, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p2

    .line 148
    :cond_7
    new-instance p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p3, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    .line 149
    iget-boolean p4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->recoveryBlocked:Z

    if-eqz p4, :cond_8

    const-string p1, "recovery_blocked"

    :cond_8
    invoke-direct {p2, p3, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    .line 148
    return-object p2

    .line 152
    :cond_9
    iget-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->ownsRouting:Z

    if-eqz p1, :cond_a

    .line 153
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "already_applied"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1

    .line 155
    :cond_a
    if-nez p4, :cond_b

    .line 156
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "ese_unavailable"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1

    .line 158
    :cond_b
    if-eqz p6, :cond_c

    .line 159
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "third_party_override"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1

    .line 161
    :cond_c
    iget-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->blockedApplyKey:Ljava/lang/String;

    invoke-static {p1, v4}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;->same(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_d

    .line 162
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->NONE:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "apply_blocked_after_failure"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1

    .line 164
    :cond_d
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;

    sget-object p2, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;->APPLY:Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;

    const-string p3, "active_card"

    invoke-direct {p1, p2, v0, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Decision;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$Action;Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;Ljava/lang/String;)V

    return-object p1
.end method

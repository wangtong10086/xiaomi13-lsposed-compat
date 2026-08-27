.class final Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;
.super Ljava/lang/Object;
.source "EseRoutingStateMachine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "CardRecord"
.end annotation


# instance fields
.field final aid:Ljava/lang/String;

.field final timestamp:J

.field final type:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->aid:Ljava/lang/String;

    .line 19
    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->type:Ljava/lang/String;

    .line 20
    iput-wide p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->timestamp:J

    .line 21
    return-void
.end method

.method private static isHex(Ljava/lang/String;)Z
    .locals 4

    .line 63
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_3

    .line 64
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 65
    const/16 v3, 0x30

    if-lt v2, v3, :cond_0

    const/16 v3, 0x39

    if-le v2, v3, :cond_1

    :cond_0
    const/16 v3, 0x41

    if-lt v2, v3, :cond_2

    const/16 v3, 0x46

    if-le v2, v3, :cond_1

    goto :goto_1

    .line 63
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 67
    :cond_2
    :goto_1
    return v0

    .line 70
    :cond_3
    const/4 p0, 0x1

    return p0
.end method

.method private static isSafeType(Ljava/lang/String;)Z
    .locals 4

    .line 74
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 75
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 76
    const/16 v3, 0x41

    if-lt v2, v3, :cond_0

    const/16 v3, 0x5a

    if-le v2, v3, :cond_3

    :cond_0
    const/16 v3, 0x61

    if-lt v2, v3, :cond_1

    const/16 v3, 0x7a

    if-le v2, v3, :cond_3

    :cond_1
    const/16 v3, 0x30

    if-lt v2, v3, :cond_2

    const/16 v3, 0x39

    if-le v2, v3, :cond_3

    :cond_2
    const/16 v3, 0x5f

    if-eq v2, v3, :cond_3

    const/16 v3, 0x2d

    if-eq v2, v3, :cond_3

    const/16 v3, 0x2e

    if-eq v2, v3, :cond_3

    .line 82
    return v0

    .line 74
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 85
    :cond_4
    const/4 p0, 0x1

    return p0
.end method

.method static parse(Ljava/lang/String;)Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;
    .locals 8

    .line 24
    const/4 v0, 0x0

    if-eqz p0, :cond_5

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 27
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const-string v1, ","

    const/4 v2, -0x1

    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object p0

    .line 28
    array-length v1, p0

    const/4 v2, 0x3

    if-eq v1, v2, :cond_1

    .line 29
    return-object v0

    .line 32
    :cond_1
    const/4 v1, 0x0

    aget-object v1, p0, v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 33
    const/4 v2, 0x1

    aget-object v3, p0, v2

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 34
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    const/16 v5, 0xa

    if-lt v4, v5, :cond_4

    .line 35
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    const/16 v5, 0x20

    if-gt v4, v5, :cond_4

    .line 36
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    and-int/2addr v2, v4

    if-nez v2, :cond_4

    .line 37
    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->isHex(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 38
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    .line 39
    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->isSafeType(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    goto :goto_0

    .line 44
    :cond_2
    const/4 v2, 0x2

    :try_start_0
    aget-object p0, p0, v2

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    .line 45
    const-wide/16 v6, 0x0

    cmp-long p0, v4, v6

    if-gtz p0, :cond_3

    .line 46
    return-object v0

    .line 48
    :cond_3
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;

    invoke-direct {p0, v1, v3, v4, v5}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;-><init>(Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 49
    :catch_0
    move-exception p0

    .line 50
    return-object v0

    .line 40
    :cond_4
    :goto_0
    return-object v0

    .line 25
    :cond_5
    :goto_1
    return-object v0
.end method


# virtual methods
.method fingerprint()Ljava/lang/String;
    .locals 1

    .line 59
    invoke-virtual {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->key()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method key()Ljava/lang/String;
    .locals 3

    .line 55
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->aid:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->type:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRoutingStateMachine$CardRecord;->timestamp:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

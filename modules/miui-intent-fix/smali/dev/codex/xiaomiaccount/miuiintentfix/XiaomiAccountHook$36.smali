.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->createMiNfcAdapterProxy(Ljava/lang/ClassLoader;Landroid/content/Context;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 2040
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    .line 2043
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p1

    .line 2044
    const-string v0, "getSeRouting"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    .line 2045
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 2044
    if-eqz v0, :cond_0

    .line 2045
    return-object v2

    .line 2047
    :cond_0
    const-string v0, "getVersion"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 2048
    return-object v2

    .line 2050
    :cond_1
    const-string v0, "getChipId"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 2051
    const-string p1, "0xa4"

    return-object p1

    .line 2053
    :cond_2
    const-string v0, "getFwVersion"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 2054
    const-string p1, "NXP.01.01"

    return-object p1

    .line 2056
    :cond_3
    const-string v0, "getNfccDieid"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_4

    .line 2057
    new-array p1, v1, [B

    aput-byte v2, p1, v2

    return-object p1

    .line 2059
    :cond_4
    const-string v0, "setSeRouting"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v3, 0x0

    if-eqz v0, :cond_8

    .line 2062
    if-eqz p3, :cond_5

    array-length p1, p3

    if-lez p1, :cond_5

    aget-object p1, p3, v2

    instance-of p1, p1, Ljava/lang/Number;

    if-eqz p1, :cond_5

    .line 2063
    aget-object p1, p3, v2

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->intValue()I

    move-result p1

    goto :goto_0

    .line 2064
    :cond_5
    const/4 p1, -0x1

    .line 2065
    :goto_0
    if-ne p1, v1, :cond_6

    goto :goto_1

    :cond_6
    move v1, v2

    .line 2066
    :goto_1
    if-eqz v1, :cond_7

    iget-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;->val$context:Landroid/content/Context;

    if-eqz p2, :cond_7

    .line 2067
    iget-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;->val$context:Landroid/content/Context;

    invoke-virtual {p2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p2

    .line 2068
    const-string p3, "TSM_CARD_ACTIVATE_RECORD"

    invoke-static {p3}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p3

    .line 2067
    invoke-virtual {p2, p3, v3}, Landroid/content/ContentResolver;->notifyChange(Landroid/net/Uri;Landroid/database/ContentObserver;)V

    .line 2072
    :cond_7
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "MI NFC setSeRouting request="

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " accepted="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 2074
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    .line 2076
    :cond_8
    const-string p3, "asBinder"

    invoke-virtual {p3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_9

    .line 2077
    return-object v3

    .line 2079
    :cond_9
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$6300(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

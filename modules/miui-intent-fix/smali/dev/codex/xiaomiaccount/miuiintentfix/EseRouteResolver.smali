.class final Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver;
.super Ljava/lang/Object;
.source "EseRouteResolver.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;
    }
.end annotation


# static fields
.field private static final LEGACY_NXP_ESE_ROUTE:I = 0x1

.field private static final NCI_NXP_ESE_ROUTE:I = 0xc0

.field private static final ROUTE_UNAVAILABLE:I = 0x0

.field private static final TECH_A_OR_B_MASK:I = 0x3


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    return-void
.end method

.method private static containsEseEntry(Ljava/util/Map;)Z
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)Z"
        }
    .end annotation

    .line 68
    invoke-interface {p0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    .line 69
    if-eqz v1, :cond_0

    const/4 v5, 0x0

    const/4 v6, 0x3

    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string v4, "eSE"

    invoke-virtual/range {v1 .. v6}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 70
    const/4 p0, 0x1

    return p0

    .line 72
    :cond_0
    goto :goto_0

    .line 73
    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method static resolve(ILjava/util/Map;ZZ)Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;ZZ)",
            "Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;"
        }
    .end annotation

    .line 35
    const/4 v0, 0x0

    if-gtz p0, :cond_0

    .line 36
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const-string p1, "framework_route_missing"

    invoke-direct {p0, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p0

    .line 39
    :cond_0
    if-nez p1, :cond_1

    .line 40
    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object p1

    goto :goto_0

    .line 41
    :cond_1
    nop

    .line 42
    :goto_0
    const-string v1, "eSE1"

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 43
    if-eqz v1, :cond_3

    .line 44
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    and-int/lit8 p1, p1, 0x3

    if-nez p1, :cond_2

    .line 45
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const-string p1, "ese_has_no_type_a_or_b"

    invoke-direct {p0, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p0

    .line 47
    :cond_2
    new-instance p1, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const-string p2, "framework_active_nfcee"

    invoke-direct {p1, p0, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p1

    .line 50
    :cond_3
    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver;->containsEseEntry(Ljava/util/Map;)Z

    move-result p1

    if-eqz p1, :cond_4

    .line 51
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const-string p1, "unexpected_ese_instance"

    invoke-direct {p0, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p0

    .line 58
    :cond_4
    const/4 p1, 0x1

    if-ne p0, p1, :cond_5

    if-eqz p2, :cond_5

    if-eqz p3, :cond_5

    .line 61
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const/16 p1, 0xc0

    const-string p2, "nxp_legacy_route_bridge"

    invoke-direct {p0, p1, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p0

    .line 64
    :cond_5
    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;

    const-string p1, "active_ese_not_verified"

    invoke-direct {p0, v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;-><init>(ILjava/lang/String;)V

    return-object p0
.end method

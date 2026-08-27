.class final Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "RoutingDefaultsSnapshot"
.end annotation


# instance fields
.field final defaultRoute:I

.field final felicaRoute:I

.field final isoDepRoute:I

.field final offHostRoute:I

.field final systemCodeRoute:I


# direct methods
.method constructor <init>(IIIII)V
    .locals 0

    .line 976
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 977
    iput p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->defaultRoute:I

    .line 978
    iput p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->isoDepRoute:I

    .line 979
    iput p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->offHostRoute:I

    .line 980
    iput p4, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->felicaRoute:I

    .line 981
    iput p5, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->systemCodeRoute:I

    .line 982
    return-void
.end method

.method static capture(Ljava/lang/Object;)Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;
    .locals 6

    .line 985
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    .line 986
    const-string v1, "mDefaultRoute"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    .line 987
    const-string v2, "mDefaultIsoDepRoute"

    invoke-static {p0, v2}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v2

    .line 988
    const-string v3, "mDefaultOffHostRoute"

    invoke-static {p0, v3}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v3

    .line 989
    const-string v4, "mDefaultFelicaRoute"

    invoke-static {p0, v4}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    .line 990
    const-string v5, "mDefaultScRoute"

    invoke-static {p0, v5}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    invoke-direct/range {v0 .. v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;-><init>(IIIII)V

    .line 985
    return-object v0
.end method


# virtual methods
.method describe()Ljava/lang/String;
    .locals 2

    .line 1018
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{aid=0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->defaultRoute:I

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",iso=0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->isoDepRoute:I

    .line 1019
    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",ab=0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->offHostRoute:I

    .line 1020
    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",f=0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->felicaRoute:I

    .line 1021
    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",sc=0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->systemCodeRoute:I

    .line 1022
    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1018
    return-object v0
.end method

.method matches(Ljava/lang/Object;)Z
    .locals 2

    .line 994
    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->defaultRoute:I

    const-string v1, "mDefaultRoute"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->isoDepRoute:I

    .line 995
    const-string v1, "mDefaultIsoDepRoute"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->offHostRoute:I

    .line 997
    const-string v1, "mDefaultOffHostRoute"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->felicaRoute:I

    .line 999
    const-string v1, "mDefaultFelicaRoute"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    if-ne v0, v1, :cond_0

    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->systemCodeRoute:I

    .line 1001
    const-string v1, "mDefaultScRoute"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p1

    if-ne v0, p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 994
    :goto_0
    return p1
.end method

.method restoreIfChanged(Ljava/lang/Object;)Z
    .locals 2

    .line 1006
    invoke-virtual {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->matches(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1007
    const/4 p1, 0x0

    return p1

    .line 1009
    :cond_0
    const-string v0, "mDefaultRoute"

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->defaultRoute:I

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 1010
    const-string v0, "mDefaultIsoDepRoute"

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->isoDepRoute:I

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 1011
    const-string v0, "mDefaultOffHostRoute"

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->offHostRoute:I

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 1012
    const-string v0, "mDefaultFelicaRoute"

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->felicaRoute:I

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 1013
    const-string v0, "mDefaultScRoute"

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;->systemCodeRoute:I

    invoke-static {p1, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setIntField(Ljava/lang/Object;Ljava/lang/String;I)V

    .line 1014
    const/4 p1, 0x1

    return p1
.end method

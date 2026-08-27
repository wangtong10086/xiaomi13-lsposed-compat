.class final Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;
.super Ljava/lang/Object;
.source "EseRouteResolver.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field final reason:Ljava/lang/String;

.field final route:I


# direct methods
.method constructor <init>(ILjava/lang/String;)V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    iput p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->route:I

    .line 19
    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->reason:Ljava/lang/String;

    .line 20
    return-void
.end method


# virtual methods
.method isAvailable()Z
    .locals 1

    .line 23
    iget v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/EseRouteResolver$Result;->route:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

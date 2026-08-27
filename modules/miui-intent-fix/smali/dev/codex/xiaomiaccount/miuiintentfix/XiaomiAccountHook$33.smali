.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->rearmTsmNfcForegroundDispatch(Ljava/lang/Object;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$activityObject:Ljava/lang/Object;

.field final synthetic val$attempt:I


# direct methods
.method constructor <init>(Ljava/lang/Object;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1955
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;->val$activityObject:Ljava/lang/Object;

    iput p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;->val$attempt:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 1958
    iget-object v0, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;->val$activityObject:Ljava/lang/Object;

    iget v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;->val$attempt:I

    add-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$6100(Ljava/lang/Object;I)V

    .line 1959
    return-void
.end method

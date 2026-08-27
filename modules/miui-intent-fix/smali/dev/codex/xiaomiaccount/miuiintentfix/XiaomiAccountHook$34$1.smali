.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34$1;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;->onTagDiscovered(Landroid/nfc/Tag;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;

.field final synthetic val$tag:Landroid/nfc/Tag;


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;Landroid/nfc/Tag;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1978
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;

    iput-object p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34$1;->val$tag:Landroid/nfc/Tag;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 1982
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.nfc.action.TAG_DISCOVERED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1983
    const-string v1, "android.nfc.extra.TAG"

    iget-object v2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34$1;->val$tag:Landroid/nfc/Tag;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 1984
    iget-object v1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;

    iget-object v1, v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;->val$fragment:Ljava/lang/Object;

    const-string v2, "r4"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 1985
    const-string v0, "TSM NFC reader mode forwarded tag to copy flow"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1989
    goto :goto_0

    .line 1986
    :catchall_0
    move-exception v0

    .line 1987
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TSM NFC reader mode forward failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$400(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 1988
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1990
    :goto_0
    return-void
.end method

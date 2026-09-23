package dev.codex.xiaomiaccount.miuiintentfix;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

/** A launcher entry in the existing module, forwarding only to the official app. */
public final class WalletLauncherActivity extends Activity {
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW,
                    Uri.parse("https://tsmclient.mi.com/swiping"));
            intent.addCategory(Intent.CATEGORY_DEFAULT);
            intent.setComponent(new ComponentName("com.miui.tsmclient",
                    "com.miui.tsmclient.ui.quick.DoubleClickActivity"));
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP
                    | Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
            startActivity(intent);
            finish();
        } catch (ActivityNotFoundException | SecurityException unavailable) {
            new AlertDialog.Builder(this).setTitle("小米卡包")
                    .setMessage("无法打开小米卡包，请检查卡包应用是否已安装并启用。")
                    .setPositiveButton(android.R.string.ok, (dialog, which) -> finish())
                    .setOnCancelListener(dialog -> finish()).show();
        }
    }
}

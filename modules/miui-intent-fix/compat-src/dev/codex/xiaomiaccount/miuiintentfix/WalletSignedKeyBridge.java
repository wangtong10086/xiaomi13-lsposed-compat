package dev.codex.xiaomiaccount.miuiintentfix;

import android.content.Context;
import android.os.Binder;
import android.util.Log;
import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Collections;
import java.util.IdentityHashMap;
import java.util.Map;

/** Restores Xiaomi's read-only signed-public-key endpoint using the real vendor HAL. */
public final class WalletSignedKeyBridge implements IXposedHookLoadPackage {
    private static final String SE_HASH = "a1494cf4e10549765a222d73653cd702ef94de35f844b82b59fd67024bf3fd78";
    private static final String WALLET = "com.miui.tsmclient";
    private static final byte[] AID = "getSpiSignedPK".getBytes(StandardCharsets.US_ASCII);
    private static final Map<Object, Owner> CHANNELS = Collections.synchronizedMap(new IdentityHashMap<>());

    private static final class Owner {
        final Object terminal;
        final int uid = Binder.getCallingUid();
        final int pid = Binder.getCallingPid();
        Owner(Object terminal) { this.terminal = terminal; }
    }

    @Override public void handleLoadPackage(XC_LoadPackage.LoadPackageParam p) {
        if (!"com.android.se".equals(p.packageName)) return;
        try {
            if (p.appInfo == null || !SE_HASH.equals(hash(p.appInfo.sourceDir))) {
                Log.i("WalletSignedKeyBridge", "inactive: SecureElement build mismatch");
                return;
            }
            Class<?> terminal = XposedHelpers.findClass("com.android.se.Terminal", p.classLoader);
            Class<?> channel = XposedHelpers.findClass("com.android.se.Channel", p.classLoader);
            Method open = null;
            for (Method m : terminal.getDeclaredMethods()) {
                if (m.getName().equals("openLogicalChannel") && m.getParameterTypes().length == 7) open = m;
            }
            if (open == null) throw new NoSuchMethodException("openLogicalChannel");
            // Install handling first; no virtual channel is created if any hook fails.
            XposedHelpers.findAndHookMethod(channel, "transmit", byte[].class, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam call) {
                    Owner owner = CHANNELS.get(call.thisObject);
                    if (owner == null) return;
                    try {
                        if (Binder.getCallingUid() != owner.uid || Binder.getCallingPid() != owner.pid)
                            throw new SecurityException("Signed-key endpoint owner mismatch");
                        if (Boolean.TRUE.equals(XposedHelpers.callMethod(call.thisObject, "isClosed")))
                            throw new IllegalStateException("Channel is closed");
                        byte[] command = (byte[]) call.args[0];
                        if (command == null || command.length != 0)
                            throw new IllegalArgumentException("Signed-key endpoint accepts only an empty request");
                        byte[] response;
                        synchronized (XposedHelpers.getObjectField(owner.terminal, "mLock")) {
                            response = (byte[]) XposedHelpers.callMethod(owner.terminal, "transmit",
                                    new byte[]{(byte) 0xff, (byte) 0xff, (byte) 0xab, (byte) 0xcd});
                        }
                        // This vendor endpoint returns an ASCII parameter string, not an
                        // APDU with SW1/SW2. Preserve its bytes for the server to verify.
                        if (!WalletSignedKeyFormat.isWellFormed(response))
                            throw new IOException("Vendor signed-key endpoint returned invalid data");
                        Log.i("WalletSignedKeyBridge", "vendor read succeeded length=" + response.length);
                        call.setResult(response);
                    } catch (Throwable failure) {
                        Log.i("WalletSignedKeyBridge", "vendor read failed: " + failure.getClass().getSimpleName());
                        call.setThrowable(failure);
                    }
                }
            });
            XposedHelpers.findAndHookMethod(terminal, "closeChannel", channel, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam call) {
                    Owner owner = CHANNELS.get(call.args[0]);
                    if (owner == null || owner.terminal != call.thisObject) return;
                    synchronized (XposedHelpers.getObjectField(call.thisObject, "mLock")) {
                        Map<?, ?> channels = (Map<?, ?>) XposedHelpers.getObjectField(call.thisObject, "mChannels");
                        Object id = XposedHelpers.callMethod(call.args[0], "getChannelNumber");
                        channels.remove(id, call.args[0]);
                        CHANNELS.remove(call.args[0]);
                    }
                    // Channel.close still performs normal binder and session cleanup.
                    call.setResult(null);
                }
            });
            XposedHelpers.findAndHookMethod(channel, "selectNext", new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam call) {
                    if (CHANNELS.containsKey(call.thisObject))
                        call.setThrowable(new UnsupportedOperationException("Signed-key endpoint has no applet selection"));
                }
            });
            XposedBridge.hookMethod(open, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam call) throws Throwable {
                    if (!Arrays.equals(AID, (byte[]) call.args[1]) || !WALLET.equals(call.args[4])) return;
                    if (!"eSE1".equals(XposedHelpers.callMethod(call.thisObject, "getName"))) return;
                    Context context = (Context) XposedHelpers.getObjectField(call.thisObject, "mContext");
                    if (context.getPackageManager().getApplicationInfo(WALLET, 0).uid != Binder.getCallingUid()) return;
                    if (!XposedHelpers.getBooleanField(call.thisObject, "mIsConnected")) return;
                    Object access = XposedHelpers.callMethod(call.thisObject, "setUpChannelAccess",
                            call.args[1], call.args[4], call.args[5], call.args[6], false);
                    synchronized (XposedHelpers.getObjectField(call.thisObject, "mLock")) {
                        @SuppressWarnings("unchecked") Map<Integer, Object> channels =
                                (Map<Integer, Object>) XposedHelpers.getObjectField(call.thisObject, "mChannels");
                        int id = -1;
                        while (channels.containsKey(id) && id >= -16) id--;
                        if (id < -16) throw new IOException("Signed-key endpoints busy");
                        Object virtual = XposedHelpers.newInstance(channel, call.args[0], call.thisObject,
                                id, new byte[0], AID.clone(), call.args[3]);
                        XposedHelpers.callMethod(virtual, "setChannelAccess", access);
                        CHANNELS.put(virtual, new Owner(call.thisObject));
                        channels.put(id, virtual);
                        call.setResult(virtual);
                    }
                    Log.i("WalletSignedKeyBridge", "opened wallet signed-key endpoint");
                }
            });
            Log.i("WalletSignedKeyBridge", "enabled for verified SecureElement build; wallet endpoint only");
        } catch (Throwable failure) {
            Log.i("WalletSignedKeyBridge", "install failed: " + failure.getClass().getSimpleName());
        }
    }

    private static String hash(String path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (FileInputStream input = new FileInputStream(path)) {
            byte[] buffer = new byte[32768];
            int count;
            while ((count = input.read(buffer)) != -1) digest.update(buffer, 0, count);
        }
        StringBuilder output = new StringBuilder();
        for (byte b : digest.digest()) output.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
        return output.toString();
    }
}

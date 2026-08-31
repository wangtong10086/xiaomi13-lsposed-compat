package de.robv.android.xposed;

import java.util.Set;

public final class XposedBridge {
    public static void log(String message) {}
    public static void log(Throwable error) {}
    public static Set<XC_MethodHook.Unhook> hookAllMethods(
            Class<?> hookClass, String methodName, XC_MethodHook callback) { return null; }
}

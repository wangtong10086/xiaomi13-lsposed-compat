package de.robv.android.xposed;

public final class XposedHelpers {
    public static XC_MethodHook.Unhook findAndHookMethod(Class<?> clazz, String name, Object... parameters) { return null; }
    public static Object newInstance(Class<?> clazz, Object... args) { return null; }
    public static Object getObjectField(Object object, String field) { return null; }
    public static Object getStaticObjectField(Class<?> clazz, String field) { return null; }
    public static void setObjectField(Object object, String field, Object value) {}
    public static int getIntField(Object object, String field) { return 0; }
    public static boolean getBooleanField(Object object, String field) { return false; }
    public static XC_MethodHook.Unhook findAndHookMethod(String className, ClassLoader classLoader,
            String methodName, Object... parameterTypesAndCallback) { return null; }
    public static Class<?> findClass(String className, ClassLoader classLoader) { return null; }
    public static Object callMethod(Object object, String methodName, Object... args) { return null; }
    public static Object callStaticMethod(Class<?> clazz, String methodName, Object... args) { return null; }
}

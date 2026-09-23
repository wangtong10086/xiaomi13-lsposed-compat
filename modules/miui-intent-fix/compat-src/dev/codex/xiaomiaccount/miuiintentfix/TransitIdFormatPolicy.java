package dev.codex.xiaomiaccount.miuiintentfix;

import java.util.HashMap;
import java.util.Map;

/** Request compatibility mapping; this does not reconstruct an OEM VAID. */
final class TransitIdFormatPolicy {
    static String route(Object method, Object url) {
        if (!"POST".equals(method)) return null;
        if ("https://tsmapi.pay.xiaomi.com/api/login/transferCard/startTransferIn".equals(url)) return "startTransferIn";
        if ("https://tsmapi.pay.xiaomi.com/api/login/sporder/v2/create".equals(url)) return "createOrder";
        return null;
    }

    static Map<String, String> copyForRequest(Object method, Object url, Map<?, ?> original) {
        if (route(method, url) == null || original == null) return null;
        Object id = original.get("deviceId");
        if (!(id instanceof String) || !((String) id).matches(
                "vaid_[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}")) return null;
        Map<String, String> copy = new HashMap<>();
        for (Map.Entry<?, ?> entry : original.entrySet()) {
            if (!(entry.getKey() instanceof String)
                    || (entry.getValue() != null && !(entry.getValue() instanceof String))) return null;
            copy.put((String) entry.getKey(), (String) entry.getValue());
        }
        // Stable mapping to the accepted 16-hex-digit request format. No provider,
        // persistent identifier, preloaded card, or account cache is updated.
        String hex = ((String) id).substring(5).replace("-", "");
        copy.put("deviceId", "vaid_" + hex.substring(0, 16));
        return copy;
    }
}

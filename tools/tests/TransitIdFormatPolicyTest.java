package dev.codex.xiaomiaccount.miuiintentfix;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/** Synthetic data; checks isolation of the request-format compatibility mapping. */
public final class TransitIdFormatPolicyTest {
    private static final String TRANSFER = "https://tsmapi.pay.xiaomi.com/api/login/transferCard/startTransferIn";
    private static final String CREATE = "https://tsmapi.pay.xiaomi.com/api/login/sporder/v2/create";
    private static final String ID = "vaid_01234567-89ab-cdef-0123-456789abcdef";
    private static int cases;
    private static void check(boolean value) {
        if (!value) throw new AssertionError("Case " + cases);
        cases++;
    }
    public static void main(String[] args) {
        Map<String, String> values = new HashMap<>();
        values.put("deviceId", ID);
        values.put("token", "synthetic-token");
        values.put("orderId", "synthetic-order");
        values.put("cplc", "synthetic-cplc");
        values.put("optional", null);
        Map<String, String> original = Collections.unmodifiableMap(values);
        for (String url : new String[]{TRANSFER, CREATE}) {
            Map<String, String> copy = TransitIdFormatPolicy.copyForRequest("POST", url, original);
            check(copy != null && copy != original && copy.get("deviceId").equals("vaid_0123456789abcdef"));
            check(original.get("deviceId").equals(ID));
            copy.put("deviceId", ID);
            check(copy.equals(original));
        }
        for (String url : new String[]{TRANSFER + "?x=1", TRANSFER + "/", TRANSFER.replace("https:", "http:"),
                TRANSFER.replace("tsmapi.pay.xiaomi.com", "example.invalid"),
                "https://tsmapi.pay.xiaomi.com/api/login/unionPay/v2/bankCardFirstPage"}) {
            check(TransitIdFormatPolicy.copyForRequest("POST", url, original) == null);
        }
        check(TransitIdFormatPolicy.copyForRequest("GET", TRANSFER, original) == null);
        for (String id : new String[]{"vaid_0123456789abcdef", "", "vaid_invalid", ID.toUpperCase(), ID + "extra"}) {
            values.put("deviceId", id);
            check(TransitIdFormatPolicy.copyForRequest("POST", TRANSFER, original) == null);
        }
        check(TransitIdFormatPolicy.copyForRequest("POST", TRANSFER, null) == null);
        Map<String, Object> bad = new HashMap<>();
        bad.put("deviceId", ID);
        bad.put("unexpected", Integer.valueOf(1));
        check(TransitIdFormatPolicy.copyForRequest("POST", TRANSFER, bad) == null);
        System.out.println("Transit format compatibility: " + cases + " isolation cases passed");
    }
}

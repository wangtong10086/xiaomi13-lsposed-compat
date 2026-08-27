package dev.codex.xiaomiaccount.miuiintentfix;

import java.util.Collections;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class EseRouteResolver {
    private static final int LEGACY_NXP_ESE_ROUTE = 1;
    private static final int NCI_NXP_ESE_ROUTE = 192;
    private static final int ROUTE_UNAVAILABLE = 0;
    private static final int TECH_A_OR_B_MASK = 3;

    static final class Result {
        final String reason;
        final int route;

        Result(int i, String str) {
            this.route = i;
            this.reason = str;
        }

        boolean isAvailable() {
            return this.route > 0;
        }
    }

    private EseRouteResolver() {
    }

    static Result resolve(int i, Map<String, Integer> map, boolean z, boolean z2) {
        if (i <= 0) {
            return new Result(ROUTE_UNAVAILABLE, "framework_route_missing");
        }
        if (map == null) {
            map = Collections.emptyMap();
        }
        Integer num = map.get("eSE1");
        if (num != null) {
            if ((num.intValue() & TECH_A_OR_B_MASK) == 0) {
                return new Result(ROUTE_UNAVAILABLE, "ese_has_no_type_a_or_b");
            }
            return new Result(i, "framework_active_nfcee");
        }
        if (containsEseEntry(map)) {
            return new Result(ROUTE_UNAVAILABLE, "unexpected_ese_instance");
        }
        if (i == LEGACY_NXP_ESE_ROUTE && z && z2) {
            return new Result(NCI_NXP_ESE_ROUTE, "nxp_legacy_route_bridge");
        }
        return new Result(ROUTE_UNAVAILABLE, "active_ese_not_verified");
    }

    private static boolean containsEseEntry(Map<String, Integer> map) {
        for (String str : map.keySet()) {
            if (str != null && str.regionMatches(true, ROUTE_UNAVAILABLE, "eSE", ROUTE_UNAVAILABLE, TECH_A_OR_B_MASK)) {
                return true;
            }
        }
        return false;
    }
}

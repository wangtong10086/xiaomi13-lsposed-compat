package dev.codex.xiaomiaccount.miuiintentfix;

import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
final class EseRoutingStateMachine {
    private String blockedApplyKey;
    private String lastDesiredKey;
    private boolean ownsRouting;
    private boolean recoveryBlocked;

    enum Action {
        NONE,
        APPLY,
        RECOVER
    }

    EseRoutingStateMachine() {
    }

    static final class CardRecord {
        final String aid;
        final long timestamp;
        final String type;

        private CardRecord(String str, String str2, long j) {
            this.aid = str;
            this.type = str2;
            this.timestamp = j;
        }

        static CardRecord parse(String str) {
            if (str == null || str.trim().isEmpty()) {
                return null;
            }
            String[] strArrSplit = str.trim().split(",", -1);
            if (strArrSplit.length != 3) {
                return null;
            }
            String upperCase = strArrSplit[0].trim().toUpperCase(Locale.US);
            String strTrim = strArrSplit[1].trim();
            if (upperCase.length() < 10 || upperCase.length() > 32 || (1 & upperCase.length()) != 0 || !isHex(upperCase) || strTrim.isEmpty() || !isSafeType(strTrim)) {
                return null;
            }
            try {
                long j = Long.parseLong(strArrSplit[2].trim());
                if (j <= 0) {
                    return null;
                }
                return new CardRecord(upperCase, strTrim, j);
            } catch (NumberFormatException e) {
                return null;
            }
        }

        String key() {
            return this.aid + "," + this.type + "," + this.timestamp;
        }

        String fingerprint() {
            return Integer.toHexString(key().hashCode());
        }

        private static boolean isHex(String str) {
            for (int i = 0; i < str.length(); i++) {
                char cCharAt = str.charAt(i);
                if ((cCharAt < '0' || cCharAt > '9') && (cCharAt < 'A' || cCharAt > 'F')) {
                    return false;
                }
            }
            return true;
        }

        private static boolean isSafeType(String str) {
            for (int i = 0; i < str.length(); i++) {
                char cCharAt = str.charAt(i);
                if ((cCharAt < 'A' || cCharAt > 'Z') && ((cCharAt < 'a' || cCharAt > 'z') && ((cCharAt < '0' || cCharAt > '9') && cCharAt != '_' && cCharAt != '-' && cCharAt != '.'))) {
                    return false;
                }
            }
            return true;
        }
    }

    static final class Decision {
        final Action action;
        final String reason;
        final CardRecord record;

        Decision(Action action, CardRecord cardRecord, String str) {
            this.action = action;
            this.record = cardRecord;
            this.reason = str;
        }

        public String toString() {
            return "Decision{action=" + this.action + ", record=" + (this.record == null ? "none" : this.record.fingerprint()) + ", reason='" + this.reason + "'}";
        }
    }

    Decision reconcile(String str, boolean z, boolean z2, boolean z3, boolean z4, boolean z5) {
        String str2;
        CardRecord cardRecord = CardRecord.parse(str);
        boolean z6 = z && z2 && cardRecord != null;
        String strKey = z6 ? cardRecord.key() : null;
        if (!same(this.lastDesiredKey, strKey)) {
            this.lastDesiredKey = strKey;
            this.blockedApplyKey = null;
            this.recoveryBlocked = false;
        }
        if (!z4) {
            return new Decision(Action.NONE, cardRecord, "nfc_not_ready");
        }
        if (!z6) {
            if (!z) {
                str2 = "feature_disabled";
            } else if (!z2) {
                str2 = "tsm_unavailable";
            } else if (str != null && !str.trim().isEmpty()) {
                str2 = "invalid_record";
            } else {
                str2 = "no_active_card";
            }
            if (this.ownsRouting && !this.recoveryBlocked) {
                return new Decision(Action.RECOVER, cardRecord, str2);
            }
            Action action = Action.NONE;
            if (this.recoveryBlocked) {
                str2 = "recovery_blocked";
            }
            return new Decision(action, cardRecord, str2);
        }
        if (this.ownsRouting) {
            return new Decision(Action.NONE, cardRecord, "already_applied");
        }
        if (!z3) {
            return new Decision(Action.NONE, cardRecord, "ese_unavailable");
        }
        if (z5) {
            return new Decision(Action.NONE, cardRecord, "third_party_override");
        }
        if (same(this.blockedApplyKey, strKey)) {
            return new Decision(Action.NONE, cardRecord, "apply_blocked_after_failure");
        }
        return new Decision(Action.APPLY, cardRecord, "active_card");
    }

    void onApplyResult(Decision decision, boolean z, boolean z2) {
        if (z) {
            this.ownsRouting = true;
            this.blockedApplyKey = null;
            this.recoveryBlocked = false;
        } else {
            this.blockedApplyKey = decision.record == null ? this.lastDesiredKey : decision.record.key();
            this.ownsRouting = !z2;
            this.recoveryBlocked = !z2;
        }
    }

    void onRecoverResult(boolean z) {
        if (z) {
            this.ownsRouting = false;
            this.recoveryBlocked = false;
        } else {
            this.recoveryBlocked = true;
        }
    }

    void onExternalRecovery() {
        this.ownsRouting = false;
        this.recoveryBlocked = false;
    }

    void onNfcCycleReset() {
        this.ownsRouting = false;
        this.blockedApplyKey = null;
        this.recoveryBlocked = false;
    }

    boolean ownsRouting() {
        return this.ownsRouting;
    }

    private static boolean same(String str, String str2) {
        if (str == null) {
            return str2 == null;
        }
        return str.equals(str2);
    }
}

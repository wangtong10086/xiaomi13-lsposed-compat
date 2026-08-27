package dev.codex.xiaomiaccount.miuiintentfix;

/* JADX INFO: loaded from: classes.dex */
final class PowerGestureStateMachine {
    static final long DEFAULT_MAX_INTERVAL_MS = 300;
    private long lastEventTime = -1;
    private final long maxIntervalMs;
    private int tapCount;

    enum Action {
        NONE,
        SCHEDULE_XIAOMI,
        SCHEDULE_GOOGLE,
        CANCEL_WALLETS
    }

    static final class Decision {
        final Action action;
        final boolean consumePowerKey;
        final int tapCount;

        Decision(int i, Action action, boolean z) {
            this.tapCount = i;
            this.action = action;
            this.consumePowerKey = z;
        }

        public String toString() {
            return "Decision{tapCount=" + this.tapCount + ", action=" + this.action + ", consumePowerKey=" + this.consumePowerKey + "}";
        }
    }

    PowerGestureStateMachine(long j) {
        if (j <= 0) {
            throw new IllegalArgumentException("maxIntervalMs must be positive");
        }
        this.maxIntervalMs = j;
    }

    Decision onPowerDown(long j, boolean z) {
        if (z) {
            reset();
            return new Decision(0, Action.CANCEL_WALLETS, false);
        }
        long j2 = this.lastEventTime < 0 ? Long.MAX_VALUE : j - this.lastEventTime;
        if (j2 >= 0 && j2 < this.maxIntervalMs) {
            this.tapCount++;
        } else {
            this.tapCount = 1;
        }
        this.lastEventTime = j;
        switch (this.tapCount) {
            case 2:
                return new Decision(2, Action.SCHEDULE_XIAOMI, true);
            case 3:
                return new Decision(3, Action.SCHEDULE_GOOGLE, true);
            case 4:
                return new Decision(4, Action.CANCEL_WALLETS, true);
            case 5:
                Decision decision = new Decision(5, Action.CANCEL_WALLETS, false);
                reset();
                return decision;
            default:
                return new Decision(this.tapCount, Action.NONE, false);
        }
    }

    void reset() {
        this.lastEventTime = -1L;
        this.tapCount = 0;
    }
}

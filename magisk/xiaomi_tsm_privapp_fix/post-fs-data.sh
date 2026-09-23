#!/system/bin/sh
# Preserve this module's existing early live-policy loader as well as sepolicy.rule.
# Magisk's policy grammar separates target, class and permission with spaces.
MODDIR=${0%/*}
LOG=/data/local/tmp/xiaomi-tsm-omapi-policy.log
failed=0
{
    echo "=== $(date '+%F %T') wallet policy ==="
    while IFS= read -r rule || [ -n "$rule" ]; do
        case "$rule" in ''|'#'*) continue ;; esac
        output=$(magiskpolicy --live "$rule" 2>&1)
        status=$?
        # Some Magisk builds report syntax errors with a zero exit status.
        # sepolicy.rule may already have created this exact type during init.
        case "$rule" in
            'type hal_mtdservice_default domain')
                [ "$output" = 'Type hal_mtdservice_default already exists' ] && output= ;;
            'type hal_mtdservice_default_exec file_type')
                [ "$output" = 'Type hal_mtdservice_default_exec already exists' ] && output= ;;
        esac
        if [ "$status" -ne 0 ] || [ -n "$output" ]; then
            echo "Policy load failed: $rule"
            echo "$output"
            failed=1
        else
            echo "Applied: $rule"
        fi
    done < "$MODDIR/sepolicy.rule"
} >> "$LOG" 2>&1
if [ "$failed" -eq 0 ]; then
    /system/bin/sh "$MODDIR/prepare-mtd.sh" >> "$LOG" 2>&1 || failed=1
fi
# Only the exact approved OEM wallet needs the persistent separate-UID parser.
# Never open the short-lived signature-migration window automatically.
wallet_apk="$MODDIR/system/system_ext/priv-app/MiuiTsmClient/MiuiTsmClient.apk"
wallet_hash=$(sha256sum "$wallet_apk" 2>/dev/null | cut -d ' ' -f 1)
if [ "$wallet_hash" = 1823e8ee6b6170884e135cb758baa1d06b7c9d038dcfea3cd2b1bca83a0f4170 ]; then
    marker=/data/local/tmp/xiaomi-wallet-official-package.enabled
    touch "$marker" && chown 0:0 "$marker" && chmod 0644 "$marker" || failed=1
fi
# Enable only when explicitly configured on the validated device. The companion
# hook also checks the wallet/provider APK hashes and the exact transit routes.
transit_marker=/data/local/tmp/xiaomi-wallet-transit-id-format.enabled
if [ "$wallet_hash" = 1823e8ee6b6170884e135cb758baa1d06b7c9d038dcfea3cd2b1bca83a0f4170 ] \
        && [ -f "$MODDIR/enable-transit-id-format-compat" ]; then
    touch "$transit_marker" && chown 0:0 "$transit_marker" && chmod 0644 "$transit_marker" || failed=1
else
    rm -f "$transit_marker" || failed=1
fi
exit "$failed"

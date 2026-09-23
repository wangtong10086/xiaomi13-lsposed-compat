#!/system/bin/sh
MODDIR=${0%/*}
[ -f "$MODDIR/disable-mtd" ] && exit 0
LOG=/data/local/tmp/xiaomi-tsm-omapi-policy.log
/system/bin/sh "$MODDIR/prepare-mtd.sh" >> "$LOG" 2>&1 || exit 1
if [ "$(getprop init.svc.vendor.mtdservice-1-3)" != running ]; then
    setprop ctl.start vendor.mtdservice-1-3
fi

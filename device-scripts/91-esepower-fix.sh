#!/system/bin/sh

unset LD_PRELOAD
unset LD_LIBRARY_PATH
unset PREFIX
export PATH=/system/bin:/system/xbin:/vendor/bin:/vendor/bin/hw:/odm/bin:/product/bin:/apex/com.android.runtime/bin

LOG=/data/local/tmp/esepower-fix.log

{
  echo "=== $(date '+%F %T') esepower fix ==="

  until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
  done
  sleep 10

  if ! pidof vendor.qti.esepowermanager@1.1-service >/dev/null 2>&1; then
    /vendor/bin/hw/vendor.qti.esepowermanager@1.1-service >/data/local/tmp/esepower-stdout.log 2>/data/local/tmp/esepower-stderr.log &
    sleep 2
  fi

  echo "esepower_pid=$(pidof vendor.qti.esepowermanager@1.1-service 2>/dev/null)"

  setprop ctl.restart secureelement-hal_1_2
  sleep 3
  am force-stop com.android.se >/dev/null 2>&1
  cmd package unstop --user 0 com.android.se >/dev/null 2>&1
  sleep 3

  dumpsys secure_element | sed -n '1,45p'
  # Vector loads the SE hook during normal process startup.
  # A delayed SIGKILL can interrupt in-flight wallet APDUs; do not restart here.
  echo "done"
} >> "$LOG" 2>&1

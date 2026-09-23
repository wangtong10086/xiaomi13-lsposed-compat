#!/system/bin/sh
# Restore the label of the existing, hash-locked OEM executable. No binary patching.
MODDIR=${0%/*}
TARGET=/odm/bin/mtd@1.3
COPY="$MODDIR/mtd-runtime/mtd@1.3"
EXPECTED=3a08d463ba61f505288fcdab7880167fe76357d59a4cfb1de6ef00e07120bc2f
EXPECTED_LIB=2276402a6726291342d2b2da0f2b9eb23dc6fea5c0a7413bf1d45f504def1f26

[ -f "$MODDIR/disable-mtd" ] && exit 0
digest() { sha256sum "$1" 2>/dev/null | cut -d ' ' -f 1; }
[ "$(digest "$TARGET")" = "$EXPECTED" ] || { echo 'MTD inactive: executable mismatch'; exit 1; }
[ "$(digest /odm/lib64/libmt@1.3.so)" = "$EXPECTED_LIB" ] || { echo 'MTD inactive: library mismatch'; exit 1; }
mkdir -p "$MODDIR/mtd-runtime" || exit 1
if [ "$(digest "$COPY")" != "$EXPECTED" ]; then
    cp "$TARGET" "$COPY.new" && chown 0:0 "$COPY.new" && chmod 0755 "$COPY.new" || exit 1
    [ "$(digest "$COPY.new")" = "$EXPECTED" ] || exit 1
    mv "$COPY.new" "$COPY" || exit 1
fi
chcon u:object_r:hal_mtdservice_default_exec:s0 "$COPY" || exit 1
# Magisk can run scripts in a separate namespace; init must see the new label.
if [ "$(nsenter -t 1 -m -- stat -c %C "$TARGET")" != 'u:object_r:hal_mtdservice_default_exec:s0' ]; then
    nsenter -t 1 -m -- mount --bind "$COPY" "$TARGET" || exit 1
fi
echo 'MTD executable verified and labeled'

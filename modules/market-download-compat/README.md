# Xiaomi Market DownloadManager compatibility

Scope: `com.xiaomi.market` only.

Xiaomi Market 4.119.1 reflects `DownloadManager.setAccessFilename` and later reads `COLUMN_LOCAL_FILENAME`. On Android 16 the reflective call is denied for the app, so the cursor read throws and the Market deletes the still-active download record.

Immediately before `DownloadManager.query`, this module sets the instance's `mAccessFilename` field to `true`. It does not change DownloadManager globally and does not hook other packages.

The final scoped build was validated with Android hidden-API global overrides unset and with complete in-place app updates through Xiaomi Market.

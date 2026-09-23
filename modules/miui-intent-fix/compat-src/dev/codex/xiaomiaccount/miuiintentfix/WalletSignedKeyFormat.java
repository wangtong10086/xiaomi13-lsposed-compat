package dev.codex.xiaomiaccount.miuiintentfix;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/** Structural validation only. Authenticity is checked by the unmodified server. */
final class WalletSignedKeyFormat {
    private WalletSignedKeyFormat() {}

    static boolean isWellFormed(byte[] response) {
        if (response == null || response.length < 100 || response.length > 2048) return false;
        for (byte b : response) if (b < 0x21 || b > 0x7e) return false;
        Map<String, String> fields = new HashMap<>();
        for (String part : new String(response, StandardCharsets.US_ASCII).split("&", -1)) {
            int split = part.indexOf('=');
            if (split <= 0 || split == part.length() - 1) return false;
            if (fields.put(part.substring(0, split), part.substring(split + 1)) != null) return false;
        }
        if (fields.size() != 8 || !"tsmclient".equals(fields.get("appName"))
                || !"ec-secp256r1".equals(fields.get("keyAlg"))) return false;
        for (String key : new String[]{"deviceModel", "cpuModel", "tzId"}) {
            String value = fields.get(key);
            if (value == null || !value.matches("[A-Za-z0-9_.:-]+")
                    || "null".equalsIgnoreCase(value)) return false;
        }
        try {
            if (Base64.getDecoder().decode(fields.get("pkX")).length != 32
                    || Base64.getDecoder().decode(fields.get("pkY")).length != 32) return false;
            byte[] signature = Base64.getDecoder().decode(fields.get("sign"));
            // Reject truncated, non-DER, or zero-value ECDSA signatures (seen when MTD is absent).
            if (signature.length < 8 || signature.length > 72 || signature[0] != 0x30
                    || (signature[1] & 255) != signature.length - 2) return false;
            int position = 2;
            for (int integer = 0; integer < 2; integer++) {
                if (position + 2 > signature.length || signature[position++] != 2) return false;
                int length = signature[position++] & 255;
                if (length < 1 || length > 33 || position + length > signature.length) return false;
                if ((signature[position] & 0x80) != 0) return false;
                if (length > 1 && signature[position] == 0 && (signature[position + 1] & 0x80) == 0) return false;
                if (length == 33 && signature[position] != 0) return false;
                boolean nonzero = false;
                for (int i = 0; i < length; i++) nonzero |= signature[position++] != 0;
                if (!nonzero) return false;
            }
            return position == signature.length;
        } catch (IllegalArgumentException | NullPointerException invalid) {
            return false;
        }
    }
}

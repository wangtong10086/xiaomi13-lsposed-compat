package dev.codex.xiaomiaccount.miuiintentfix;

import java.nio.charset.StandardCharsets;
import java.security.KeyPairGenerator;
import java.security.Signature;
import java.security.spec.ECGenParameterSpec;
import java.util.Base64;

/** Synthetic fixtures only; does not contact a device or trust service. */
public final class WalletSignedKeyFormatTest {
    private static int cases;
    private static void check(String value, boolean expected) {
        boolean actual = WalletSignedKeyFormat.isWellFormed(
                value == null ? null : value.getBytes(StandardCharsets.US_ASCII));
        if (actual != expected) throw new AssertionError("Case " + cases);
        cases++;
    }
    public static void main(String[] args) throws Exception {
        KeyPairGenerator generator = KeyPairGenerator.getInstance("EC");
        generator.initialize(new ECGenParameterSpec("secp256r1"));
        Signature signer = Signature.getInstance("SHA256withECDSA");
        signer.initSign(generator.generateKeyPair().getPrivate());
        signer.update("synthetic test".getBytes(StandardCharsets.US_ASCII));
        String coordinate = Base64.getEncoder().encodeToString(new byte[32]);
        String prefix = "deviceModel=test&appName=tsmclient&cpuModel=test&keyAlg=ec-secp256r1"
                + "&pkX=" + coordinate + "&pkY=" + coordinate + "&tzId=synthetic_test&sign=";
        String valid = prefix + Base64.getEncoder().encodeToString(signer.sign());
        check(valid, true);
        check(null, false);
        check("9000", false);
        check(valid + "&appName=tsmclient", false);
        check(valid.replace("appName=tsmclient", "appName=other"), false);
        check(valid.replace("tzId=synthetic_test", "tzId=(null)"), false);
        check(valid.replace("tzId=synthetic_test", "tzId=null"), false);
        check(valid.replace("&cpuModel=test", ""), false);
        check(valid.replace("pkX=" + coordinate, "pkX=AA=="), false);
        check(prefix + "MAYCAQACAQA=", false); // DER r=0, s=0.
        check(prefix + "MAYCAQH/AQE=", false); // Invalid second INTEGER tag.
        check(prefix + "invalid", false);
        check(valid + "\n", false);
        check(valid + new String(new char[2048]).replace('\0', 'A'), false);
        System.out.println("Wallet signed-key format: " + cases + " cases passed");
    }
}

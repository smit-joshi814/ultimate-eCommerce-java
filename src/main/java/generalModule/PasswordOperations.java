package generalModule;

import java.util.Base64;

public class PasswordOperations {
	// Password Decryption
	public static String PasswordDecrypter(String passsword) {
		Base64.Decoder decoder = Base64.getDecoder();
		String DecryptedPassword = new String(decoder.decode(passsword));
		return DecryptedPassword;
	}

	// Password Encryption
	public static String passwordEncrypter(String password) {
		Base64.Encoder encoder = Base64.getEncoder();
		String EncryptedPassword = encoder.encodeToString(password.getBytes());
		return EncryptedPassword;
	}
}

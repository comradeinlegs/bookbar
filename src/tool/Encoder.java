package tool;

import java.math.BigInteger;
import java.security.MessageDigest;

public class Encoder {
	public static final String KEY_MD5 = "MD5";
	
	public static String encode(String password) {
		BigInteger bigInteger = null;
		try {
			MessageDigest mDigest = MessageDigest.getInstance(KEY_MD5);
			byte[] data = password.getBytes();
			mDigest.update(data);
			bigInteger = new BigInteger(mDigest.digest());
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bigInteger.toString(16);
	}
}

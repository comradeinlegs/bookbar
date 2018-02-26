package tool;

public class Format {
	
	public static boolean mailMatch(String mail) {
		return mail.matches("^\\w+@(\\w+\\.)+\\w+$");
	}
	
	/*
	 * 1: 长度小于6或大于20
	 * 2: 全数字/全字母
	 */
	public static int passwordMatch(String password) {
		if(password.length() < 6 ||password.length() > 20) {
			return 1;
		}
		if(password.matches("^[0-9]*$") || password.matches("^[A-Za-z]+$")) {
			return 2;
		}
		return 0;
	}
	
	public static boolean allDigit(String xString) {
		return xString.matches("^[0-9]*$");
	}
	
}

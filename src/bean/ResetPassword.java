package bean;

public class ResetPassword {
	private String username = "mail";
	private String password = "*";
	private String usernameBack = "";
	private String passwordBack = "";
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsernameBack() {
		return usernameBack;
	}
	public void setUsernameBack(String usernameBack) {
		this.usernameBack = usernameBack;
	}
	public String getPasswordBack() {
		return passwordBack;
	}
	public void setPasswordBack(String passwordBack) {
		this.passwordBack = passwordBack;
	}
}

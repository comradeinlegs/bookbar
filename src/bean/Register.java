package bean;

public class Register {
	private String username = "your email";
	private String password = "";
	private String usernameBack = "";
	private String passwordBack = "";
	private boolean status = false;
	
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}

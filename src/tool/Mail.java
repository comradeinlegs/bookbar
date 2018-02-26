package tool;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail implements Runnable {
	
	private static final String FROM = "13161771177@163.com";
	private static final String PASSWORD = "ZXCVBN123";
	private static final String HOST = "smtp.163.com";
	
	private String to;
	private String code;
	private int flag;
	private String password;
	
	public Mail(String to, String code, int flag) {
		this.to = to;
		this.code = code;
		this.flag = flag; // 1: 激活邮件  2: 重置密码
	}
	
	public Mail(String to, String code, int flag,String password) {
		this.to = to;
		this.code = code;
		this.flag = flag;
		this.password = password;
	}
	
	public void run() {
		//获取系统属性
		Properties properties = System.getProperties();
		//身份验证
		properties.setProperty("mail.smtp.auth", "true");
		//设置邮件服务器
		properties.setProperty("mail.host", HOST);
		//获取默认session对象
		properties.setProperty("mail.transport.protocol", "smtp");
		//确定身份
		Authenticator authenticator = new Authenticator() {
			@Override
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM, PASSWORD);
			}
		};
		Session session = Session.getDefaultInstance(properties, authenticator);
		try {
			//创建默认的MimeMessage对象
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM));
			String content = "";
			switch (flag) {
			case 1:
				message.setSubject("激活账号");
				content = "<html><head></head><body text-align='center'><h1>这是一封激活邮件,激活请点击链接</h1><h3><a href='http://localhost:8080/bookBar/servlet/ActiveUser?code="
						+ code + "'>http://localhost:8080/bookBar/servlet/ActiveUser?code=" + code + "</a></h3></body></html>";
				break;
			
			case 2:
				message.setSubject("重置密码");
				content = "<html><head></head><body text-align='center'><h1>重置密码请点击以下链接</h1><h3><a href='http://localhost:8080/bookBar/servlet/ResetPassword?code="
						+ code + "&password=" + password + "'>http://localhost:8080/bookBar/servlet/ResetPassword?code=" + code + "</a></h3></body></html>";
				System.out.println(content);
				break;

			default:
				break;
			}
			message.setContent(content, "text/html;charset=UTF-8");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			Transport.send(message);
		}
		catch(MessagingException e) {
			e.printStackTrace();
		}
	}
	
}

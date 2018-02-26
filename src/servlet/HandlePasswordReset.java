package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ResetPassword;
import db.DBExecute;
import tool.Format;
import tool.Mail;
import tool.UUCode;

@WebServlet("/HandlePasswordReset")
public class HandlePasswordReset extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HandlePasswordReset() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String mail = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String code = UUCode.generateCode();
		if(handleForm(request, response, mail, newPassword)) {
			DBExecute.update("code", code, "username", mail, "vip");
			new Thread(new Mail(mail, code, 2, newPassword)).start();
			response.sendRedirect("/bookBar/jsp/join/login.jsp?where=reset");
		}
		else {
			request.getRequestDispatcher("/jsp/join/passwordReset.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public static boolean handleForm(HttpServletRequest request, HttpServletResponse response, String username, String password) throws ServletException, IOException {
		ResetPassword resetPassword = new ResetPassword();
		request.setAttribute("repass", resetPassword);
		boolean noError = true;
		if(!Format.mailMatch(username)) {
			resetPassword.setUsernameBack("请输入正确的邮箱格式");
			noError = false;
		}
		else if(!DBExecute.hasExist("username", username, "vip")) {
			resetPassword.setUsernameBack("该邮箱还未注册， 请前往注册页面注册");
			return false;
		}
		else {
			resetPassword.setUsername(username);
		}
		switch (Format.passwordMatch(password)) {
		case 1:
			noError = false;
			resetPassword.setPasswordBack("###");
			break;

		default:
			resetPassword.setPassword(password);
			break;
		}
		return noError;
	}

}

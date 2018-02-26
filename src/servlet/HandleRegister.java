package servlet;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Register;
import db.DBExecute;
import tool.UUCode;
import tool.Format;
import tool.Encoder;
import tool.Mail;


@WebServlet("/HandleRegister")
public class HandleRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    public HandleRegister() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		info.put("username", username);
		info.put("password", Encoder.encode(password));
		String code = UUCode.generateCode();
		info.put("code", code);
		if(handleForm(request, response, username, password)) {
			info.put("status", "false");
			DBExecute.insert(info, "vip");
			new Thread(new Mail(username, code, 1)).start();
			response.sendRedirect("/bookBar/jsp/join/login.jsp?where=register");
		}
		else {
			request.getRequestDispatcher("/jsp/join/register.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public static boolean handleForm(HttpServletRequest request, HttpServletResponse response, String username, String password) throws ServletException, IOException {
		Register register = new Register();
		request.setAttribute("register", register);
		boolean noError = true;
		if(DBExecute.hasExist("username", username, "vip")) {
			System.out.println(1);
			LinkedHashMap<String, String> info = DBExecute.extractInfo("username", username, "vip").get(0);
			if(info.get("status").equals("true")) {
				register.setUsernameBack("该邮箱已经注册过了");
			}
			else {
				register.setUsernameBack("该邮箱已经注册，但未验证，请前往邮箱进行验证");
			}
			register.setUsername(username);;
			return false;
		}
		else if(!Format.mailMatch(username)) {
			register.setUsernameBack("邮箱格式有误，请重新输入");
			noError = false;
		}
		else {
			register.setUsername(username);
		}
		switch (Format.passwordMatch(password)) {
		case 1:
			noError = false;
			register.setPasswordBack("请输入长度为6-30的密码");
			break;
		
		case 2:
			noError = false;
			register.setPasswordBack("请输入同时包含字母和数字的密码");

		default:
			register.setPassword(password);
			break;
		}
		return noError;
	}
}

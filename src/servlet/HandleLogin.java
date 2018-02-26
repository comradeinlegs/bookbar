package servlet;

import java.io.IOException;

import java.net.URLEncoder;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Login;
import db.DBExecute;
import tool.Encoder;
import tool.Mail;

@WebServlet("/HandleLogin")
public class HandleLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HandleLogin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		Login login = new Login();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
		info.put("username", username);
		info.put("password", Encoder.encode(password));
		if(DBExecute.hasExist(info, "vip")) {
			handCookies(request, response, username, password);
			info = DBExecute.extractInfo("username", username, "vip").get(0);
			if(info.get("status").equals("true")) {
				success(request, response, login, info);
			}
			else {
				new Thread(new Mail(username, info.get("code"), 1)).start();
				fail(request, response, login, "邮箱未验证，请前往邮箱进行验证");
			}
		}
		else {
			fail(request, response, login, "账号和密码不匹配");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public void handCookies(HttpServletRequest request, HttpServletResponse response, String username, String password) throws ServletException, IOException {
		String u = URLEncoder.encode(username, "UTF-8");
		String p = URLEncoder.encode(password, "UTF-8");
		Cookie uCookie = new Cookie("username", u);
		Cookie pCookie = new Cookie("password", p);
		uCookie.setPath("/");
		pCookie.setPath("/");
		uCookie.setMaxAge(864000);
		pCookie.setMaxAge(864000);
		response.addCookie(uCookie);
		response.addCookie(pCookie);
	}
	
	public void success(HttpServletRequest request, HttpServletResponse response, Login login, LinkedHashMap<String, String> info) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("login", login);
		login.setStatus("true");	
		login.setName(info.get("name"));
		login.setUsername(info.get("username"));
		login.setLevel(info.get("level"));
		session.setMaxInactiveInterval(600);
		request.getRequestDispatcher("/welcome.jsp").forward(request, response);
	}
	
	public void fail(HttpServletRequest request, HttpServletResponse response, Login login, String backNews) throws ServletException, IOException {
		request.setAttribute("login", login);
		login.setBackNews(backNews);
		request.getRequestDispatcher("/jsp/join/login.jsp?pass=false").forward(request, response);
	}

}

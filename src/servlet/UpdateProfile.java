package servlet;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Login;
import db.DBExecute;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public UpdateProfile() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		Login login = (Login)session.getAttribute("login");
		LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
		info.put("name", request.getParameter("name"));
		if(DBExecute.update(info, "username",login.getUsername(), "vip")) {
			success(request, response, info, login);
		}
		else {
			fail(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public static void success(HttpServletRequest request, HttpServletResponse response, LinkedHashMap<String, String> info, Login login) throws ServletException, IOException {
		login.setName(info.get("name"));
		response.sendRedirect("/bookBar/jsp/info/profile.jsp?update=true");
	}
	
	public static void fail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/jsp/info/profile.jsp?update=false").forward(request, response);
	}

}

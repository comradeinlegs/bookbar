package backStage;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;
import tool.Format;

@WebServlet("/AddConsume")
public class AddConsume extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddConsume() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		if(!Format.allDigit(request.getParameter("thisConsume")) || request.getParameter("thisConsume").equals("")) {
			response.sendRedirect(request.getParameter("nowPath") + "?fail=true");
			return;
		}
		int thisConsume = Integer.parseInt(request.getParameter("thisConsume"));
		int preConsume = Integer.parseInt(request.getParameter("preConsume"));
		int nowConsume = thisConsume + preConsume;
		String username = request.getParameter("username");
		String level = VipLevel.judgeLevel(nowConsume);
		LinkedHashMap<String, String> updateInfo = new LinkedHashMap<String, String>();
		updateInfo.put("totalConsume", Integer.toString(nowConsume));
		updateInfo.put("level", level);
		DBExecute.update(updateInfo, "username", username, "vip");
		response.sendRedirect(request.getParameter("nextPath"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

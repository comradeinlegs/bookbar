package backStage;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;

@WebServlet("/TodayRecommend")
public class TodayRecommend extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TodayRecommend() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
		String type = request.getParameter("type");
		String name = request.getParameter("name");
		String reason = request.getParameter("reason");
		String nextPath = request.getParameter("nextPath");
		info.put("type", type);
		info.put("name", name);
		info.put("reason", reason);
		if(DBExecute.insert(info, "recommend")) {
			response.sendRedirect(nextPath);	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

package backStage;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;

@WebServlet("/DeleteRecommend")
public class DeleteRecommend extends HttpServlet implements Delete {
	private static final long serialVersionUID = 1L;

    public DeleteRecommend() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		LinkedHashMap<String, String> recomInfo = new LinkedHashMap<String, String>();
		recomInfo.put("name", request.getParameter("name"));
		recomInfo.put("type", request.getParameter("type"));
		if(deleteData(recomInfo, "recommend")) {
			response.sendRedirect("/bookBar/backStage/recommend.jsp?delete=true");
		}
		else {
			response.sendRedirect("/bookBar/backStage/recommend.jsp?delete=false");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public boolean deleteData(String key, String value, String table) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteData(LinkedHashMap<String, String> info, String table) {
		return DBExecute.delete(info, table);
	}}

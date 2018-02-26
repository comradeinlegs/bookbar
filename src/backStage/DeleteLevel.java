package backStage;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;

@WebServlet("/DeleteLevel")
public class DeleteLevel extends HttpServlet implements Delete {
	private static final long serialVersionUID = 1L;

    public DeleteLevel() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		if(deleteData("name", name, "vipLevel")) {
			response.sendRedirect("/bookBar/backStage/vip/vipLevel.jsp?delete=true");
		}
		else {
			response.sendRedirect("/bookBar/backStage/vip/vipLevel.jsp?delete=false");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public boolean deleteData(String key, String value, String table) {
		return DBExecute.delete(key, value, table);
	}

	@Override
	public boolean deleteData(LinkedHashMap<String, String> info, String table) {
		// TODO Auto-generated method stub
		return false;
	}

}

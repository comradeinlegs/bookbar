package backStage;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;

@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet implements Delete {
	private static final long serialVersionUID = 1L;
       
    public DeleteBook() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if(deleteData("name", URLDecoder.decode(request.getParameter("name"), "UTF-8"), "book")) {
			response.sendRedirect("/bookBar/backStage/book/bookList.jsp?delete=true&tag=" + URLEncoder.encode(request.getParameter("tag"), "UTF-8"));
		}
		else {
			response.sendRedirect("/bookBar/backStage/book/bookList.jsp?delete=false&tag=" + URLEncoder.encode(request.getParameter("tag"), "UTF-8"));
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public boolean deleteData(String key, String value, String table) {
		String uploadPath = getServletContext().getRealPath("./") + UPLOAD_DIR;
		String img = uploadPath + File.separator + DBExecute.extractInfo(key, value, table).get(0).get("code") + ".jpg";
		if(!img.equals(getServletContext().getRealPath("./") + "noImg.jpg")) {
			if(!new File(img).delete()) {
				return false;
			}
		}
		return DBExecute.delete(key, value, table);
	}

	@Override
	public boolean deleteData(LinkedHashMap<String, String> info, String table) {
		// TODO Auto-generated method stub
		return false;
	}

}

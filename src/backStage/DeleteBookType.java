package backStage;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DBExecute;

@WebServlet("/DeleteBookType")
public class DeleteBookType extends HttpServlet implements Delete {
	private static final long serialVersionUID = 1L;
       
    public DeleteBookType() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if(deleteData("type", request.getParameter("type"), "bookType")) {
			response.sendRedirect("/bookBar/backStage/book/allBookType.jsp?delete=true");
		}
		else {
			response.sendRedirect("/bookBar/backStage/book/allBookType.jsp?delete=false");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public boolean deleteData(String key, String value, String table) {
		ArrayList<LinkedHashMap<String, String>> infos= DBExecute.extractInfo("tag", value, "book");
		for(LinkedHashMap<String, String> info : infos) {
			String uploadPath = getServletContext().getRealPath("./") + UPLOAD_DIR;
			String img = uploadPath + File.separator + info.get("code") + ".jpg";
			LinkedHashMap<String, String> deleteInfo = new LinkedHashMap<String, String>();
			deleteInfo.put("tag", value);
			if(!img.equals(getServletContext().getRealPath("./") + "noImg.jpg")) {
				if(!new File(img).delete() || !DBExecute.delete(deleteInfo, "book")) {
					return false;
				}
			}
			else {
				if(!DBExecute.delete(deleteInfo, "book")) {
					return false;
				}
			}
		}
		if(!DBExecute.delete(key, value, table)) {
			return false;
		}
		return true;
	}

	@Override
	public boolean deleteData(LinkedHashMap<String, String> info, String table) {
		// TODO Auto-generated method stub
		return false;
	}

}

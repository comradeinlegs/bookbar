package servlet;

import java.io.IOException;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Book;
import bean.Menu;
import db.DBExecute;

@WebServlet("/ProductInfo")
public class ProductInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProductInfo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String name = request.getParameter("name");
		LinkedHashMap<String, String> info = DBExecute.extractInfo("name", name, type).get(0);
		if(type.equals("book")) {
			Book book = new Book();
			request.setAttribute("book", book);
			book.setAuthor(info.get("author"));
			book.setAuthorIntro(info.get("authorIntro"));
			book.setBookIntro(info.get("bookIntro"));
			book.setName(name);
			book.setTag(info.get("tag"));
			book.setCode(info.get("code"));
		}
		else {
			Menu menu = new Menu();
			request.setAttribute("menu", menu);
			menu.setIntro(info.get("intro"));
			menu.setName(name);
			menu.setTag(info.get("tag"));
			menu.setCode(info.get("code"));
			menu.setPrice(info.get("price"));
		}
		request.getRequestDispatcher("/productInfo.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

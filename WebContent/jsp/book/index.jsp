<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="db.DBExecute"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/isLogin.jsp" %>
<%@ include file="/_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>书籍首页</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="product" class="bean.ProductView"></jsp:useBean>
	<%
	int col = product.getCol();
	String tag = request.getParameter("tag");
	ArrayList<LinkedHashMap<String, String>> infos = new ArrayList<LinkedHashMap<String, String>>();
	if(tag != null){
		infos = DBExecute.extractInfo("tag", tag, "book");
	}
	int cnt = 0;
	Iterator<LinkedHashMap<String, String>> iter = infos.iterator();
	ArrayList<LinkedHashMap<String, String>> bookTypes = DBExecute.extractInfo("", "", "bookType");
	Iterator<LinkedHashMap<String, String>> bookIter = bookTypes.iterator();
	%>
	<div class="content">
	<div class="mid_content" style="background-image: url(/bookBar/img/book.jpg);background-size: 100% 100%"><h1 class="mid_title"><%= bookBarName %>集书地<span style="font-size: 20px;margin-left: 10px;">书单</span></h1></div>
		<div class="left_navbar">
	        <div class="type last">
	            <h1>书籍</h1>
	            <%
	            while(bookIter.hasNext()){
	            		LinkedHashMap<String, String> bookType = bookIter.next();
	            	%>
		            	<ul class="navBar_info">
		                <li>
		                    <a href="jsp/book/index.jsp?type=book&tag=<%= bookType.get("type") %>"><%= bookType.get("type") %></a>
		                </li>
		            </ul>
	            	<%
	            }
	            %>
	        </div>
		</div>
		<div id="menu_main">
			<%
			while(iter.hasNext()){
				LinkedHashMap<String, String> info = iter.next();
				String realPath = "/upload/" + info.get("code") + ".jpg";
				File file = new File(uploadPath + File.separator + info.get("code") + ".jpg");
				if(!file.exists() || file.length() == 0){
					realPath = "/upload/noImg.jpg";
				}
				if(cnt % col == 0){
				%>
				<ul class="product_view">
				<%
				}
				%>
					<li class="product">
						<div class="product_img">
		                		<a href="/bookBar/servlet/ProductInfo?type=book&name=<%= info.get("name") %>"><img src="<%= realPath %>" alt="暂无书籍图片" style="border-radius: 0%;"></a>
		                </div>
		                <div class="product_info">
		                    <p><span class="product_name"><%= info.get("name") %></span></p>
		                    <p><span class="product_author"><%= info.get("author") %> 著</span></p>
		                    <p><span class="price"><%= info.get("price") %>元</span></p>
		                </div>
		            </li>
				<%
				if(cnt % col == col - 1 || !iter.hasNext()){
				%>
				</ul>
				<%
				}
			}
			%>
	    </div>    
	</div>
</body>
</html>
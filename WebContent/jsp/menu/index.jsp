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
<title>菜单首页</title>
</head>
<body>
	<jsp:useBean id="product" class="bean.ProductView"></jsp:useBean>
	<%
	int col = product.getCol();
	String type = request.getParameter("type");
	String tag = request.getParameter("tag");
	ArrayList<LinkedHashMap<String, String>> infos = new ArrayList<LinkedHashMap<String, String>>();
	if(tag != null && type != null){
		infos = DBExecute.extractInfo("tag", tag, type);
	}
	int cnt = 0;
	Iterator<LinkedHashMap<String, String>> iter = infos.iterator();
	ArrayList<LinkedHashMap<String, String>> foodTypes = DBExecute.extractInfo("", "", "foodType");
	Iterator<LinkedHashMap<String, String>> foodIter = foodTypes.iterator();
	ArrayList<LinkedHashMap<String, String>> drinkTypes = DBExecute.extractInfo("", "", "drinkType");
	Iterator<LinkedHashMap<String, String>> drinkIter = drinkTypes.iterator();
	%>
	<div class="content">
	<div class="mid_content" style="background-image: url(/bookBar/img/menu.jpg);background-size: 100% 100%"><h1 class="mid_title">小食/饮品<span style="font-size: 20px;margin-left: 10px;">菜单</span></h1></div>
		<div class="left_navbar">
	        <div class="type">
	            <h1>小食</h1>
	            <%
	            while(foodIter.hasNext()){
	            		LinkedHashMap<String, String> foodType = foodIter.next();
	            	%>
		            	<ul class="navBar_info">
		                <li>
		                    <a href="jsp/menu/index.jsp?type=food&tag=<%= foodType.get("type") %>"><%= foodType.get("type") %></a>
		                </li>
		            </ul>
	            	<%
	            }
	            %>
	        </div>
	        <div class="type last">
	            <h1>饮品</h1>
	            <%
	            while(drinkIter.hasNext()){
	            		LinkedHashMap<String, String> drinkType = drinkIter.next();
	            	%>
		            	<ul class="navBar_info">
		                <li>
		                    <a href="jsp/menu/index.jsp?type=drink&tag=<%= drinkType.get("type") %>"><%= drinkType.get("type") %></a>
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
		                		<a href="/bookBar/servlet/ProductInfo?type=<%= type %>&name=<%= info.get("name") %>"><img src="<%= realPath %>" alt="暂无图片"></a>
		                </div>
		                <div class="product_info">
		                    <p><span class="product_name"><%= info.get("name") %></span></p>
		                    <p><span class="price"><%= info.get("price") %>元</span></p>
		                    <p><span class="product_intro"><%= info.get("intro") %></span></p>
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
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" +request.getServerPort() + path + "/";
String uploadPath = getServletContext().getRealPath("./") + "upload";
Properties properties = new Properties();
try {
	properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("bookBar_conf.properties"));
}
catch(FileNotFoundException e) {
	e.printStackTrace();
}
catch(IOException e) {
	e.printStackTrace();
}
String bookBarName = properties.getProperty("bookBarName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href=<%= basePath %>>
<link rel="stylesheet" href="/bookBar/css/style.css" type="text/css">
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="login" class="bean.Login" scope="session" />
	<div id="head">
		<div id="navbar">
			<div id="bookBar_name">
				<a href="index.jsp"><%= bookBarName %><span>书吧</span></a>
			</div>
			<div id="navigator">
				<ul id="navbar_main"> 
					<li><a href="index.jsp">首页</a></li>
					<li><a href="jsp/book/index.jsp">书单</a></li>   
					<li><a href="jsp/menu/index.jsp">点餐</a></li>  
					<li><a href="jsp/info/profile.jsp">个人主页</a></li>
				</ul>
			</div>	   
			<div class="icon">
	            <%
				if(login.getStatus().equals("false")){
				%>
					<a href="jsp/join/login.jsp" name="login">登录 <span>or</span></a>
					<a href="jsp/join/register.jsp" name="register">注册</a>
				<%
				}
				else{
				%>
					<form action="/bookBar/servlet/HandleLogout" method="post">
						<input type="submit" name="logout" value="退出当前账号">
					</form>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>
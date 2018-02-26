<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Properties"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆界面</title>
<link rel="stylesheet" href="/bookBar/css/style.css" type="text/css">
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="login" class="bean.Login" scope="request" />
	<%
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
	String comeFrom = request.getParameter("where");
	if(comeFrom != null){
		if(comeFrom.equals("register")){
			login.setBackNews("请先前往邮箱进行验证");		
		}
		else if(comeFrom.equals("reset")) {
			login.setBackNews("密码将在验证完邮箱后更改");
		}
		else if(comeFrom.equals("other")){
			login.setBackNews("请先登录");
		}
	}
	
	Cookie[] cookies = request.getCookies();
	String username = "";
	String password = "";
	if(cookies != null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("username")){
				username = URLDecoder.decode(cookie.getValue(), "UTF-8");
			}
			if(cookie.getName().equals("password")){
				password = URLDecoder.decode(cookie.getValue(), "UTF-8");
			}
		}
	}
	%>
	<h1 style="text-align: center;">登录<%= bookBarName %>书吧</h1>
	<div id="login_page" style="background-color: #f2f2f2; padding-left: 200px; padding-right: 200px; padding-bottom: 100px; padding-top: 50px;">
		<div class="bookBar_symbol"><a href="/bookBar/index.jsp"><img src="/bookBar/img/bookBar.jpg" alt="书吧图标" style="border-radius: 50%; width: 100px; height: 100px;"></a></div>
        	<div id="login_title"><h1>书吧会员登录</h1></div>
        	<div id="login_main">
            	<form action="/bookBar/servlet/HandleLogin" method="post">
				<div id="login">
					<label for="login_username">账号（邮箱）</label><br/>
					<input id="login_username" name="username" type="text" value="<%= username %>" /><br/>
					<label for="login_password">
						密码
					    <a href="/bookBar/jsp/join/passwordReset.jsp" class="label_link">忘记密码?</a>
					</label><br/>
					<input id="login_password" name="password" type="password" value="<%= password %>" /><br/>
					<input id="login_button" name="commit" type="submit" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录" />
					<span class="note"><jsp:getProperty property="backNews" name="login" /></span>
                	</div>
            	</form>
        </div>
		<div id="first_come">
            <span>第一次来书吧?
                <a href="/bookBar/jsp/join/register.jsp" class="label_link">注册</a>
            </span>
        </div>
	</div>
</body>
</html>
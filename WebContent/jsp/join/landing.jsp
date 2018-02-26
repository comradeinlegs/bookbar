<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3;url=/bookBar/jsp/join/login.jsp"> 
<title>跳转界面</title>
<style type="text/css">
	.landing_page{
	    text-align: center;
	    width: 600px;
	    margin: 300px auto;
	    height: 100px;
		font-size: 40px;
	}
</style>
</head>
<body>
	<%
	String where = request.getParameter("where");
	String who = "";
	if(where.equals("reset")){
		who = "重置密码";
	}
	else if(where.equals("active")){
		who = "注册";
	}
	%>
	<div class="landing_page">
        <div class="landing_view">
            <b><%= who %>成功</b><br/><br/>
            三秒后<a href="/bookBar/jsp/join/login.jsp">跳转</a>至登录界面。。。
        </div>
    </div>
</body>
</html>
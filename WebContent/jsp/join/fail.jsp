<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发生错误</title>
<style type="text/css">
	a:link, a:visited{
    		text-decoration:none;
	}
	#fail{
		height: 100px;
		margin: 300px auto;
		font-size: 40px;
	}
	#fail a{
		color: red;
	}
</style>
</head>
<body>
	<%
	if(request.getParameter("where").equals("active")){
	%>
	<div id="fail" align="center"><span>验证发生错误，请重新<a href="/bookBar/jsp/join/activeUser.jsp">验证邮箱</a></span></div>
	<%
	}
	else if(request.getParameter("where").equals("reset")){
	%>
	<div id="fail" align="center"><span>重置发生错误，请重新<a href="/bookBar/jsp/join/passwordReset.jsp">重置密码</a></span></div>
	<%
	}
	%>
	
</body>
</html>
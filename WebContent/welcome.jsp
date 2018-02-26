<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎页面</title>
<style type="text/css">
	body {
		text-align: center;
	}
	h1 {
		margin: 300px auto;
	}
</style>
</head>
<body>
	<h1>欢迎您， 亲爱的<%= login.getName() %></h1>
</body>
</html>
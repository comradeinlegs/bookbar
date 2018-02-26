<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品具体信息</title>
<link rel="stylesheet" href="/bookBar/css/style.css" type="text/css">
<style>
    #info, #img{
        width: 500px;
        height: 500px;
        float: left;
        padding: 50px;
        
    }
    #img img{
        width: 80%;
        height: 80%;
    }
</style>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	String type = request.getParameter("type");
	if(type != null && type.equals("book")){
	%>
		<jsp:useBean id="book" class="bean.Book" scope="request"></jsp:useBean>
		<div class="content">
	        <div id="info">
	            <small style="color: #b89f7a" class="tag"><jsp:getProperty property="tag" name="book"/></small>
	            <h1 class="name"><jsp:getProperty property="name" name="book"/>&nbsp;&nbsp;<small style="font-size: 25px"><jsp:getProperty property="author" name="book"/></small></h1><br/>
	            <p class="book_intro" style="font-size: 25px">书籍介绍：<jsp:getProperty property="bookIntro" name="book"/></p><br/>
	            <p class="author_intro" style="font-size: 25px">作者介绍：<jsp:getProperty property="authorIntro" name="book"/></p>
	        </div>
    <%
    String realPath = "/upload/" + book.getCode() + ".jpg";
    File file = new File(uploadPath + File.separator + book.getCode() + ".jpg");
	if(!file.exists() || file.length() == 0){
		realPath = "/upload/noImg.jpg";
	}
    %>
	        <div id="img"><img src="<%= realPath %>" ></div>
	    </div>
	<%
	}
	else{
	%>
		<jsp:useBean id="menu" class="bean.Menu" scope="request"></jsp:useBean>
		<div class="content">
	        <div id="info">
	            <small style="color: #b89f7a" class="tag"><jsp:getProperty property="tag" name="menu"/></small>
	            <h1 class="name"><jsp:getProperty property="name" name="menu"/>&nbsp;&nbsp;<small style="font-size: 25px"><jsp:getProperty property="price" name="menu"/>元</small></h1><br/>
	            <p class="menu_intro" style="font-size: 25px">介绍：<jsp:getProperty property="intro" name="menu"/></p><br/>
	        </div>
    <%
    String realPath = "/upload/" + menu.getCode() + ".jpg";
    File file = new File(uploadPath + File.separator + menu.getCode() + ".jpg");
	if(!file.exists() || file.length() == 0){
		realPath = "/upload/noImg.jpg";
	}
    %>
	        <div id="img"><img src="<%= realPath %>" ></div>
	    </div>
	<%
	}
	%>
</body>
</html>
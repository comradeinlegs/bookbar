<%@page import="java.util.ArrayList"%>
<%@page import="db.DBExecute"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/isLogin.jsp" %>
<%@ include file="/_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息</title>
</head>
<body>
	<%
	String backNews = "";
	if(request.getParameter("update") != null){
		if(request.getParameter("update").equals("true")){
			backNews = "修改成功";
		}
		else{
			backNews = "修改失败，请重新修改";
		}
	}
	%>
	<div class="content">
	    <div id="profile_page" style="background-color: #f2f2f2; padding-left: 200px; padding-right: 200px; padding-bottom: 100px; padding-top: 50px; margin: 0px auto;">
	        <h1>基本信息</h1>
	        <div id="profile_main">
	            <form action="/bookBar/servlet/UpdateProfile" method="post" id="profile">
	                <dl class="information">
	                    <dt><label for="profile_name">昵称</label></dt>
	                    <dd><input id="profile_name" class="info_field" name="name" size="50" type="text" value="<%= login.getName() %>" placeholder="输入昵称" /></dd>
	                </dl>
	                <dl class="information">
	                    <dt><label for="profile_password">密码<a href="/bookBar/jsp/join/passwordReset.jsp" class="label_link">&nbsp;&nbsp;&nbsp;更改密码</a></label></dt>
	                    <dd><input id="profile_password" class="info_field" name="password" size="50" type="text" value="*********" disabled="disabled" /></dd>
	                </dl>
	                <dl class="information">
	                    <dt><label for="profile_level">会员等级</label></dt>
	                    <dd><input id="profile_level" class="info_field" name="level" size="50" type="text" value="<%= login.getLevel() %>" disabled="disabled" /></dd>
	                </dl>
	                <button id="update_profile_button" type="submit">更&nbsp;&nbsp;&nbsp;新</button><br/><br/>
	            </form>
	            <font color="red"><%= backNews %></font>
	        </div>
	    </div>
	</div>
</body>
</html>
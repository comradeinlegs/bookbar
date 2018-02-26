<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册界面</title>
<link rel="stylesheet" href="/bookBar/css/style.css" type="text/css">
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="register" class="bean.Register" scope="request"></jsp:useBean>
	<h1 style="text-align: center; margin-top: 50px;">加入<%= bookBarName %>书吧</h1>
	<div id="register_page" style="background-color: #f2f2f2; padding-left: 200px; padding-right: 200px; padding-bottom: 100px; padding-top: 50px;">
        <div class="introduce">
            <h1>成为我们书吧的一员吧</h1>
            <span >(简要介绍)</span>
        </div>
        <h2>填写一些基本信息</h2>
        <div id="register_main">
            <form action="/bookBar/servlet/HandleRegister" method="post" id="register">
                <dl class="information">
                    <dt>
                        <label for="user_name">邮箱</label>
                    </dt>
                    <dd>
                        <input id="register_username" class="info_field" name="username" size="30" type="text" value="<%= register.getUsername() %>" />
                    </dd>
                    <dd>
                    		<span class="note"><jsp:getProperty property="usernameBack" name="register"/></span>
                    </dd>
                </dl>
                <dl class="information">
                    <dt>
                        <label for="register_password">密码</label>
                    </dt>
                    <dd>
                        <input id="register_password" class="info_field" name="password" size="30" type="password" value="<%= register.getPassword() %>" />
                    </dd>
                    <dd>
                    		<span class="note"><jsp:getProperty property="passwordBack" name="register"/></span>
                    </dd>
                </dl>
                <button id="register_button" type="submit">提交</button><br/><br/>
            </form>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>
<link rel="stylesheet" href="/bookBar/css/style.css" type="text/css">
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="repass" class="bean.ResetPassword" scope="request"></jsp:useBean>
	<div id="reset_page" style="background-color: #f2f2f2; padding-left: 200px; padding-right: 200px; padding-bottom: 100px; padding-top: 50px; margin: 0px auto;">
        <h1>密码重置</h1>
        <div id="reset_main" >
            <form action="/bookBar/servlet/HandlePasswordReset" method="post" id="reset">
            		<dl class="information">
                    <dt>
                        <label for="reset_username">账号（邮箱）</label>
                    </dt>
                    <dd>
                        <input id="reset_username" class="info_field" name="username" size="30" type="text" value="your email"/>
                    </dd>
                    <dd>
                    		<span class="note"><jsp:getProperty property="usernameBack" name="repass" /></span>
                    </dd>
                </dl>
                <dl class="information">
                    <dt>
                        <label for="reset_password">新密码</label>
                    </dt>
                    <dd>
                        <input id="reset_password" class="info_field" name="password" size="30" type="password" />
                    </dd>
                    <dd>
                    		<span class="note"><jsp:getProperty property="passwordBack" name="repass" /></span>
                    </dd>
                </dl>
                <button id="reset_button" type="submit">重置</button><br/><br/>
            </form>
        </div>
    </div>
</body>
</html>
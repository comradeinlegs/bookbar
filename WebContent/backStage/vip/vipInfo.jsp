<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.DBExecute"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/bookBar/backStage/js/jquery.js"></script>
<script type="text/javascript" src="/bookBar/backStage/js/page_common.js"></script>
<link href="/bookBar/backStage/css/common_style_blue.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/bookBar/backStage/css/index_1.css" />
<title>会员信息</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	String username = request.getParameter("username");
	LinkedHashMap<String, String> info = DBExecute.extractInfo("username", username, "vip").get(0);
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 更新饮品新品
			</div>
	    </div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
		<form action="/bookBar/backStage/AddConsume?username=<%= username %>&preConsume=<%= info.get("totalConsume") %>&nextPath=/bookBar/backStage/vip/vipList.jsp&nowPath=/bookBar/backStage/vip/vipInfo.jsp" method="post">
			<div class="ItemBlock_Title">
        			<img width="4" height="7" border="0" src="/bookBar/backStage/img/item_point.gif">饮品信息
        		</div>
        		<div class="ItemBlockBorder">
            		<div class="ItemBlock">
					<div class="ItemBlock2">
						<table cellpadding="0" cellspacing="0" class="mainForm">
							<tr>
								<td>邮箱</td>
								<td><input type="text" name="username" class="InputStyle" value="<%= info.get("username") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>等级</td>
								<td><input type="text" name="level" class="InputStyle" value="<%= info.get("level") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>总共消费</td>
								<td><input type="text" name="totalConsume" class="InputStyle" value="<%= info.get("totalConsume") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>此次消费</td>
								<td><input type="text" name="thisConsume" class="InputStyle" placeholder="请输入此次消费金额"/></td>
							</tr>
						</table>
					</div>
	            </div>
	        </div>
			<div id="InputDetailBar">
				<input type="submit" value="更新" class="FunctionButtonInput">
	            	<a href="javascript:history.go(-1);" class="FunctionButton">返回</a>
	        </div>
		</form>
		<%
		String update = request.getParameter("update");
		if(update != null && update.equals("false")) {
		%>
		<FONT color=red>请重新更改</FONT>
		<%
		}
		String fail = request.getParameter("fail");
		if(fail != null && fail.equals("true")){
		%>
		<FONT color=red>请注意输入的金额格式</FONT>
		<%
		}
		%>
	</div>
</body>
</html>
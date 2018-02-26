<%@page import="java.io.File"%>
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
<title>更新会员等级</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	String name = request.getParameter("name");
	LinkedHashMap<String, String> info = DBExecute.extractInfo("name", name, "vipLevel").get(0);
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 更新会员等级信息
			</div>
	    </div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
		<form action="/bookBar/servlet/UpdateFile?type=vipLevel&name=<%= info.get("name") %>&nextPath=/bookBar/backStage/vip/vipLevel.jsp" method="post" enctype="multipart/form-data">
			<div class="ItemBlock_Title">
        			<img width="4" height="7" border="0" src="/bookBar/backStage/img/item_point.gif">会员等级信息
        		</div>
        		<div class="ItemBlockBorder">
            		<div class="ItemBlock">
					<div class="ItemBlock2">
						<table cellpadding="0" cellspacing="0" class="mainForm">
							<tr>
								<td width="80px">名字</td>
								<td><input type="text" name="name" class="InputStyle" value="<%= info.get("name") %>" disabled="true"/></td>
							</tr>
							<tr>
								<td>最低消费</td>
								<td><input type="text" name="leastConsume" class="InputStyle" value="<%= info.get("leastConsume") %>"/></td>
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
		%>
	</div>
</body>
</html>
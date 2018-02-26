<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="db.DBExecute"%>
<%@page import="java.util.ArrayList"%>
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
<title>小食种类</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	int cnt = 1;
	ArrayList<LinkedHashMap<String, String>> infos = DBExecute.extractInfo("", "", "foodType");
	Iterator<LinkedHashMap<String, String>> iter = infos.iterator();
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 小食种类
			</div>
    		</div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
    <table class="MainArea_Content" align="center" cellspacing="0" cellpadding="0">
        <!-- 表头-->
        <thead>
            <tr align="center" valign="middle" id="TableTitle">
				<td>编号</td>
				<td>种类</td>
				<td>总数</td>
				<td>简介</td>
			</tr>
		</thead>	
		<tbody id="TableData">
			<%
			while(iter.hasNext()){
				LinkedHashMap<String, String> info = iter.next();
				int sum = DBExecute.totalNum("tag", info.get("type"), "food");
			%>
			<tr class="TableDetail1">
				<td><%= cnt++ %></td>
				<td><a href="/bookBar/backStage/menu/foodList.jsp?tag=<%= info.get("type") %>"><%= info.get("type") %></a></td>
				<td><%= sum %></td>
				<td><%= info.get("intro") %></td>
				<td>		
					<a href="/bookBar/backStage/DeleteFoodType?type=<%= info.get("type") %>" onClick="return delConfirm();"class="FunctionButton">删除</a>				
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
    </table>
    <div id="TableTail" align="center">
		<div class="FunctionButton"><a href="addFoodType.jsp">添加</a></div>
    </div> 
</div>
</body>
</html>
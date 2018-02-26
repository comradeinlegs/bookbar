<%@page import="tool.Search"%>
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
<title>各种饮品总览</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	int cnt = 1;
	ArrayList<LinkedHashMap<String, String>> infos = DBExecute.extractInfo("tag", request.getParameter("tag"), "drink");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	//将与搜索不匹配的从infos中删除
	if(search != null && keyword != null && !keyword.equals("") && search.equals("true")){
		for(int i = 0; i < infos.size(); ){
			if(!Search.isMatch(keyword, infos.get(i).get("name"))){
				infos.remove(i);
			}
			else{
				i++;
			}
		}
	}
	else{
		keyword = "";
	}
	Iterator<LinkedHashMap<String, String>> iter = infos.iterator();
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> <%= request.getParameter("tag") %>
			</div>
    		</div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="QueryArea">
		<form action="drinkList.jsp?search=true&tag=<%= request.getParameter("tag") %>" method="post">
			<input type="text" name="keyword" title="请输入饮品名称" value="<%= keyword %>">
			<input type="submit" value="搜索">
		</form>
	</div>
	<div id="MainArea">
	    <table class="MainArea_Content" align="center" cellspacing="0" cellpadding="0">
	        <thead>
	            <tr align="center" valign="middle" id="TableTitle">
					<td>编号</td>
					<td>种类</td>
					<td>名称</td>
					<td>价格</td>
					<td>简介</td>
				</tr>
			</thead>	
			<tbody id="TableData">
				<%
				while(iter.hasNext()){
					LinkedHashMap<String, String> info = iter.next();
				%>
				<tr class="TableDetail1">
					<td><%= cnt++ %></td>
					<td><%= info.get("tag") %></td>
					<td><%= info.get("name") %></td>
					<td><%= info.get("price") %></td>
	                	<td><%= info.get("intro") %></td>
					<td>
						<a href="updateDrink.jsp?name=<%= info.get("name") %>"  class="FunctionButton">更新/查看信息</a>				
						<a href="/bookBar/backStage/DeleteDrink?name=<%= info.get("name") %>&tag=<%= info.get("tag") %>" onClick="return delConfirm();"class="FunctionButton">删除</a>				
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
	    </table>
    		<div id="TableTail" align="center">
			<div class="FunctionButton"><a href="addDrink.jsp?tag=<%= request.getParameter("tag") %>">添加</a></div>
		</div>
	</div> 
</body>
</html>
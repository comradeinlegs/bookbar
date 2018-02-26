<%@page import="tool.Search"%>
<%@page import="java.util.Iterator"%>
<%@page import="db.DBExecute"%>
<%@page import="java.util.LinkedHashMap"%>
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
<title>会员列表</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	int cnt = 1;
	ArrayList<LinkedHashMap<String, String>> infos = DBExecute.extractInfo("", "", "vip");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	//将与搜索不匹配的从infos中删除
	if(search != null && keyword != null && !keyword.equals("") && search.equals("true")){
		for(int i = 0; i < infos.size(); ){
			if(!Search.isMatch(keyword, infos.get(i).get("username"))){
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
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 会员列表
			</div>
    		</div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="QueryArea">
		<form action="vipList.jsp?search=true&username=<%= request.getParameter("username") %>" method="post">
			<input type="text" name="keyword" title="请输入会员邮箱" value="<%= keyword %>">
			<input type="submit" value="搜索">
		</form>
	</div>
	<div id="MainArea">
    <table class="MainArea_Content" align="center" cellspacing="0" cellpadding="0">
        <!-- 表头-->
        <thead>
            <tr align="center" valign="middle" id="TableTitle">
            		<td>编号</td>
				<td>会员邮箱</td>
				<td>会员等级</td>
				<td>总消费额度</td>
			</tr>
		</thead>	
		<tbody id="TableData">
			<%
			while(iter.hasNext()){
				LinkedHashMap<String, String> info = iter.next();
			%>
			<tr class="TableDetail1">
				<td><%= cnt++ %></td>
				<td><%= info.get("username") %></td>
				<td><%= info.get("level") %></td>
				<td><%= info.get("totalConsume") %></td>
				<td>
					<a href="vipInfo.jsp?username=<%= info.get("username") %>"  class="FunctionButton">查看会员信息/添加消费金额</a>						
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
    </table>
</body>
</html>
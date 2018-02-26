<%@page import="java.util.Comparator"%>
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
<title>会员等级设置</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	int cnt = 1;
	ArrayList<LinkedHashMap<String, String>> levels = DBExecute.extractInfo("", "", "vipLevel");
	Comparator<LinkedHashMap<String, String>> comparator = new Comparator<LinkedHashMap<String, String>>() {

		@Override
		public int compare(LinkedHashMap<String, String> arg0, LinkedHashMap<String, String> arg1) {
			if(Integer.parseInt(arg0.get("leastConsume")) < Integer.parseInt(arg1.get("leastConsume"))) {
				return 1;
			}
			return -1;
		}
		
	};
	levels.sort(comparator);
	Iterator<LinkedHashMap<String, String>> iter = levels.iterator();
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 会员等级设置
			</div>
    		</div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
	    <table class="MainArea_Content" align="center" cellspacing="0" cellpadding="0">
	        <thead>
	            <tr align="center" valign="middle" id="TableTitle">
					<td>编号</td>
					<td>等级名称</td>
					<td>最低消费</td>
				</tr>
			</thead>	
			<tbody id="TableData">
				<%
				while(iter.hasNext()){
					LinkedHashMap<String, String> level = iter.next();
				%>
				<tr class="TableDetail1">
					<td><%= cnt++ %></td>
					<td><%= level.get("name") %></td>
					<td><%= level.get("leastConsume") %></td>
					<td>
						<a href="updateLevel.jsp?name=<%= level.get("name") %>"  class="FunctionButton">更新/查看信息</a>
						<a href="/bookBar/backStage/DeleteLevel?name=<%= level.get("name") %>" onClick="return delConfirm();"class="FunctionButton">删除</a>				
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
	    </table>
	    <div id="TableTail" align="center">
			<div class="FunctionButton"><a href="addLevel.jsp?tag=<%= request.getParameter("tag") %>">添加</a></div>
	    </div> 
	</div>
</body>
</html>
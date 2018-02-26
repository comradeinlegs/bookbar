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
<title>今日书籍推荐</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	String name = request.getParameter("name");
	LinkedHashMap<String, String> info = DBExecute.extractInfo("name", name, "book").get(0);
	String uploadPath = getServletContext().getRealPath("./") + "upload";
	String realPath = "/upload/" + info.get("code") + ".jpg";
	File file = new File(uploadPath + File.separator + info.get("code") + ".jpg");
	if(!file.exists() || file.length() == 0){
		realPath = "/upload/noImg.jpg";
	}
	%>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 推荐书籍
			</div>
	    </div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
		<form action="/bookBar/backStage/TodayRecommend?type=<%= info.get("tag") %>&name=<%= info.get("name") %>&nextPath=/bookBar/backStage/recommend.jsp" method="post">
			<div class="ItemBlock_Title">
        			<img width="4" height="7" border="0" src="/bookBar/backStage/img/item_point.gif">书籍推荐信息
        		</div>
        		<div class="ItemBlockBorder">
            		<div class="ItemBlock">
					<div class="ItemBlock2">
						<table cellpadding="0" cellspacing="0" class="mainForm">
                    			<tr>
								<td width="80px">分类</td>
								<td>
                            			<select name="tag" style="width:80px" id="tag" disabled="disabled">
			   							<option value="<%= info.get("tag") %>" selected="selected"><%= info.get("tag") %></option>
			   						</select>
                             	</td>
							</tr>
							<tr>
								<td width="80px">名称</td>
								<td><input type="text" name="name" class="InputStyle" value="<%= info.get("name") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>价格</td>
								<td><input type="text" name="price" class="InputStyle" value="<%= info.get("price") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>作者</td>
								<td><input type="text" name="author" class="InputStyle" value="<%= info.get("author") %>" disabled="disabled"/></td>
							</tr>
							<tr>
								<td>作者简介</td>
								<td><textarea name="authorIntro" class="TextareaStyle" disabled="disabled"><%= info.get("authorIntro") %></textarea></td>
							</tr>
							<tr>
								<td>作品简介</td>
								<td><textarea name="bookIntro" class="TextareaStyle" disabled="disabled"><%= info.get("bookIntro") %></textarea></td>
							</tr>
							<tr>
								<td width="80px"><a href="<%= realPath %>">查看书籍图片</a></td>
							</tr>
							<tr>
								<td>推荐理由</td>
								<td><textarea name="reason" class="TextareaStyle"></textarea></td>
							</tr>
						</table>
					</div>
	            </div>
	        </div>
			<div id="InputDetailBar">
				<input type="submit" value="推荐" class="FunctionButtonInput">
	            	<a href="javascript:history.go(-1);" class="FunctionButton">返回</a>
	        </div>
		</form>
</body>
</html>
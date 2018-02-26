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
<title>更新饮品信息</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%
	String name = request.getParameter("name");
	LinkedHashMap<String, String> info = DBExecute.extractInfo("name", name, "drink").get(0);
	ArrayList<LinkedHashMap<String, String>> types = DBExecute.extractInfo("", "", "drinkType");
	Iterator<LinkedHashMap<String, String>> iter = types.iterator();
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
		<form action="/bookBar/servlet/UpdateFile?type=drink&nowPath=/bookBar/backStage/menu/updateDrink.jsp&nextPath=/bookBar/backStage/menu/drinkList.jsp&name=<%= info.get("name") %>&nextPath=/bookBar/backStage/menu/drinkList.jsp" method="post" enctype="multipart/form-data">
			<div class="ItemBlock_Title">
        			<img width="4" height="7" border="0" src="/bookBar/backStage/img/item_point.gif">饮品信息
        		</div>
        		<div class="ItemBlockBorder">
            		<div class="ItemBlock">
					<div class="ItemBlock2">
						<table cellpadding="0" cellspacing="0" class="mainForm">
                    			<tr>
								<td width="80px">分类</td>
								<td>
                            			<select name="tag" style="width:80px" id="tag">
			   							<%
			   							while(iter.hasNext()){
			   								LinkedHashMap<String, String> type = iter.next();
			   								if(type.get("type").equals(info.get("tag"))){
			   							%>
			   								<option value="<%= type.get("type") %>" selected="selected"><%= type.get("type") %></option>
			   							<%		
			   								}
			   								else{
			   							%>
			   								<option value="<%= type.get("type") %>"><%= type.get("type") %></option>
			   							<%
			   								}
			   							}
			   							%>
			   						</select>
                             	</td>
							</tr>
							<tr>
								<td width="80px">名字</td>
								<td><input type="text" name="name" class="InputStyle" value="<%= info.get("name") %>" disabled="true"/></td>
							</tr>
							<tr>
								<td>价格</td>
								<td><input type="text" name="price" class="InputStyle" value="<%= info.get("price") %>"/></td>
							</tr>
							<tr>
								<td>简介</td>
								<td><textarea name="intro" class="TextareaStyle"><%= info.get("intro") %></textarea></td>
							</tr>
							<tr>
								<%
								String uploadPath = getServletContext().getRealPath("./") + "upload";
								String realPath = "/upload/" + info.get("code") + ".jpg";
								File file = new File(uploadPath + File.separator + info.get("code") + ".jpg");
								if(!file.exists() || file.length() == 0){
									realPath = "/upload/noImg.jpg";
								}
								%>
								<td width="80px"><a href="<%= realPath %>">饮品图片</a></td>
								<td><input type="file" name="img"/></td>
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
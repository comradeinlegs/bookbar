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
<title>添加饮品新品</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13" src="/bookBar/backStage/img/title_arrow.gif"/> 添加饮品新品
			</div>
	    </div>
		<div id="TitleArea_End"></div>
	</div>
	<div id="MainArea">
		<form action="/bookBar/servlet/UploadFile?type=drink&nowPath=/bookBar/backStage/menu/addDrink.jsp&nextPath=/bookBar/backStage/menu/drinkList.jsp&tag=<%= request.getParameter("tag") %>" method="post" enctype="multipart/form-data">
			<div class="ItemBlock_Title">
        			<img width="4" height="7" border="0" src="/bookBar/backStage/img/item_point.gif">饮品信息
        		</div>
        		<div class="ItemBlockBorder">
            		<div class="ItemBlock">
					<div class="ItemBlock2">
						<table cellpadding="0" cellspacing="0" class="mainForm">
                    			<tr>
								<td width="80px">分类</td>
								<td><input type="text" name="tag" class="InputStyle" value="<%= request.getParameter("tag") %>" disabled="true"/></td>
							</tr>
							<tr>
								<td width="80px">名字</td>
								<td><input type="text" name="name" class="InputStyle"/></td>
							</tr>
							<tr>
								<td>价格</td>
								<td><input type="text" name="price" class="InputStyle"/></td>
							</tr>
							<tr>
								<td>简介</td>
								<td><textarea name="intro" class="TextareaStyle"></textarea></td>
							</tr>
							<tr>
								<td width="80px">饮品图片</td>
								<td><input type="file" name="img"/></td>
							</tr> 
						</table>
					</div>
	            </div>
	        </div>
			<div id="InputDetailBar">
				<input type="submit" value="添加" class="FunctionButtonInput">
	            	<a href="javascript:history.go(-1);" class="FunctionButton">返回</a>
	        </div>
		</form>
		<%
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
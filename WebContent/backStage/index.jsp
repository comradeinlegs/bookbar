<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
</head>
	<frameset rows="100px,*,19px" framespacing="0" border="0" frameborder="0">
		<frame src="/bookBar/backStage/top.jsp" scrolling="no" noresize /> 
		<frameset cols="178px,*">
			<frame noresize src="/bookBar/backStage/left.jsp" scrolling="yes" /> 
			<frame noresize name="right" src="/bookBar/backStage/right.jsp" scrolling="yes" /> 
		</frameset>
	</frameset>
	<noframes>
		<body>
		</body>
	</noframes>
</html>
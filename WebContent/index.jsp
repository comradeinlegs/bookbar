<%@page import="java.util.Iterator"%>
<%@page import="java.io.File"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.DBExecute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="_navBar.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<style type="text/css">
#index_title{
    text-align: center;
    margin-bottom: 30px;
}

#index_main{
    width: 1200px;
    height: 1200px;
}

.main_content{
    margin: auto;
    width: 800px;
}

.index_image, .index_text{
    width: 300px;
    height: 300px;
    float: left;
    margin-top: 100px;
    margin-right: 100px;
}

.index_text span{
	font-size: 30px;
}

.index_image img{
	height: 100%;
	width: 100%;
}
    
#index_img{
    width: 1200px;
    height: 600px;
    margin: auto;
}
</style>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8");response.setContentType("text/html;charset=UTF-8"); %>
	<%
	ArrayList<LinkedHashMap<String, String>> recs = DBExecute.extractInfo("", "", "recommend");
	Iterator<LinkedHashMap<String, String>> iter = recs.iterator();
	%>
	<div class="content">
        <div class="mid_content" style="background-image: url(/bookBar/img/recommend.jpg);background-size: 100% 100%"><h1 class="mid_title">今日推荐书籍</h1></div>
        <div id="index_main">
        		<%
        		int cnt = 0;
        		while(iter.hasNext()){
        			LinkedHashMap<String, String> info = DBExecute.extractInfo("name", iter.next().get("name"), "book").get(0);
        			String realPath = "/upload/" + info.get("code") + ".jpg";
    				File file = new File(uploadPath + File.separator + info.get("code") + ".jpg");
    				if(!file.exists() || file.length() == 0){
    					realPath = "/upload/noImg.jpg";
    				}
    				if(cnt % 2 == 0){
    				%>
	    				<div class="main_content">
		                <div class="index_image">
		                		<a href="/bookBar/servlet/ProductInfo?type=book&name=<%= info.get("name") %>"> <img src="<%= realPath %>" alt="暂无图片"></a>
		                </div>
		                <div class="index_text">
		                		<span>书名:<%= info.get("name") %></span><br/>
		                		<span>作者:<%= info.get("author") %></span><br/>
		                		<span>吧主推荐理由:<br/><%= recs.get(cnt).get("reason") %></span>
		                </div>
	            		</div>
    				<%
    				}
    				else{
    				%>
    					<div class="main_content">
    						<div class="index_text">
		                		<span>书名:<%= info.get("name") %></span><br/>
		                		<span>作者:<%= info.get("author") %></span><br/>
		                		<span>吧主推荐理由:<br/><%= recs.get(cnt).get("reason") %></span>
		                </div>
		                <div class="index_image">
		                		<a href="/bookBar/servlet/ProductInfo?type=book&name=<%= info.get("name") %>"><img src="<%= realPath %>" alt="暂无图片"></a>
		                </div>
		            </div>
    				<%
    				}
    				cnt++;
        		}
        		%>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>today.jsp</title>
<!--今日活动界面 -->
</head>
<body>
<%
	String zhekou = (String)request.getSession().getAttribute("zhekou");
	if(zhekou != null && zhekou.length() > 0){
		%>
		今日活动：<%=zhekou %>
		<%
	}else{
		%>
		今日活动：未设置活动！
		<%
	}	
	%>
</body>
</html>
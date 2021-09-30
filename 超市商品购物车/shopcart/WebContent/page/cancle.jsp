<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>取消活动</title>
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
<form action="${pageContext.request.contextPath}/Discount/cancle.action" method="post">
	<input type="submit" value="取消活动">
</form>
<c:if test="${not empty cancle}">
    	<script type="text/javascript">
    	var loginError=""+'${cancle}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
 </c:if>
</body>
</html>
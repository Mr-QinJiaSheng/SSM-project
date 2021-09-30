<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>rebate</title>
<!--输入折扣信息界面  -->
</head>
<body>
<h1>请输入您的优惠活动</h1>
<form action="<%=request.getContextPath()%>/Discount/rebate.action" method="post">
请输入您想要优惠的折扣(例如0.88)：<input type="text" name="rebate">
<input type="submit" value="确定">
<input type="reset" value="重置">
</form>

<form action="<%=request.getContextPath()%>/Discount/fullreduction.action" method="post">
满：<input type="text" name="man">减：<input type="text" name="jian">
<input type="submit" value="确定">
<input type="reset" value="重置">
</form>
<c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
 </c:if>
</body>
</html>
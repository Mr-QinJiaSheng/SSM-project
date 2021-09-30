<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>cashier</title>
<!-- 结算界面 -->
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color:  #EBEBEB ;
		padding-left: 510px;
		padding-top: 10px
		
	}
	.formdiv{
		position: absolute;
		width: 500px;
		height: 500px;
		background-color:#EBEBEB;
		top:118px;
		left: 400px;
	}
	.buttom{
	position: absolute;
		width: 500px;
		height: 20px;
		background-color:#EBEBEB;
		top:450px;
		left:400px; 
	}
</style>
<body>
<div class="header">
<h2 style="font-size: 40px">商品结算</h2>
</div>
<div class="formdiv">
<form action="<%=request.getContextPath()%>/Cash/lastcash.action" method="post">
<table border="1" cellspacing="1" style="width: 500px;height: 300px">
<tr align="center">
<td colspan="3">商场收银</td>
</tr>
<tr align="center">
	<td>总价</td>
	<td>${totalprice }</td>
</tr>
<tr align="center">
	<td colspan="2">
		<c:if test="${man!=null&&jian!=null&&rebate==null}">
			您好，现在有满${man }减${jian }的活动！
		</c:if>	
		<c:if test="${rebate!=null&&man==null&& jian==null}">
			您好，现在有${rebate}折的折扣活动！
		</c:if>	
		<c:if test="${tell!=null}">
			${tell }
		</c:if>	
	</td>
</tr>

<tr align="center">
	<td>折扣价</td>
	<td>${totalmoney }</td>
</tr>

<!-- <tr align="center">
	<td colspan="3" >
	
	</td>
</tr> -->
<tr align="center">
	<td colspan="3" >
	<a href="<%=request.getContextPath() %>/Cash/accountcash.action" style="text-decoration: none;">结算</a>
	</td>
</tr>
<tr align="center">
	<td>
	<a href="<%=request.getContextPath() %>/showgoods.action" style="text-decoration: none;">继续购物</a>
	</td>
	<td>
	<a href="<%=request.getContextPath() %>/Account/account.action" style="text-decoration: none;">返回购物车</a>
	</td>
</tr>
</table>
</form>
<c:if test="${totalprice==0.0}">
 <tr>
        <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">您还没有购买任何商品，请前去<a href="<%=request.getContextPath() %>/showgoods.action">购物</a></div></td>
      </tr>

</c:if>
 <c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
 </c:if>
 </div>
 <div class="buttom">
<span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span>
</div>
</body>
</html>
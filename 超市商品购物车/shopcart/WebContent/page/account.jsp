<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的购物车界面</title>
<style>
.formdiv{
		position: absolute;
		width: 500px;
		height: 500px;
		background-color:#EBEBEB;
		top:118px;
		left: 400px;
	}
</style>
</head>
<body> 
	<table width="50%" border="5" cellpadding="0" cellspacing="1" align="center">
	<tr align="center">  
	<td colspan="4" height="30px">
		<h1>我的购物车</h1>
	</td>
	</tr>
      <tr>       
        <td width="100" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">商品名称</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">单价</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">数量</span></div></td>   
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">总价</span></div></td>        
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">选择</span></div></td>           
     </tr>
      <c:if test="${not empty listcart}">
	      <c:forEach items="${listcart}" var="a">
	      <tr>
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsprice}</div></td>        
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount}</div></td>	       
	       	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount*a.goodsprice}</div></td>	       	       	      		     
	     	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath()%>/Cart/deleteCart.action?id=${a.id}">删除</a></div></td>	       	       	      		     	     
	      </tr>    
	  </c:forEach>
     
       <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/cashier.action">结算</a></div></td>
      </tr>
       <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/showgoods.action">继续购物</a></div></td>
      </tr>
       </c:if>
       <c:if test="${empty listcart}">
      <tr>
          <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">您还没有购买任何商品，请前去<a href="<%=request.getContextPath() %>/showgoods.action">购物</a></div></td>
      </tr>
      </c:if>
    </table>
 
 <div class="buttom" align="center">
<span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span>
</div>
 

</body>
</html>
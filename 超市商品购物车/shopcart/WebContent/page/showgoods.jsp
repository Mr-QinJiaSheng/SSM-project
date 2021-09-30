<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品展示界面</title>
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color: #EBEBEB;
		padding-left: 510px;
		padding-top: 10px;
		
	}
	.formdiv{
		position: absolute;
		width: 1300px;
		height: 500px;
		background-color:#EBEBEB;
		top:120px;
		 left:30px; 
	}
	.buttom{
	position: absolute;
		width: 1300px;
		height: 20px;
		background-color:#EBEBEB;
		top:420px;
		left:30px; 
	}
</style>
<body> 
<div class="header" >
<h1>商品清单</h1>
</div>

<div class="formdiv">
	<table width="50%" border="5" cellpadding="0" cellspacing="1"align="center">
      <tr>       
        <td width="100" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">商品名称</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">单价</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">数量</span></div></td>        
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">选择</span></div></td>   
    	
     </tr>
      <c:if test="${not empty goodslist}">
	      <c:forEach items="${goodslist}" var="a">	
		      <form action="<%=request.getContextPath()%>/Cart/addgoods.action" method="post">      
			      <tr>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.price}</div></td>   
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">数量：<input type="text" name="num" value="1">	</div></td>             				              
			    	<input type="hidden" name="goodsId" value="${a.id}">             				              	        
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><input type="submit" value="加入购物车"></div></td>	             	
			      </tr>
		      </form> 	    
	  	 </c:forEach>
      </c:if>
       <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/account.action" style="text-decoration: none;">我的购物车</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/cashier.action" style="text-decoration: none;">结算</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span></div></td>
      </tr>
       <c:if test="${empty goodslist}">
      <tr>
          <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">没有商品信息</div></td>
      </tr>
      </c:if>
    </table>
</div> 
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
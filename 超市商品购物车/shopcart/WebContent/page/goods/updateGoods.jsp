<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
 <form action="<%=request.getContextPath() %>/update.action" method="post" >
 <table border="1" width="600px" style="margin: 0 auto;margin-top:25px;" id="table1">
<tr>
<td  colspan="3" align="center">商品修改</td>
</tr>
 <tr style="background:#CCC"> 
<td >商品编号：</td>
<td  colspan="2"><input type="text" name="id" readonly="readonly" value="${goods.id}"></td>
</tr>
 <tr style="background:#CCC">
<td >商品名称：</td>
<td  colspan="2"><input type="text" value="${goods.goodsname}" name="goodsname" id="goodsname"></td>
</tr>

<tr style="background:#CCC">
<td >商品价格：</td>
<td  colspan="2"><input type="text" value="${goods.price}" name="price" ></td>
</tr>
<tr style="background:#CCC">
<td >商品数量：</td>
<td colspan="2"><input type="text" value="${goods.number}" name="number"> </td>
</tr>
<tr>
<td colspan="3"></td>
</tr>

<tr>
<td  colspan="3"><input type="submit"  value="修改"> &nbsp;&nbsp; 
<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="取消">
</tr>
</table>
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
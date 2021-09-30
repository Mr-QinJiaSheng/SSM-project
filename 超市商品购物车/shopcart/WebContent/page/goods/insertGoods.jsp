<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
	String path=request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>

<body>
<form action="<%=request.getContextPath()%>/insert.action" method="post" >
<table border="1" width="600px" style="margin: 0 auto;margin-top:25px;" id="table1">
<tr>
<td align="center" colspan="2">商品添加</td>
</tr>
<tr style="background:#CCC">
<td align="right" width="250px;">商品名称：</td>
<td><input type="text" name="goodsname">*<span id="nameSpan"></span></td>
</tr>
<tr style="background:#CCC">
<td align="right">商品价格：</td>
<td><input type="text" name="price">*</td>
</tr>
<tr style="background:#CCC">
<td align="right">商品数量：</td>
<td><input type="text" name="number" id="number">*<span id="numSpan"></span></td>
</tr>
<tr>   
 <td align="center"  colspan="2"><input type="submit" onclick="add()" value="添加">&nbsp;&nbsp;

<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="返回"/>
 </td>   
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
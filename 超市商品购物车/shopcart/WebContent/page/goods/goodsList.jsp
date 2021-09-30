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
<script type="text/javascript">
function selectAll(field){

	//根据checkbox框的名称，查询得到所有的checkbox对象
	var idCheckboxs = document.getElementsByName("id");
	for(var i=0; i<idCheckboxs.length; i++){
		
		//判断顶上那个checkbox框的选中状态
		if(field.checked){
			
			idCheckboxs[i].checked = true;
		}else{
			idCheckboxs[i].checked = false;
		}
	}
}
function del(){
	//判断有哪些checkbox框被选中了
	var idCheckboxs = document.getElementsByName("id");
	var flag = confirm("确定要删除吗？");
	  if (flag==true){  
        var url = "<%=request.getContextPath()%>/delete.action";
      	var checkedIds = [];    	
      	for(var i=0; i<idCheckboxs.length; i++){
      		if(idCheckboxs[i].checked){
      			checkedIds[checkedIds.length] = idCheckboxs[i].value;
      		}
      	}
      	for(var i=0; i<checkedIds.length; i++){
      		if(i == 0){
      			url = url + "?id="+checkedIds[i];
      		}else{
      			url = url + "&id="+checkedIds[i];
      		}
      	}

      	window.location = url;
	  }else{  
          return false;  
      }  
  }  
	

</script>
<body>
<table width="600" border="1" style="margin: 0 auto;margin-top:25px;" id="showTable">
<tr>
	<td colspan="3" width="600"><input type="checkbox" name="checkbox" onclick="selectAll(this)" />全选/全不选</td>
	<td colspan="3" width="600" align="right" ><a href="<%=path%>/page/goods/insertGoods.jsp">添加</a></td>

</tr>

<tr>
	<form action="<%=request.getContextPath() %>/selectName.action" method="post">
	<td colspan="6" width="600" align="center">
	分类模糊查询：<input type="text" id="title" name="goodsname">
			<input type="submit" value="查询">				
	</td>
	</form>
	
</tr>
<tr>
	<td colspan="6" width="600" align="center">商品目录</td>
</tr>
<tr>
<td colspan="6" style="text-align: left;">
</tr>

		<tr style="background:#666">
				<td>选择框</td>
			    <td>商品编号</td>
				<td>商品名称</td>
				<td>商品价格</td>
				<td>商品数量</td>
				<td>操作</td>
			</tr>
	<c:forEach var="Goods" items="${requestScope.get('goodslist')}">
			<tr style="background:#CCC">
				<td width="100"><div align="left"><input type="checkbox" name="id" class="checkb" value="${Goods.id}"/></div></td>
				<td width="100">${Goods.id}</td>
				<td width="100">${Goods.goodsname}</td>
				<td width="100">${Goods.price}</td>
				<td width="100">${Goods.number}</td>
				<td width="100"><a href="<%=request.getContextPath()%>/toupdate.action?id=${Goods.id}">修改</a></td>			
		</tr>
	</c:forEach>

<tr>
<td align="center" colspan="6">
<div>

<input type="button" value="删除" onclick="del()">
<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="返回"/>
</div>
</td>
</tr>
	</table>
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
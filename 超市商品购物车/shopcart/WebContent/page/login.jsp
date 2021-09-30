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
<title>用户登录</title>
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color: #EBEBEB;
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
</style>
<body>
<!--对于输入手机号和密码的正则校验  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.js"></script>
<script type="text/javascript">
//手机号必须是1开头的11位数字
function checkPhone(){
    var  phone  = document.getElementById("phone").value;
    if(phone.length>0){
    	//符合当前时代的手机号
/*         	var reg= /^1[3|4|5|7|8][0-9]{9}$/; 
*/         var reg =/^1[0-9]{10}$/;
        var passSPan = document.getElementById("PhoneId");
        if(reg.test(phone)){
           //符合规则 
           passSPan.innerHTML="手机格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="手机号格式不正确".fontcolor("red");
           return false;
       }
    }  
 }
//校验密码  必须是6位
function checkPass(){
    var  userPass  = document.getElementById("userPass").value;
    if(userPass.length>0){
       var reg = /^\w{6}$/;
        var passSPan = document.getElementById("passId");
        if(reg.test(userPass)){
           //符合规则 
           passSPan.innerHTML="密码格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="密码必须是六位".fontcolor("red");
           return false;
       }
    }  
 }

//总体校验表单是否可以提交了 如果返回的true表单才可以提交。上面的表单项必须要每个都填写正确。

function checkForm(){
   var userPass = checkPass();
   var phone  = checkPhone();
   if(userPass&&phone){
      return true;
   }else{
       return false;
   }
}
</script> 
<div class="header">
<h2 style="color: white;font-size: 40px">登录界面</h2>
</div>
<div class="formdiv">
<form method="post" action="<%=request.getContextPath()%>/UserLogin.action" onsubmit="return checkForm()">
<table border="0" style="width: 500px;height: 300px">
	<tr align="center">
		<td>
		手机号：
		</td>
		<td>
		<input type="text" name="phone" id="phone" onblur="checkPhone()"/><span id="PhoneId"></span>
		</td>
	</tr>
	<tr align="center">
		<td>
		密码：
		</td>
		<td>
		<input type="password" name="password" id="userPass" onblur="checkPass()"><span id="passId"></span>
		</td>
	</tr>
	<tr align="center"	>
		<td>
		状态：
		</td>
		<td>
		<input type="radio" name="status" value="1">用户
		<input type="radio" name="status" value="2">店家
		</td>
	</tr>
	<tr align="center">
		<td colspan="2">
		<input type="submit" value="登录">
		<a href="<%=path%>/page/register.jsp">点击注册</a>
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
</form>
</div>
</body>
</html>
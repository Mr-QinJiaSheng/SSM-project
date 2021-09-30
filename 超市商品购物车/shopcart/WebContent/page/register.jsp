<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
	String path=request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册界面</title>
</head>
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
<form action="<%=request.getContextPath()%>/insertuser.action" method="post" onsubmit="return checkForm()">
			
	注册用户名字：<input type="text" name="username" id="username"  /><br/>
	注册用户密码：<input type="password" name="password" id="userPass" onblur="checkPass()"><span id="passId"></span><br/>
	注册用户名字手机号：<input type="text" name="phone" id="phone" onblur="checkPhone()"/><span id="PhoneId"></span><br/>
	注册用户状态：<input type="text" name="status" id="status"><br/>
	<input type="submit" value="提交"/>
	<input type="reset" value="重置"/>
	 
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
</body>
</html>
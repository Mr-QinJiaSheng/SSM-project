<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    /*拼接当前页面的基本路径*/
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/loginCss.css">
    <script src="${pageContext.request.contextPath}/static/layui.all.js"></script>
    <style>
        .form_div {
            padding: 120px 500px;
        }

        /*解决Chrome下表单自动填充后背景色为黄色*/
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 1000px white inset;
        }

        #contact {
            border-radius: 5px;
        }

        fieldset legend {
            font-weight: bolder;
            font-size: 20px;
            padding-bottom: 10px;
            color: #01AAED;
        }
    </style>
</head>
<body>
<div class="form_div">
    <form id="contact" action="<%=basePath%>check" method="post">
        <h3>选课系统</h3>
        <h4>第一次登陆后请尽快更改初始密码</h4>
        <fieldset>
            <legend>学生学号/教师账号</legend>
            <label for="userid"></label><input placeholder="输入学号或教师账号" type="text" name="userid" id="userid"
                                               tabindex="1" required autofocus>
        </fieldset>
        <fieldset>
            <legend>密码</legend>
            <label>
                <input placeholder="输入密码" type="password" name="userpass" tabindex="2" required>
            </label>
        </fieldset>
        <h4 style="color:red;">${msg}</h4>
        <fieldset>
            <legend></legend>
            <input name="sub" type="button" id="contact-submit" value="登录"/>
        </fieldset>
    </form>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(function () {
            $("#contact-submit").click(function () {
                let regExp = /^\d{10}$/;
                const id = $("#userid").val();
                if (regExp.test(id)) {
                    $("#contact").submit();
                } else {
                    alert("请输入正确学生学号/教师账号");
                }
            })
        })
    </script>
</div>
</body>
</html>

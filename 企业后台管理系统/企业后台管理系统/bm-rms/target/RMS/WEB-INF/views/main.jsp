
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>后台首页</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link  rel="stylesheet" href="${staticPath}/static/css/dictionary.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${path}/static/css/main.css">
    <script type="text/javascript" src="${staticPath }/static/js/jquery-3.2.1.min.js" charset="utf-8"></script>
</head>
<body>
<div class="div-bg">
    <div id="loading">
        <div id="loading-center">
            <div id="loading-center-absolute">
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
                <div class="object"></div>
            </div>
            <div id="load">
                <div><p>欢</p></div>
                <div><p>迎</p></div>
                <div><p>大</p></div>
                <div><p>家</p></div>
                <div><p>观</p></div>
                <div><p>看</p></div>
                <div><p>我</p></div>
                <div><p>们</p></div>
                <div><p>小</p></div>
                <div><p>组</p></div>
                <div><p>项</p></div>
                <div><p>目</p></div>
                <div><p>谢</p></div>
                <div><p>谢</p></div>
                <div><p>大</p></div>
                <div><p>家</p></div>
                <div><p>！</p></div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        $("#sex").text(sex());
        function sex() {
            switch (${sessionScope.sex}){
                case 0:{
                    return "先生";
                }
                case 1:{
                    return "女士";
                }
            }
        }
    });
</script>
</html>

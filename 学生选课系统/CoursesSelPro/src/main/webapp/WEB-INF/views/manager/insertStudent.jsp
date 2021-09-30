<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>添加学生</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <form class="layui-form" id="changeform" onsubmit="return check()" method="post" action="<%=basePath%>manager/addStudent" style="margin:80px 400px; width:450px;">
        <div class="layui-form-item">
            <label class="layui-form-label">学生姓名</label>
            <div class="layui-input-block">
                <input type="text" name="stuname" id="name" placeholder="请输入学生姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学生学号</label>
            <div class="layui-input-block">
                <input type="text" name="sid" id="sid" placeholder="请输入学生学号" autocomplete="off" class="layui-input">
            </div>
        </div>
       <div class="layui-form-item">
       <label class="layui-form-label">选择学院</label>
            <div style="display: inline-block">
                    <div style="width: 250px; float: left; margin-left:0px;">
                        <select class="layui-select" name="insid" id="insid">
                            <option value="0">学院名称</option>
                            <c:forEach items="${insList}" var="ins">
                                <option value="${ins.insId}">${ins.insName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                </div>
        </div>
        <p  style="margin-left: 130px;color :red">初始密码为学号</p>
        </br>
        <input type="submit"  class="layui-btn layui-btn-danger layui-btn-lg" style="margin-left: 130px" value="确认添加"/>
    </form>
        
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
         function check(){
             var name = $("#name").val();           
              var insid = $("#insid").val();
             var id = $("#sid").val();
             var flg = id.charAt(4);
             if(name==null||name==''){
                confirm("请输入学生姓名")
                return false;
             
             }else{
             if(flg!=0){
                confirm("学生学号第5位必须为0")
                return false;
              }
             }
             
             if(insid==0){
              confirm("请选择学院")
                return false;
              }
             
             return true;
        }
    </script>
</rapid:override>
<%@ include file="base.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>添加教师</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <form class="layui-form" id="changeform" method="post" onsubmit="return check()" action="<%=basePath%>manager/addTeacher" style="margin:80px 400px; width:450px;">
        <div class="layui-form-item">
            <label class="layui-form-label">教师姓名</label>
            <div class="layui-input-block">
                <input type="text" name="teaname" id="name" placeholder="请输入教师姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
      
        <div class="layui-form-item">
            <label class="layui-form-label">教师编号</label>
            <div class="layui-input-block">
                <input type="text" name="tid" id="tid" placeholder="请输入教师编号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <p  style="margin-left: 130px;color :red">初始密码为编号</p>
        </br>
        <input type="submit"  class="layui-btn layui-btn-danger layui-btn-lg" style="margin-left: 130px" value="确认添加"/>
    </form>
        
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
    
        function check(){
             var name = $("#name").val();
             var id = $("#tid").val();
             var flg = id.charAt(4);
             if(name==null||name==''){
                confirm("请输入教师姓名")
                return false;
             
             }else{
             if(flg!=1){
                confirm("教师编号第5位必须为1")
                return false;
              }
             }
             return true;
        }
      
    </script>
</rapid:override>
<%@ include file="base.jsp" %>

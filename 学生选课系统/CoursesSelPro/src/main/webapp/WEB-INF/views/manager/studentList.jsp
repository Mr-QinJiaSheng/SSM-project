<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>学生管理</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <div>
        <input type="button" onclick="insert()" value="添加学生" class="layui-btn layui-btn-lg layui-btn-warm" style="margin-top:15px;">
    </div>
    <script>
        function insert() {
            window.location.href="<%=basePath%>manager/insertStudent";
        }
    </script>
     <form class="layui-form" style="margin:10px 15px 10px;">
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div style="display: inline-block">
                    <div style="width: 180px; float: left; margin-left:-100px;">
                         <input type="text" id="searchId" class="layui-input" style="float:right; width:200px;"
                       placeholder="请输入学生学号">
                    </div>
                    <button type="button" onclick="search1()" class="layui-btn" style="margin-left:10px;">搜索</button>
                </div>
                <div style="display: inline-block">
                    <div style="width: 180px; float: left; margin-left:250px;">          
                <input type="text" id="searchName" class="layui-input" style="float:right; width:200px;"
                       placeholder="请输入学生姓名">
                    </div>
                    <button type="button" onclick="search2()" class="layui-btn" style="margin-left:10px;">搜索</button>
                </div>             
            </div>
        </div>
    </form>
    <p style="color:red; margin-top:10px; font-size:15px;">${msg}</p>
    <table class="layui-table" style="margin-top:15px;">
        <colgroup>
            <col width="100">
            <col width="100">
            <col width="200">
            <col width="60">
        </colgroup>
        <thead>
        <tr>
            <th>学生学号</th>
            <th>学生姓名</th>
            <th>已选课程</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${paging.dataList}" var="student">
            <tr>
                <td>${student.stuId}</td>
                <td>${student.stuName}</td> 
                <td>${student.className}</td>     
                <td>
                    <button class="layui-btn" onclick="delete_fun(${student.stuId})"  >删除
                    </button>     
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="hidden" id="stuid" value="${stuid}"/>
    <div style="text-align:center; margin-top:10px; margin-left:-100px;">
        <c:if test="${paging.totalPage >=0}">
            <p style=" color: black; font-size:16px; margin-bottom:10px;">当前第 ${paging.currentPage }
                页/共 ${paging.totalPage} 页</p>
            <c:choose>
                <c:when test="${paging.totalPage==0}">
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage==1}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage>1}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage<paging.totalPage}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage==paging.totalPage}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
            </c:choose>
        </c:if>
    </div>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
    <script>
        function search1() {
            var sid = document.getElementById("searchId").value;
            window.location.href = "<%=basePath%>manager/searchBySid?sId=" + sid;
        }
        function search2() {
            var sName = document.getElementById("searchName").value;
            window.location.href = "<%=basePath%>manager/searchBySname?sName=" + sName;
        }

        function goPage(page) {
            window.location.href = "<%=basePath%>manager/studentList?page=" + page;
        }

        function detail_fun(classId) {
            window.location.href = "<%=basePath%>student/courseDetail?classId=" + classId;
        }

        function delete_fun(stuId) {
            var r = confirm("确认删除吗？")
            if (r == true) {
                window.location.href = "<%=basePath%>manager/deleteStudent?stuid=" + stuId;
            }
            else {
                return;
            }
        }
    </script>
    <script>
        $(function () {
            $("#tea").click(function () {
                var teaid=$("#teasearch option:selected").attr("value");
                var stuid=$("#search").val();
                if(teaid===0){
                    alert("请选择正确的学生姓名");
                }
                else{
                    window.location.href="<%=basePath%>student/searchListByStuId?stuid="+teaid;
                }                                                 
            });
            $("#ins").click(function () {
                var insid=$("#inssearch option:selected").attr("value");
                var stuid=$("#stuid").val();
                if(insid===0){
                    alert("请选择正确的学号");
                }
                else{
                    window.location.href="<%=basePath%>student/searchListByInsId?insid="+insid+"&stuid="+stuid;
                }
                                                                 
            });
        })
    </script>
</rapid:override>
<%@ include file="base.jsp" %>

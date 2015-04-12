<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/12
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <link href="./css/mystyle.css" rel="stylesheet">
    <link href="./css/bootstrap.css" rel="stylesheet">
    <script src="./js/jquery-1.8.3.js"></script>
    <script src="./js/bootstrap.js"></script>
    <script src="./js/json2.js"></script>
    <script type="text/javascript">
        function loadCourse() {
            $.get("/course/loadCourse", function(data) {
                var list = data.data;
                var str = "";
                //alert(list.length);
                if(0 == list.length) {
                    str+="<div class='well'>";
                    str+="  <p class='text-info'>目前还没有相关课程信息，请添加！</p>";
                    str+="  <div class='btn-group'>";
                    str+="      <a href='#CourseModal' role='button' class='btn btn-success disabled' disabled='disabled' data-toggle='modal'>添加实验室信息</a>";
                    str+="  </div>";
                    str+="</div>";
                }
                $("#showCourse").html(str);
            });
        }

        $(function () {
            loadCourse();
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
                });
            });
        })
    </script>
</head>

<!-- Modal -->
<div id="CourseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">添加课程信息</h3>
    </div>
    <div class="modal-body">
        <form class="form-horizontal">
            <fieldset>
                <div class="control-group">
                    <label class="control-label" for="coursename">课程名称 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="coursename" name="coursename" placeholder="实验室">

                        <p class="help-block">请在此输入课程名称。</p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="coursedept">课程开设学院 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="coursedept" name="coursedept" placeholder="实验室地点">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="coursemajor">课程开设专业 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="coursemajor" name="coursemajor" placeholder="所属学院">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="targetclass">课程开设班级 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="targetclass" name="targetclass" placeholder="所属学院">
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="modal-footer">
        <div class="alert alert-info hide">
        </div>
        <button class="btn btn-success" id="labinsert">提交</button>
    </div>
</div>

<body>
<div class="navbar navbar-inverse" style="position: static;">
    <div class="navbar">
        <div class="navbar-inner">
            <div class="control_dos pull-right">
                <!-- Button to trigger modal -->
                <c:choose>
                    <c:when test="${sessionScope.user==null}">
                        <a href="#loginModal" role="button" class="btn btn-primary" data-toggle="modal">登录</a>
                        <a href="#regModal" role="button" class="btn btn-success" data-toggle="modal">新用户注册</a>
                    </c:when>
                    <c:otherwise>
                        <div class="control_dos pull-right">
                            <ul class="nav pull-right">
                                <li id="fat-menu" class="dropdown">
                                    <a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown"><i
                                            class="icon-user icon-white"></i>当前用户：<%=session.getAttribute("user") %> <b
                                            class="caret"></b></a>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
                                        <li role="presentation" class="divider"></li>
                                        <li role="presentation" id="logout"><a role="menuitem" tabindex="-1">退出</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="nav-collapse">
                <ul class="nav">
                    <li><a href="./teacher.jsp">首页</a></li>
                    <li class="active"><a href="./coursemanager.jsp">添加课程信息</a></li>
                    <li><a href="#">实验室申请</a></li>
                    <li><a href="#">查看实验室课程表</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="mycontianer">
    <div class="container">
        <div class="jumbotron">
            <div class="page-header">
                <h1>课程管理</h1>
            </div>

            <p class="p1" id="showCourse">

            </p>
        </div>
        <div class="footer" style="margin-top: 10px;">
            <div class="container">
                <hr>
                Powered by HTML 4.0
                <br>
                Copyright © 计算机应用112班 缪萍.
                All rights reserved.
                <br>
                0.052352 sec - 0 queries - 0 sec @ portal
            </div>
        </div>
    </div>
</div>
</body>
</html>


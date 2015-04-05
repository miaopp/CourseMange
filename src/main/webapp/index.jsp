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
        var userid = <%=request.getSession().getAttribute("uid") %>
        function loginBean(username, password) {
            this.username = username;
            this.password = password;
        }
        function registerBean(username, password, realName, dept, classes, course, power) {
            this.username = username;
            this.password = password;
            this.realName = realName;
            this.dept = dept;
            this.classes = classes;
            this.course = course;
            this.power = power;
        }

        $(function () {
            $("#login").click(function() {
                var username = $("#loginModal input[name='username']").val();
                var password = $("#loginModal input[name='password']").val();
                var json = JSON.stringify(new loginBean(username, password));
                $.ajax({
                    type: "post",
                    url: "/user/login",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if (data == "success") {
                            alert("success");
                            location = location;
                        }
                        else {
                            $("#loginModal .alert").removeClass("alert-info").addClass("alert-error");
                            $("#loginModal .alert").html("<p class='p1'>failed to Login!</p>");
                        }
                    }
                });
                return false;
            });
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
                });
            });
            $("#register").click(function() {
                var username = $("#regModal input[name='username']").val();
                var password = $("#regModal input[name='password']").val();
                var realName = $("#regModal input[name='realname']").val();
                var dept = $("#regModal input[name='dept']").val();
                var classes = $("#regModal input[name='class']").val();
                var course = $("#regModal input[name='course']").val();
                var power = $("#regModal input[name='power']").val();
                var json = JSON.stringify(new registerBean(username, password, realName, dept, classes, course, power));
                $.ajax({
                    type: "post",
                    url: "/user/register",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if (data == "success") {
                            alert(data);
                            location = location;
                        }
                        else {
                            $("#regModal .alert").removeClass("alert-info").addClass("alert-error");
                            $("#regModal .alert").html("<p class='p1'>failed to Regist!</p>");
                        }
                    }
                });
                return false;
            });
        })

    </script>
</head>
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
                    <li class="active"><a href="./index.jsp">首页</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <form class="form-horizontal">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="loginModalLabel">登录</h3>
        </div>
        <div class="modal-body">
            <div class="control-group">
                <label class="control-label" for="inputUsername">用户名：</label>

                <div class="controls">
                    <input type="text" id="inputUsername" placeholder="Username" name="username">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPassword">密码：</label>

                <div class="controls">
                    <input type="password" id="inputPassword" placeholder="Password" name="password">
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <div class="alert alert-info hide">
            </div>
            <button class="btn btn-primary" id="login">登录</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        </div>
    </form>
</div>

<div id="regModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="registModalLabel">注册</h3>
    </div>
    <div class="modal-body">
        <form class="form-horizontal">
            <fieldset>
                <div class="control-group">
                    <label class="control-label" for="username">用户名 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="username" name="username" placeholder="用户名">

                        <p class="help-block">请在此输入您的用户名（大小写敏感）。</p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="password">密码 (必填)：</label>

                    <div class="controls">
                        <input type="password" class="input-xlarge" id="password" name="password" placeholder="密码">

                        <p class="help-block">请在此输入您的密码（大小写敏感）。</p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="realname">姓名 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="realname" name="realname" placeholder="姓名">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="realname">所在专业 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="dept" name="dept" placeholder="专业">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="realname">所在（教授）班级 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="class" name="class" placeholder="班级">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="realname">所上（教授）课程 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="course" name="course" placeholder="课程">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">身份(必选)：</label>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="option" value="0" checked>
                            学生
                        </label>
                        <label class="radio">
                            <input type="radio" name="option" value="1">
                            老师
                        </label>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="modal-footer">
        <div class="alert alert-info hide">
        </div>
        <button class="btn btn-success" id="register">提交</button>
    </div>
</div>

<div class="mycontianer">
    <div class="container-fluid">
        <%--<div class="jumbotron">--%>
            <%--<h1>欢迎登录实验室排课系统</h1>--%>

            <%--<p class="lead" id="showNotice">--%>

            <%--</p>--%>
        <%--</div>--%>
        <div class="row-fluid">
            <div class="span3">
                <div class="well sidebar-nav">
                    <ul class="nav nav-list">
                        <li class="nav-header">Sidebar</li>
                        <li class="active"><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li class="nav-header">Sidebar</li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li class="nav-header">Sidebar</li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                    </ul>
                </div><!--/.well -->
            </div><!--/span-->
            <div class="span9">
                <div class="page-header">
                <h1>欢迎登录实验室排课系统</h1>

                <p class="lead" id="showNotice">

                </p>
                </div>
                <div class="row-fluid">
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                </div><!--/row-->
                <div class="row-fluid">
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                    <div class="span4">
                        <h2>Heading</h2>
                        <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                        <p><a class="btn" href="#">View details »</a></p>
                    </div><!--/span-->
                </div><!--/row-->
            </div><!--/span-->
        </div>
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
</body>
</html>

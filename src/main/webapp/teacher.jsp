<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/5
  Time: 17:14
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
        $(function () {
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
                });
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
                        <li class="nav-header">Home</li>
                        <li class="active"><a href="#">查看实验室课程表</a></li>
                        <li><a href="#">查看实验室申请状态</a></li>
                        <li><a href="#">实验室申请</a></li>
                        <li><a href="#">个人信息修改</a></li>
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

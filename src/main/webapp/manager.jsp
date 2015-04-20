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
<html ng-app="managerModule" ng-controller="managerCtrl">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- css-->
    <link href="./css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="./css/mystyle.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .nav, .pagination, .carousel, .panel-title a {
            cursor: pointer;
        }
    </style>
    <!-- JavaScripts-->
    <script type="text/javascript" src="./js/jquery-2.1.3.js"></script>
    <script type="text/javascript" src="./js/bootstrap.js"></script>
    <script type="text/javascript" src="./js/angular.js"></script>
    <script type="text/javascript" src="./js/ui-bootstrap-0.12.1.js"></script>
    <script type="text/javascript">
        var app = angular.module('managerModule', ['ui.bootstrap']);
        app.controller("managerCtrl", function ($scope, $http) {
            $scope.LoadNotice = {targetUser: <%=session.getAttribute("uid")%>};
            $scope.noticeIsEmpty = true;
            $http.post("/notice/loadNotice" ,$scope.LoadNotice)
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.notice = response.data;
                            if($scope.notice.length > 0) {
                                $scope.noticeIsEmpty = false;
                            }
                            else {
                                $scope.noticeIsEmpty = true;
                            }
                        }
                    })
        });
    </script>
</head>
<body>
<%--<div class="navbar navbar-inverse" style="position: static;">--%>
    <%--<div class="navbar">--%>
        <%--<div class="navbar-inner">--%>
            <%--<div class="control_dos pull-right">--%>
                <%--<!-- Button to trigger modal -->--%>
                <%--<c:choose>--%>
                    <%--<c:when test="${sessionScope.user==null}">--%>
                        <%--<a href="#loginModal" role="button" class="btn btn-primary" data-toggle="modal">登录</a>--%>
                        <%--<a href="#regModal" role="button" class="btn btn-success" data-toggle="modal">新用户注册</a>--%>
                    <%--</c:when>--%>
                    <%--<c:otherwise>--%>
                        <%--<div class="control_dos pull-right">--%>
                            <%--<ul class="nav pull-right">--%>
                                <%--<li id="fat-menu" class="dropdown">--%>
                                    <%--<a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown"><i--%>
                                            <%--class="icon-user icon-white"></i>当前用户：<%=session.getAttribute("username") %> <b--%>
                                            <%--class="caret"></b></a>--%>
                                    <%--<ul class="dropdown-menu" role="menu" aria-labelledby="drop3">--%>
                                        <%--<li role="presentation" class="divider"></li>--%>
                                        <%--<li role="presentation" id="logout"><a role="menuitem" tabindex="-1">退出</a></li>--%>
                                    <%--</ul>--%>
                                <%--</li>--%>
                            <%--</ul>--%>
                        <%--</div>--%>
                    <%--</c:otherwise>--%>
                <%--</c:choose>--%>
            <%--</div>--%>
            <%--<div class="nav-collapse">--%>
                <%--<ul class="nav">--%>
                    <%--<li class="active"><a href="./manager.jsp">首页</a></li>--%>
                    <%--<li><a href="./labmanager.jsp">实验室管理</a></li>--%>
                    <%--<li><a href="#">实验室课程申请管理</a></li>--%>
                    <%--<li><a href="usermanager.jsp">用户信息管理</a></li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Brand</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
                <li><a href="#">Link</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1>欢迎登录实验室排课系统</h1>
    </div>

    <div class='well'>
        <p class='text-info' ng-show="noticeIsEmpty">目前没有待处理申请。</p>
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
</body>
</html>
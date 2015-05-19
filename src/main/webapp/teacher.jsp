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
<html ng-app="TeacherModule" ng-controller="TeacherCtrl">
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
    <script type="text/javascript" src="./js/angular-sanitize.js"></script>
    <script type="text/javascript" src="./js/ui-bootstrap-0.12.1.js"></script>
    <script type="text/javascript">
        var app = angular.module('TeacherModule', ['ui.bootstrap', 'ngSanitize']);
        app.controller("TeacherCtrl", function ($scope, $http) {
            $scope.logout = function () {
                $http.get("/user/logout")
                        .success(function () {
                            location.href = "./login.jsp";
                        })
            }

            $scope.LoadNotice = {targetUser: <%=session.getAttribute("uid")%>};
            $scope.noticeIsEmpty = true;
            $http.post("/notice/loadTeacherNotice" ,$scope.LoadNotice)
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.notice = response.data;
                            $scope.noticeIsEmpty = $scope.notice.length == 0;
                        }
                    })
            $scope.noticeState = ["", "", "同意", "拒绝"];
        });
    </script>
</head>
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
            <a class="navbar-brand" href="#">LabManagement</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="./teacher.jsp">首页</a></li>
                <li><a href="./coursemanager.jsp">课程信息管理</a></li>
                <li><a href="./courseDisplayToTeacher.jsp">查看实验室课程表</a></li>
                <li><a href="./teacherPersonalMessage.jsp">个人信息管理</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        当前用户：<%=session.getAttribute("username")%> <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a ng-click="logout()">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<body>

<div class="container">
    <div class="page-header">
        <h1>欢迎登录实验室排课系统</h1>
    </div>

    <div class="panel panel-danger" ng-repeat="item in notice">
        <div class="panel-heading">
            <h3 class="panel-title" id="panel-title">实验室 {{item.labName}} 审核提醒<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
        </div>
        <div class="panel-body">
            实验室管理员{{item.userRealName}} {{noticeState[item.state]}} 了您的申请
        </div>
        <div class="panel-footer">
            <button type="button" class="btn btn-link">标记为已读</button>
            <button type="button" class="btn btn-link" ng-show="item.state==3?true:false">重新申请实验室</button>
        </div>
    </div>
    <div class="panel panel-danger" ng-show="noticeIsEmpty">
        <div class="panel-heading">
            <h3 class="panel-title">目前没有未处理消息！<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
        </div>
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

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
    <!-- Timeline CSS -->
    <link href="./css/timeline.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="./css/font-awesome.min.css" rel="stylesheet" type="text/css">
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
            };
            $scope.pagination = {TotalItems: 0, CurrentPage: 1, maxSize: 5, itemsPerPage: 15, numPages: -1};
            $scope.load = function () {
                $http.post("/notice/loadTeacherNotice?start="+(($scope.pagination.CurrentPage-1)*$scope.pagination.itemsPerPage)+"&length="+$scope.pagination.itemsPerPage ,$scope.LoadNotice)
                        .success(function (response) {
                            if(200 == response.status) {
                                $scope.notice = response.data.notice;
                                $scope.pagination.TotalItems = response.data.count;
                                $scope.noticeIsEmpty = $scope.notice.length == 0;
                            }
                        });
            };

            $scope.LoadNotice = {targetUser: <%=session.getAttribute("uid")%>};
            $scope.noticeIsEmpty = true;
            $scope.load();
            $scope.noticeState = ["", "", "同意", "拒绝"];
            $scope.TimeLineWay = function (state) {
                if (2 == state) {
                    return "";
                } else {
                    return "timeline-inverted";
                }
            };
            $scope.changestate = {noticeId: -1, state: -1};
            $scope.noticeHasBeenRead = function (NoticeId, State) {
                $scope.changestate.noticeId = NoticeId;
                $scope.changestate.state = State;
                $http.post("/notice/noticeIsRead", $scope.changestate)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
            }
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
                    <a class="dropdown-toggle active" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i>当前用户：<%=session.getAttribute("username")%><i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user in">
                        <li class="divider"></li>
                        <li><a href="#" ng-click="logout()"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
            </ul>
        </div>
    </div>
</nav>
<body background="./img/bg.png" class="mybodystyle">

<div class="container">
    <div class="page-header">
        <h1>欢迎登录实验室排课系统</h1>
    </div>

    <!-- /.panel -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-clock-o fa-fw"></i> 审核提醒
            <div class="pull-right">Page: {{pagination.CurrentPage}} / {{pagination.numPages}}</div>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body" ng-if="!noticeIsEmpty">
            <ul class="timeline">
                <li ng-repeat="item in notice" ng-class="{'timeline-inverted':item.state==3}">
                    <div class="timeline-badge warning" ng-if="item.state == 3"><i class="fa fa-times"></i></div>
                    <div class="timeline-badge success" ng-if="item.state == 2"><i class="fa fa-check"></i></div>
                    <div class="timeline-panel">
                        <div class="timeline-heading">
                            <h4 class="timeline-title">实验室 {{item.labName}} 审核提醒</h4>
                            <p><small class="text-muted"><i class="fa fa-clock-o"></i>{{item.applyTime}}</small>
                            </p>
                        </div>
                        <div class="timeline-body">
                            <p>实验室管理员{{item.userRealName}} {{noticeState[item.state]}} 了您的申请</p>
                            <div>
                                <button type="button" class="btn btn-link" ng-click="noticeHasBeenRead(item.noticeId, 4)">标记为已读</button>
                                <a href="./coursemanager.jsp" class="btn btn-link" ng-show="item.state==3?true:false">重新申请实验室</a>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="panel-body" ng-if="noticeIsEmpty">
            <ul class="timeline">
                <li>
                    <div class="timeline-badge danger"><i class="fa fa-save"></i></div>
                    <div class="timeline-panel">
                        <p>目前没有未处理消息！</p>
                    </div>
                </li>
            </ul>
        </div>
        <!-- /.panel-body -->
        <pagination class="pull-right" ng-change="load()" total-items="pagination.TotalItems" items-per-page="pagination.itemsPerPage" ng-model="pagination.CurrentPage" max-size="pagination.maxSize" class="pagination-sm" boundary-links="true" rotate="false" num-pages="pagination.numPages"></pagination>
    </div>
    <!-- /.panel -->
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

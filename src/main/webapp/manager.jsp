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
    <script type="text/javascript" src="./js/angular-sanitize.js"></script>
    <script type="text/javascript" src="./js/ui-bootstrap-0.12.1.js"></script>
    <script type="text/javascript">
        var app = angular.module('managerModule', ['ui.bootstrap', 'ngSanitize']);
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

            $scope.courseApplyDetail = function (item) {
                $http.post("/apply/courseDisplay?LabId=" + item.labId)
                        .success(function (response) {
                            if (200 == response.status) {
                                $scope.Course = response.data.list;
                                $scope.LabName = response.data.labName;
                            }
                        })
            }
            $scope.applyChangeState = function (item, state) {
                $http.post("/apply/applyChangeState?applyId=" + item.applyId + "&state=" + state)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
            }

            $scope.logout = function () {
            $http.get("/user/logout")
                    .success(function () {
                        location.href = "./login.jsp";
                    })
        }
        });
    </script>
</head>
<body>
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
                <li class="active"><a href="./manager.jsp">首页</a></li>
                <li><a href="./labmanager.jsp">实验室管理</a></li>
                <li><a href="./courseApplyManager.jsp">实验室课程申请管理</a></li>
                <li><a href="./usermanager.jsp">用户信息管理</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        当前用户：<%=session.getAttribute("username")%> <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">修改个人信息</a></li>
                        <li><a ng-click="logout()">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" ng-model="LabName">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="CourseModalLabel">{{LabName}}实验室排课情况<a class="anchorjs-link" href="#CourseModalLabel"><span class="anchorjs-icon"></span></a></h4>
            </div>
            <div class="panel panel-info">
                <!-- Table -->
                <table class="table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>星期一</th>
                        <th>星期二</th>
                        <th>星期三</th>
                        <th>星期四</th>
                        <th>星期五</th>
                        <th>星期六</th>
                        <th>星期日</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="order in Course">
                        <th scope="row">第{{$index+1}}节</th>
                        <td ng-repeat="item in order track by $index" ng-bind-html="item"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-header">
        <h1>欢迎登录实验室排课系统</h1>
    </div>
    <div class="panel panel-info" ng-repeat="item in notice">
        <div class="panel-heading">
            <h3 class="panel-title" id="panel-title">{{item.labName}}实验室申请<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
        </div>
        <div class="panel-body">
            教师{{item.userRealName}}就所教授课程{{item.courseName}}提出实验室申请
        </div>
        <div class="panel-footer">
            <button type="button" class="btn btn-link" data-toggle="modal" data-target=".bs-example-modal-lg" ng-click="courseApplyDetail(item)">
                查看详情
            </button>
            <button type="button" class="btn btn-link" ng-click="applyChangeState(item, 2)">
                同意申请
            </button>
            <button type="button" class="btn btn-link" ng-click="applyChangeState(item, 3)">
                拒绝申请
            </button>
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
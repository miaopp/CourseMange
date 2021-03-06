<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/22
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="CourseDisplayByLabModule" ng-controller="CourseDisplayByLabCtrl">
<head>
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
        var app = angular.module('CourseDisplayByLabModule', ['ui.bootstrap', 'ngSanitize']);
        app.controller("CourseDisplayByLabCtrl", function ($scope, $http) {
            $scope.logout = function () {
                $http.get("/user/logout")
                        .success(function () {
                            location.href = "./login.jsp";
                        })
            }
            $http.post("/lab/getLabListByTeacher")
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.academyLabs = response.data;
                        }
                    })
            $scope.selectLabId = -1;
            $scope.LabSelect = "未选择";
            $scope.LabSelector = function (item) {
                $scope.LabSelect = item.labName;
                $scope.selectLabId = item.id;
            }
            $scope.Display = false;
            $scope.LabCourseDisplay = function() {
                $http.post("/apply/courseDisplayByLab?labId=" + $scope.selectLabId)
                        .success(function (response) {
                            if(200 == response.status) {
                                $scope.Course = response.data.list;
                                $scope.LabName = response.data.labName;
                                $scope.Display = true;
                            }
                        })
            }
        });
    </script>
</head>
<body background="./img/bg.png" class="mybodystyle">
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
                <li><a href="./index.jsp">首页</a></li>
                <li class="active"><a href="./courseDisplayByLab.jsp">按实验室查看课表</a></li>
                <li><a href="studentPersonalMessage.jsp">个人信息管理</a></li>
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
<div class="container">
    <div class="page-header">
        <h1>按实验室查看课表</h1>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-graduation-cap"></i>查看实验室课表
        </div>
        <div class="panel-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2">
                        <h5>选择想要查看的实验室：</h5>
                    </div>
                    <div class="col-sm-1">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">{{LabSelect}} <span class="caret"></span></button>
                            <ul class="dropdown-menu" role="menu">
                                <li ng-repeat="item in academyLabs">
                                    <a ng-click="LabSelector(item)">{{item.labName}}</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <button type="button" class="btn btn-success" ng-click="LabCourseDisplay()">确认</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default" ng-if="Display">
        <!-- Default panel contents -->
        <div class="panel-heading"><i class="fa fa-save"></i>{{LabName}}实验室课程安排</div>
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


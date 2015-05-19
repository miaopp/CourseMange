<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/22
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.mpp.model.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html ng-app="courseDisToTeacherModule" ng-controller="courseDisToTeacherCtrl">
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
        var app = angular.module('courseDisToTeacherModule', ['ui.bootstrap', 'ngSanitize']);
        app.controller("courseDisToTeacherCtrl", function ($scope, $http) {
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
            $scope.LabSelector = function(item) {
                $scope.LabSelect = item.labName;
                $scope.selectLabId = item.id;
            }
            $scope.Display = false;
            $scope.LabCourseDisplay = function() {
                $http.post("/apply/courseDisplay?LabId=" + $scope.selectLabId)
                        .success(function (response) {
                            if(200 == response.status) {
                                $scope.Course = response.data.list;
                                $scope.LabName = response.data.labName;
                                $scope.Display = true;
                            }
                        })
            }
            $scope.Apply = {labId: -1, dayOfWeek: -1, orders: -1, courseId: -1, userId: <%=session.getAttribute("uid")%>};
            $scope.addApply = function (DayOfWeek, Orders) {
                $scope.Apply.labId = $scope.selectLabId;
                $scope.Apply.dayOfWeek = DayOfWeek;
                $scope.Apply.orders = Orders;
            }
            $scope.selectCourseId = -1;
            $scope.CourseSelect = "未选择";
            $scope.CourseSelector = function(item) {
                $scope.CourseSelect = item.name;
                $scope.selectCourseId = item.id;
            }
            $http.post("/course/loadCourseByTeacher")
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.coursesOfTeacher = response.data;
                        }
                    })
            $scope.submitApply = function () {
                $scope.Apply.courseId = $scope.selectCourseId;
                $http.post("/apply/addApply", $scope.Apply)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
            }

        });
    </script>
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
                <li><a href="./teacher.jsp">首页</a></li>
                <li><a href="./coursemanager.jsp">课程信息管理</a></li>
                <li class="active"><a href="./courseDisplayToTeacher.jsp">查看实验室课程表</a></li>
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
<div class="modal fade" id="LabApplyModal" tabindex="-1" role="dialog" aria-labelledby="LabApplyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="LabApplyModalLabel">申请课程安排</h4>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputCourse" class="col-sm-3 control-label col-sm-offset-2">请选择课程</label>
                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="inputCourse">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> {{CourseSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in coursesOfTeacher">
                                        <a ng-click="CourseSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-success" ng-click="submitApply()">提交</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="page-header">
        <h1>实验室课表</h1>
    </div>
    <div class="panel panel-default">
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
    <div class="panel panel-info" ng-show="Display">
        <!-- Default panel contents -->
        <div class="panel-heading">{{LabName}}实验室课程安排</div>
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
                <td ng-repeat="item in order track by $index">
                    <div ng-bind-html="item"></div>
                    <a ng-show="item.length == 0" data-toggle="modal" data-target="#LabApplyModal" tooltip="申请课程安排" tooltip-placement="right" ng-click="addApply($index+1, $parent.$index+1)">
                        <span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
                    </a>
                </td>
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

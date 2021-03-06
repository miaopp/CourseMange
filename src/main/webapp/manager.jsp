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
        var app = angular.module('managerModule', ['ui.bootstrap', 'ngSanitize']);
        app.controller("managerCtrl", function ($scope, $http) {
            $scope.LoadNotice = {targetUser: <%=session.getAttribute("uid")%>};
            $scope.noticeIsEmpty = true;
            $scope.noticeIsNotEmpty = false;
            $scope.pagination = {TotalItems: 0, CurrentPage: 1, maxSize: 5, itemsPerPage: 15, numPages: -1};
            $scope.load = function () {
                $http.post("/notice/loadManagerNotice?start="+(($scope.pagination.CurrentPage-1)*$scope.pagination.itemsPerPage)+"&length="+$scope.pagination.itemsPerPage, $scope.LoadNotice)
                        .success(function (response) {
                            if (200 == response.status) {
                                $scope.notice = response.data.notice;
                                $scope.pagination.TotalItems = response.data.count;
                                if ($scope.notice.length > 0) {
                                    $scope.noticeIsEmpty = false;
                                    $scope.noticeIsNotEmpty = true;
                                }
                                else {
                                    $scope.noticeIsEmpty = true;
                                    $scope.noticeIsNotEmpty = false;
                                }
                            }
                        });
            };
            $scope.load();
            $scope.noticeLength = 0;

            $scope.courseApplyDetail = function (item) {
                $http.post("/apply/courseDisplay?LabId=" + item.labId)
                        .success(function (response) {
                            if (200 == response.status) {
                                $scope.Course = response.data.list;
                                $scope.LabName = response.data.labName;
                            }
                        })
            }
            $scope.applyBean = {applyId: -1, state: -1, msg: ""};
            $scope.changeInfo = function (id, state) {
                $scope.applyBean.applyId = id;
                $scope.applyBean.state = state;
            }
            $scope.applyChangeState = function () {
                $http.post("/apply/applyChangeState", $scope.applyBean)
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
<body class="mybodystyle" background="./img/bg.png">
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
                <li><a href="./usermanager.jsp">用户信息管理</a></li>
                <li><a href="./managerPersonalMessage.jsp">个人信息管理</a></li>
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

<!-- Modal -->
<div id="rejectModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="rejectModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 id="addModalLabel">处理申请</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-4">拒绝理由：</label>
                    </div>
                    <div class="form-group">
                        <textarea class="col-sm-8 col-sm-offset-2" rows="5" cols="80" ng-model="applyBean.msg"tooltip="请简述拒绝理由" tooltip-trigger="focus" tooltip-placement="bottom"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="alert alert-info hide">
                </div>
                <button class="btn btn-success" ng-click="applyChangeState()">提交</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="CourseModalLabel"><i class="fa fa-graduation-cap"></i>{{LabName}}实验室排课情况<a class="anchorjs-link" href="#CourseModalLabel"><span class="anchorjs-icon"></span></a></h4>
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
    <!-- /.panel -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i>
            实验室申请提醒
            <div class="pull-right">Page: {{pagination.CurrentPage}} / {{pagination.numPages}}</div>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body" ng-if="!noticeIsEmpty">
            <ul class="timeline">
                <li ng-repeat="item in notice" ng-class="{'timeline-inverted': $index%2 == 1}">
                    <div class="timeline-badge success"><i class="fa fa-graduation-cap"></i></div>
                    <div class="timeline-panel">
                        <div class="timeline-heading">
                            <h4 class="timeline-title">实验室 {{item.labName}} 申请提醒</h4>
                            <p><small class="text-muted"><i class="fa fa-clock-o"></i>{{item.applyTime}}</small>
                            </p>
                        </div>
                        <div class="timeline-body">
                            <p>教师 {{item.userRealName}} 就所教授课程 {{item.courseName}} 提出实验室 {{item.labName}} 申请</p>
                            <div>
                                <button type="button" class="btn btn-link" data-toggle="modal" data-target=".bs-example-modal-lg" ng-click="courseApplyDetail(item)">
                                    查看详情
                                </button>
                                <button type="button" class="btn btn-link" ng-click="changeInfo(item.applyId, 2);applyChangeState()">
                                    同意申请
                                </button>
                                <button type="button" class="btn btn-link" ng-click="changeInfo(item.applyId, 3)" data-toggle="modal" data-target="#rejectModal">
                                    拒绝申请
                                </button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="panel-body"  ng-if="noticeIsEmpty">
            <ul class="timeline">
                <li>
                    <div class="timeline-badge danger"><i class="fa fa-save"></i></div>
                    <div class="timeline-panel">
                        <p>目前没有待处理的消息！</p>
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
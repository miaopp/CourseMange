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
                            if ($scope.notice.length > 0) {
                                $scope.noticeIsEmpty = false;
                            }
                            else {
                                $scope.noticeIsEmpty = true;
                            }
                        }
                    })
            $scope.noticeOfTeacherIsHandled = function (item, state) {
                $http.post("/notice/noticeOfTeacherChange?applyId=" + item.appyId + "&state=" + state)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
            }
            
            $scope.changeUser = {userId: <%=session.getAttribute("uid")%>, password: "", dept: -1, major: "", classes: ""};
            $scope.academy = [{code: -1, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件学院"}];
            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.changeUser.dept = item.code;
            };
            $scope.userChange = function () {
                $http.post("/user/userChange", $scope.changeUser)
                        .success(function (response) {
                            if(200 == response.data) {
                                alert("信息修改成功！");
                                location.reload();
                            }
                        })
            }
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
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        当前用户：<%=session.getAttribute("username")%> <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#changeUserModal" data-toggle="modal">修改个人信息</a></li>
                        <li><a ng-click="logout()">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<body>

<div id="changeUserModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="changeUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 id="registerModalLabel">基本信息修改</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputPasswordReg" class="col-sm-3 control-label col-sm-offset-1">密码</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="inputPasswordReg" placeholder="密码" ng-model="changeUser.password">
                            <p class="help-block">请在此输入您的密码（大小写敏感）。</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="dept">所属学院</label>

                        <div class="controls col-sm-6">
                            <div class="btn-group open choice" id="dept">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> {{academySelected}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in academy">
                                        <a ng-click="academySelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputMajorReg" class="col-sm-3 control-label col-sm-offset-1">所在专业</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputMajorReg" placeholder="专业" ng-model="changeUser.major">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputClassReg" class="col-sm-3 control-label col-sm-offset-1">所在（教授）班级</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputClassReg" placeholder="班级" ng-model="changeUser.classes">
                        </div>
                    </div>

                    <br/>
                    <div class="modal-footer">
                        <div class="alert alert-info hide">
                        </div>
                        <button type="button" class="btn btn-success" ng-click="userChange()">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="page-header">
        <h1>欢迎登录实验室排课系统</h1>
    </div>

    <div class="panel panel-danger" ng-repeat="item in notice">
        <div class="panel-heading">
            <h3 class="panel-title" id="panel-title">实验室申请审核提醒<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
        </div>
        <div class="panel-body" ng-show="noticeIsEmpty">
            目前没有未处理消息！
        </div>
        <div class="panel-body">
            实验室管理员{{item.userRealName}} {{noticeState[item.state]}} 了您的申请
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

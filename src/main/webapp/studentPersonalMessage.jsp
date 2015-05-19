<%@ page import="com.mpp.model.User" %>
<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/5/18
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="studentPersonalMessageModule" ng-controller="studentPersonalMessageCtrl">
<head>
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
        var app = angular.module('studentPersonalMessageModule', ['ui.bootstrap', 'ngSanitize']);
        app.controller("studentPersonalMessageCtrl", function ($scope, $http) {
            $scope.logout = function () {
                $http.get("/user/logout")
                       .success(function () {
                           location.href = "./login.jsp";
                       })
            }

            $scope.user = {userId: <%=((User)session.getAttribute("user")).getUserId() %>, realName: "<%=((User)session.getAttribute("user")).getRealName()%>", dept: <%=((User)session.getAttribute("user")).getDept()%>, major: <%=((User)session.getAttribute("user")).getMajor()%>, classes: <%=((User)session.getAttribute("user")).getClasses()%>};
            $scope.academy = [{code: 0, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件工程学院"}];
            $scope.major = [
                [],
                [{code: 101, name: "计算机科学与技术"}, {code: 102, name: "数字媒体"}],
                [{code: 201, name: "软件工程"}]
            ];
            $scope.majorList = new Array();
            $scope.academySelected = $scope.academy[$scope.user.dept].name;
            $scope.majorList = $scope.major[$scope.user.dept];
            $scope.majorSelected = $scope.majorList[0].name;
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.user.dept = item.code;
                $scope.majorList = $scope.major[item.code];
            }
            $scope.majorSelector = function (item) {
                $scope.majorSelected = item.name;
                $scope.user.major = item.code;
            }

            $scope.changePersonalMessage = function () {
                $http.post("/user/userChange", $scope.user)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
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
                <li><a href="./courseDisplayByLab.jsp">按实验室查看课表</a></li>
                <li class="active"><a href="./studentPersonalMessage.jsp">个人信息管理</a></li>
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
<div class="container">
    <div class="page-header">
        <h1>个人信息管理</h1>
    </div>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="inputRealnameReg" class="col-sm-2 control-label col-sm-offset-1">姓名</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="inputRealnameReg" placeholder="姓名" ng-model="user.realName" value="user.realName">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label col-sm-offset-1" for="dept">所属学院</label>

            <div class="controls col-sm-6">
                <div class="btn-group open choice" id="dept">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">{{academySelected}} <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li ng-repeat="item in academy">
                                <a ng-click="academySelector(item)">{{item.name}}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="inputMajorReg" class="col-sm-2 control-label col-sm-offset-1">所在专业</label>
            <div class="controls col-sm-6">
                <div class="btn-group open choice" id="inputMajorReg">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">{{majorSelected}} <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li ng-repeat="item in majorList">
                                <a ng-click="majorSelector(item)">{{item.name}}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="inputClassReg" class="col-sm-2 control-label col-sm-offset-1">所在（教授）班级</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="inputClassReg" placeholder="班级" ng-model="user.classes">
            </div>
        </div>

        <div class="well">
            <div class="row">
                <div class="col-sm-2 col-sm-offset-3">
                    <button type="button" class="btn btn-success" ng-click="changePersonalMessage()">修改我的个人信息</button>
                </div>
                <div class="col-sm-6">
                    <button type="button" class="btn btn-default">取消</button>
                </div>
            </div>
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

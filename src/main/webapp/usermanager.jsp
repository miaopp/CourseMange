<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/13
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="userManagerModule" ng-controller="userManagerCtrl">
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
        var app = angular.module('userManagerModule', ['ui.bootstrap']);
        app.controller("userManagerCtrl", function ($scope, $http) {
            $scope.userIsEmpty = true;
            $scope.UserLoad = {dept: <%=session.getAttribute("userdept")%>};
            $http.post("/user/loadUser", $scope.UserLoad)
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.user = response.data;
                            if($scope.user.length > 0) {
                                $scope.userIsEmpty = false;
                            }
                            else {
                                $scope.userIsEmpty = true;
                            }
                        }
                    })
            $scope.userDel = {userId: -1};
            $scope.userDeletor = function (userId) {
                $scope.userDel.userId = userId;
                $http.post("/user/userDelete", $scope.userDel)
                        .success(function (resopnse) {
                            if(200 == resopnse.status) {
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
                <li><a href="./manager.jsp">首页</a></li>
                <li><a href="./labmanager.jsp">实验室管理</a></li>
                <li class="active"><a href="./usermanager.jsp">用户信息管理</a></li>
                <li><a href="./managerPersonalMessage.jsp">个人信息管理</a></li>
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
        <h1>用户信息管理</h1>
    </div>

    <div class="row">
        <div class="col-sm-3 col-sm-offset-1" ng-repeat="item in user">
            <div class="media">
                <div class="media-body">
                    <h4 class="media-heading">{{item.userName}}</h4>
                    <div>
                        <h5>真实姓名：{{item.realName}}</h5>
                        <h5>所在学院：{{item.dept}}</h5>
                        <h5>所在专业：{{item.major}}</h5>
                        <h5>用户身份：{{item.userPower}}</h5>

                        <%--<button type="button" class="btn btn-primary pull-right" ng-show="{{item.status}}==1?true:false" ng-click="setUserAsManager(item.userId)">设为管理员</button>--%>
                    </div>
                </div>
                <div class="media-right">
                    <button type='button' class='btn btn-danger' ng-click="userDeletor(item.userId)">删除</button>
                </div>
            </div>
        </div>
    </div>

    <div class="well" ng-show="userIsEmpty">
        <p class='text-info'>目前还没有相关用户信息！</p>
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
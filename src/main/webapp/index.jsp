<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="StudentModule" ng-controller="StudentCtrl">
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
    <script type="text/javascript" src="./js/ui-bootstrap-0.12.1.js"></script>
    <script type="text/javascript">
        var app = angular.module('StudentModule', ['ui.bootstrap']);
        app.controller("StudentCtrl", function ($scope, $http) {
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
                <li class="active"><a href="./index.jsp">首页</a></li>
                <li><a href="#">查看课程表</a></li>
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
<div class="container">
        <div class="page-header">
            <h1>欢迎登录实验室排课系统</h1>
        </div>

    <div class="row-fluid">
        <div class="btnsty" style="height:70px;">
            <div class="btn-group">
                <button class="btn">选择学院</button>
                <button class="btn dropdown-toggle" data-toggle="dropdown" style="height: 30px"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li><a href="#">计算机学院</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                </ul>
            </div>
            <div class="btn-group" style="  margin-left: 100px;">
                <button class="btn">选择实验室</button>
                <button class="btn dropdown-toggle" data-toggle="dropdown" style="height: 30px"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li><a href="#">5201</a></li>
                    <li><a href="#">6304</a></li>
                    <li><a href="#">6305</a></li>
                    <li><a href="#">6309</a></li>
                    <li><a href="#">6310</a></li>
                    <li><a href="#">6311</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                </ul>
            </div>
            <div class="btn-group" style="  margin-left: 100px;">
                <button class="btn">选择查看方式</button>
                <button class="btn dropdown-toggle" data-toggle="dropdown" style="height: 30px"><span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li><a href="#">5201</a></li>
                    <li><a href="#">6304</a></li>
                    <li><a href="#">6305</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                </ul>
            </div>
            <div class="btn-group" style=" margin-left: 100px;">
                <button type="button" class="btn btn-success">确认查看课表</button>
            </div>
        </div>
        <table class="table table-hover">
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
            <tr>
                <td>1-2</td>
                <td>Mark</td>
                <td>Otto</td>
                <td>@mdo</td>
                <td>Mark</td>
                <td>Otto</td>
                <td>@mdo</td>
                <td>@mdo</td>
            </tr>
            <tr>
                <td>3-4</td>
                <td>Mark</td>
                <td>Otto</td>
                <td>@TwBootstrap</td>
                <td>Mark</td>
                <td>Otto</td>
                <td>@TwBootstrap</td>
                <td>@TwBootstrap</td>
            </tr>
            <tr>
                <td>5-6</td>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
                <td>@fat</td>
            </tr>
            <tr>
                <td>7-8</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>@twitter</td>
            </tr>
            <tr>
                <td>9-11</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>Larry the Bird</td>
                <td>@twitter</td>
                <td>@twitter</td>
            </tr>
            </tbody>
        </table>
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

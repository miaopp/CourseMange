<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html ng-app="loginModule" ng-controller="loginCtrl">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- css-->
    <link href="./css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="./css/mystyle.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .nav, .pagination, .carousel, .panel-title a {
            cursor: pointer;
        }
        body{
            background-color: #444 !important;
        }
        #regModal
        {
            font-family: "微软雅黑"
        }
        .divide-width
        {
            margin-left:20px;
        }
    </style>
    <!-- JavaScripts-->
    <script type="text/javascript" src="./js/jquery-2.1.3.js"></script>
    <script type="text/javascript" src="./js/bootstrap.js"></script>
    <script type="text/javascript" src="./js/angular.js"></script>
    <script type="text/javascript" src="./js/ui-bootstrap-0.12.1.js"></script>
    <script type="text/javascript">
        var app = angular.module('loginModule', ['ui.bootstrap']);
        app.controller("loginCtrl", function ($scope, $http) {
            $scope.userLogin = {"username": "", "password": ""};
            $scope.userRegister = {username: "", password: "", realName: "", dept: 0, major: 0, classes: "", power: 0};
            $scope.academy = [{code: 0, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件工程学院"}];
            $scope.major = [
                [],
                [{code: 101, name: "计算机科学与技术"}, {code: 102, name: "数字媒体"}],
                [{code: 201, name: "软件工程"}]
            ];
            $scope.majorList = new Array();
            $scope.login = function () {
                $http.post("/user/login", $scope.userLogin)
                        .success(function (response) {
                            if (200 == response.status) {
                                location.href = response.data;
                            }
                        })
            };

            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.userRegister.dept = item.code;
                $scope.majorList = $scope.major[item.code];
            };

            $scope.majorSelected = "未选择";
            $scope.majorSelector = function (item) {
                $scope.majorSelected = item.name;
                $scope.userRegister.major = item.code;
            };

            $scope.register = function () {
                $http.post("/user/register", $scope.userRegister)
                        .success(function (response) {
                            if (200 == response.status) {
                                location.href = response.data;
                            }
                        })
            }
        });
    </script>
</head>
<body>
<div class="container">
    <div class="well login-dialog" style="background-color:#fff; box-shadow: -10px 10px 8px #000;">
        <div class="header">
            <center>
                <h2>实验室排课管理登录</h2>
            </center>
            <hr>
            </hr>
        </div>
        <div class="form-horizontal">
            <div class="form-group ">
                <div class="input-group col-sm-8 col-sm-offset-2">
                    <div class="input-group-addon" style="border-left:5px solid green"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></div>
                    <input type="text" class="form-control input-size" id="inputUsername" placeholder="Username" ng-model="userLogin.username">
                </div>
            </div>

            <div class="form-group ">
                <div class="input-group col-sm-8 col-sm-offset-2">
                    <div class="input-group-addon" style="border-left:5px solid green"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span></div>
                    <input type="password" class="form-control" id="inputPassword" placeholder="Password" ng-model="userLogin.password">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-2" style="margin-left:60px;padding-right:0px;width:40px;">
                    <input type="checkbox" class="form-control" style="width:15px;height:15px">
                </div>
                <div class="col-sm-4" style="padding-left:0px;font-family:微软雅黑">
                    <span >记住用户名</span>
                </div>
            </div>

            <div class="form-group">
                <div class=" col-sm-4" style="margin-left:250px;">
                    <button type="button" class="btn btn-success " ng-click="login()"><span style="font-family:微软雅黑">登录</span></button>
                    <button class="btn btn-primary" data-toggle="modal" data-target="#regModal"><span style="font-family:微软雅黑">注册</span></button>
                </div>
            </div>
        </div>
        <hr>
        </hr>
        <div class="clearfix"></div>
    </div>
</div>

<div id="regModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 id="registerModalLabel">注册</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputUsernameReg" class="col-sm-3 control-label col-sm-offset-1 flag-style">用户名</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputUsernameReg" placeholder="用户名" ng-model="userRegister.username">
                            <p class="help-block">请在此输入您的用户名（大小写敏感）。</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputPasswordReg" class="col-sm-3 control-label col-sm-offset-1 flag-style">密码</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="inputPasswordReg" placeholder="密码" ng-model="userRegister.password">
                            <p class="help-block">请在此输入您的密码（大小写敏感）。</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputRealnameReg" class="col-sm-3 control-label col-sm-offset-1 flag-style">姓名</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputRealnameReg" placeholder="姓名" ng-model="userRegister.realName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1 flag-style" for="dept">所属学院</label>

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
                        <label for="inputMajorReg" class="col-sm-3 control-label col-sm-offset-1 flag-style">所在专业</label>
                        <div class="controls col-sm-6">
                            <div class="btn-group open choice" id="inputMajorReg">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> {{majorSelected}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in majorList">
                                        <a ng-click="majorSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputClassReg" class="col-sm-3 control-label col-sm-offset-1 flag-style">所在（教授）班级</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="inputClassReg" placeholder="班级" ng-model="userRegister.classes">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1 flag-style" for="power">身份</label>

                        <div class="controls col-sm-6">
                            <div class="radio" id="power">
                                <label>
                                    <input type="radio" name="optionsRadios" id="optionsRadios1" value="0" checked ng-model="userRegister.power">
                                    学生
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="optionsRadios" id="optionsRadios2" value="1" ng-model="userRegister.power">
                                    老师
                                </label>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="modal-footer">
                        <div class="alert alert-info hide">
                        </div>
                        <button type="button" class="btn btn-success" ng-click="register()">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
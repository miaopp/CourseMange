<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2015/4/11
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="labManagerModule" ng-controller="labManagerCtrl">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- css-->
    <link href="./css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="./css/mystyle.css" rel="stylesheet" type="text/css"/>
    <!-- Timeline CSS -->
    <link href="./css/timeline.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="./css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Custom CSS -->
    <link href="./css/sb-admin-2.css" rel="stylesheet">
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
        var app = angular.module('labManagerModule', ['ui.bootstrap']);
        app.controller("labManagerCtrl", function($scope , $http) {
            $scope.labIsEmpty = true;
            $scope.labIsNotEmpty = false;
            $scope.LabLoad = {labDept: <%=session.getAttribute("userdept")%>};
            $http.post("/lab/loadLab", $scope.LabLoad)
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.lab = response.data;
                            if($scope.lab.length > 0) {
                                $scope.labIsEmpty = false;
                                $scope.labIsNotEmpty = true;
                            }
                            else {
                                $scope.labIsEmpty = true;
                                $scope.labIsNotEmpty = false;
                            }
                        }
                    })
            $scope.LabModify = {id:-1, labName: "", labDept: -1, labAddress: ""};
            $scope.modifyLab = function (id) {
                $http.post("/lab/getModifyLab?id="+id)
                        .success(function (response) {
                            if(200 == response.status) {
                                $scope.LabModify = response.data;
                                $scope.modifyAcademySelect = $scope.academy[$scope.LabModify.labDept].name;
                            }
                        })
            }
            $scope.academy = [{code: -1, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件学院"}];
            $scope.modifyAcademySelect = "未选择";
            $scope.modifyAcademySelector = function (item) {
                $scope.modifyAcademySelect = item.name;
                $scope.LabModify.labDept = item.code;
            }

            $scope.LabAdd = {labName:"", labDept:-1, labAddress:""};
            $scope.LabAddAlert = {labName:false, labDept:false, labAddress:false};
            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.LabAdd.labDept = item.code;
            };

            $scope.labInsert = function () {
                $scope.LabAddAlert.labName = $scope.LabAdd.labName.length < 3;
                $scope.LabAddAlert.labDept = $scope.LabAdd.labDept == -1;
                $scope.LabAddAlert.labAddress = $scope.LabAdd.labAddress.length < 4;
                if (!$scope.LabAddAlert.labName&&!$scope.LabAddAlert.labDept&&!$scope.LabAddAlert.labAddress) {
                    $http.post("/lab/insertLabMessage", $scope.LabAdd)
                            .success(function (response) {
                                if(200 == response.status) {
                                    location.reload();
                                }
                            });
                }
            };

            $scope.Deletor = function (id) {
                $http.post("/lab/labDelete?id=" + id)
                        .success(function (response) {
                            if (200 == response.status) {
                                location.reload();
                            }
                        });
            };

            $scope.logout = function () {
                $http.get("/user/logout")
                        .success(function () {
                            location.href = "./login.jsp";
                        })
            };

            $scope.panelColor = function (idx) {
                switch (idx % 4) {
                    case 0: return "panel-primary";
                    case 1: return "panel-green";
                    case 2: return "panel-yellow";
                    case 3: return "panel-red";
                }
            }
        });
    </script>
</head>
<!-- Modal -->
<div id="LabModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 id="addModalLabel">添加实验室信息</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputlabName" class="col-sm-3 control-label col-sm-offset-1">实验室名称</label>
                        <div class="col-sm-5 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputlabName" placeholder="实验室名称" ng-model="LabAdd.labName" tooltip="实验室的名称，如：6301" tooltip-trigger="focus" tooltip-placement="top">
                            <div class="alert alert-danger" role="alert" ng-show="LabAddAlert.labName">实验室名称不能少于3个字符哦</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseDept" class="col-sm-3 control-label col-sm-offset-1">实验室所属学院</label>
                        <div class="controls col-sm-5 col-sm-offset-1">
                            <div class="btn-group open choice" id="inputCourseDept">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> {{academySelected}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in academy">
                                        <a ng-click="academySelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="alert alert-danger" role="alert" ng-show="LabAddAlert.labDept">未选择实验室所属学院</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputLabAddress" class="col-sm-3 control-label col-sm-offset-1">实验室地点</label>
                        <div class="col-sm-5 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputLabAddress" placeholder="实验室地点" ng-model="LabAdd.labAddress" tooltip="如：六教三楼最边边上，6301" tooltip-trigger="focus" tooltip-placement="bottom">
                            <div class="alert alert-danger" role="alert" ng-show="LabAddAlert.labAddress">实验室地点不能少于5个字符哦</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="alert alert-info hide">
                </div>
                <button class="btn btn-success" ng-click="labInsert()">提交</button>
            </div>
        </div>
    </div>
</div>
<div id="ModifyModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="ModifyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 id="ModifyModalLabel"><i class="fa fa-credit-card"></i>实验室信息</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="labName" class="col-sm-3 control-label col-sm-offset-1">实验室名称</label>
                        <div class="col-sm-5 col-sm-offset-1">
                            <input type="text" class="form-control" id="labName" value="LabModify.labName" ng-model="LabModify.labName" tooltip="实验室的名称，如：6301" tooltip-trigger="focus" tooltip-placement="top">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="modifyLabDept" class="col-sm-3 control-label col-sm-offset-1">实验室所属学院</label>
                        <div class="controls col-sm-5 col-sm-offset-1">
                            <div class="btn-group open choice" id="modifyLabDept">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"> {{modifyAcademySelected}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in academy">
                                        <a ng-click="modifyAcademySelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="modifyLabAddress" class="col-sm-3 control-label col-sm-offset-1">实验室地点</label>
                        <div class="col-sm-5 col-sm-offset-1">
                            <input type="text" class="form-control" id="modifyLabAddress" value="LabModify.labAddress" ng-model="LabModify.labAddress" tooltip="如：六教三楼最边边上，6301" tooltip-trigger="focus" tooltip-placement="bottom">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="alert alert-info hide">
                </div>
                <button class="btn btn-success" ng-click="modifyMessage()">保存信息</button>
            </div>
        </div>
    </div>
</div>
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
                <li class="active"><a href="./labmanager.jsp">实验室管理</a></li>
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

<body background="./img/bg.png" class="mybodystyle">
<div class="container">
    <div class="page-header">
        <h1>实验室管理</h1>
    </div>

    <div class="row" ng-if="!labIsEmpty">
        <div  ng-repeat="item in lab">

            <div class="col-lg-3 col-md-6">
                <div class="panel" ng-class="panelColor($index)">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-tasks fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <h2>{{item.labName}}</h2>
                            </div>
                        </div>
                    </div>
                    <a>
                        <div class="panel-footer">
                            <span class="pull-left">
                                <h5>所在学院：{{item.labDept}}</h5>
                                <h5>实验室地址：{{item.labAddress}}</h5></span>
                            <span class="pull-right"><button type="button" data-toggle="modal" data-target="#ModifyModal" ng-click="modifyLab(item.id)"><i class="fa fa-arrow-circle-right"></i></button></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>


    <div class="panel panel-default"  ng-if="labIsEmpty">
        <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> 提醒
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
            <ul class="timeline">
                <li>
                    <div class="timeline-badge success"><i class="fa fa-graduation-cap"></i></div>
                    <div class="timeline-panel">
                        <p>目前没有未处理消息！</p>
                        <div>
                            <a href="#" class="btn btn-link" role="button" data-toggle="modal" data-target="#LabModal">添加实验室信息</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="well" ng-if="!labIsEmpty">
        <div class="btn-group">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#LabModal">添加实验室信息</button>
        </div>
    </div>
    <%--<div class='well'>--%>
        <%--<p class='text-info'   ng-show="labIsEmpty">目前还没有相关实验室信息，请添加！</p>--%>

        <%--<div class='btn-group'>--%>
            <%--<button type='button' class='btn btn-success' data-toggle="modal" data-target="#LabModal">添加实验室信息</button>--%>
        <%--</div>--%>
    <%--</div>--%>

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

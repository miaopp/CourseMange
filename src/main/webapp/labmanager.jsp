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
            $http.get("/lab/loadLab")
                    .success(function (response) {
                        if(200 == response.status) {
                            $scope.lab = response.data;
                            if($scope.lab.length > 0) {
                                $scope.labIsEmpty = false;
                            }
                            else {
                                $scope.labIsEmpty = true;
                            }
                        }
                    });
            $scope.LabAdd = {labName:"", labDept:"", labAddress:""};
            $scope.academy = [{code: -1, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件学院"}];
            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.LabAdd.labDept = item.code;
            }

            $scope.labInsert = function () {
                $http.post("/lab/insertLabMessage", $scope.LabAdd)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
            }

            $scope.LabDe = {id: -1};
            $scope.Deletor = function (id) {
                $scope.LabDe.id = id;
                $http.post("/lab/labDelete", $scope.LabDe)
                        .success(function (response) {
                            if(200 == response.status) {
                                location.reload();
                            }
                        })
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
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputlabName" placeholder="实验室名称" ng-model="LabAdd.labName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseDept" class="col-sm-3 control-label col-sm-offset-1">实验室所属学院</label>
                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="inputCourseDept">
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
                        <label for="inputLabAddress" class="col-sm-3 control-label col-sm-offset-1">实验室地点</label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputLabAddress" placeholder="实验室地点" ng-model="LabAdd.labAddress">
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
<body>
<div class="container">
    <div class="page-header">
        <h1>实验室管理</h1>
    </div>

    <div class="row">
        <div class="col-sm-3" ng-repeat="item in lab">
            <div class="thumbnail">
                <img data-src="holder.js/100%x200" alt="100%x200"
                     src="#"
                     data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">
                <div class="caption">
                    <h4>实验室名称：{{item.labName}}</h4>
                    <h5>实验室地址：{{item.labAddress}}</h5>
                    <button type='button' class='btn btn-danger' ng-click="Deletor(item.id)">删除</button>
                </div>
            </div>
        </div>
    </div>

    <div class='well'>
        <p class='text-info' ng-show="courseIsEmpty">目前还没有相关实验室信息，请添加！</p>

        <div class='btn-group'>
            <button type='button' class='btn btn-success' data-toggle="modal" data-target="#LabModal">添加实验室信息</button>
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
</div>
</body>
</html>

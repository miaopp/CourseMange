<%@ page import="com.mpp.model.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html ng-app="courseManagerModule" ng-controller="courseManagerCtrl">
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
        var app = angular.module('courseManagerModule', ['ui.bootstrap']);
        app.controller("courseManagerCtrl", function ($scope, $http) {
            $scope.user = {name: "<%=((User)session.getAttribute("user")).getRealName()%>", uid: <%=session.getAttribute("uid") %>};
            $scope.courseIsEmpty = true;
            $scope.academyLabs;
            $http.get("/course/loadCourse")
                    .success(function (response) {
                        if (200 == response.status) {
                            $scope.course = response.data;
                            for (idx in $scope.course) {
                                $scope.course[idx].apply = new Array();
                            }
                            if ($scope.course.length > 0) {
                                $scope.courseIsEmpty = false;
                            } else {
                                $scope.courseIsEmpty = true;
                            }
                        }
                    });

            $http.post("/apply/loadAll")
                    .success(function (response) {
                        if (200 == response.status) {
                            for (val in response.data) {
                                var apply = response.data[val];
                                for (idx in $scope.course) {
                                    if ($scope.course[idx].id == apply.labId) {
                                        $scope.course[idx].apply.push(apply);
                                    }
                                }
                            }
                        }
                    })

            $scope.apply = {courseId: -1, labId: -1, userId: $scope.user.uid, dayOfWeek: 0, orders: -1};
            $http.post("/lab/getLabListByTeacher")
                    .success(function (response) {
                        if (200 == response.status) {
                            $scope.academyLabs = response.data;
                        }
                    });
            $scope.courseLabSelect = "未选择";
            $scope.courseLabSelector = function (item) {
                $scope.courseLabSelect = item.labName;
                $scope.apply.labId = item.id;
            };

            $scope.weeks = [
                {name: "星期一", code: 1},
                {name: "星期二", code: 2},
                {name: "星期三", code: 3},
                {name: "星期四", code: 4},
                {name: "星期五", code: 5},
                {name: "星期六", code: 6},
                {name: "星期天", code: 7}
            ];
            $scope.courseWeekSelect = "未选择";
            $scope.courseWeekSelector = function (item) {
                $scope.courseWeekSelect = item.name;
                $scope.apply.dayOfWeek = item.code;

                loadCourseApplyOrders();
            };
            $scope.orders = [{name: "待载入", code: -1}];
            $scope.courseOrderSelect = "待载入";
            $scope.courseOrderSelector = function (item) {
                $scope.courseOrderSelect = item.name;
                $scope.apply.orders = item.code;
            };

            var loadCourseApplyOrders = function () {
                var json = {labId: $scope.apply.labId ,dayOfWeek: $scope.apply.dayOfWeek, beginWeek: 1,endWeek: 2};
                $http.post("/schedule/availableOrders", json)
                        .success(function (response) {
                            if (response.status == 200) {
                                $scope.orders = response.data;
                                $scope.courseOrderSelect = "未选择";
                            }
                        });
            };

            $scope.addApply = function () {
                $http.post("/apply/addApply", $scope.apply)
                        .success(function (response) {
                            if (200 == response.status) {
                                location.reload();
                            }
                        })
            };

            $scope.courseAdd = {userId: <%=session.getAttribute("uid") %>, name: "", courseDept: "", courseMajor: "", targetClass: "", courseBeginWeek: "", courseEndWeek: ""};
            $scope.academy = [{code: -1, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件学院"}];
            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.courseAdd.courseDept = item.code;
            };

            $scope.courseInsert = function () {
                $http.post("/course/insertCourseMessage", $scope.courseAdd)
                        .success(function (response) {
                            if (200 == response.status) {
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

<!-- Modal -->
<div id="CourseModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 id="addModalLabel">添加课程信息</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputCourseName" class="col-sm-3 control-label col-sm-offset-1">课程名称</label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputCourseName" placeholder="课程名称" ng-model="courseAdd.name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseDept" class="col-sm-3 control-label col-sm-offset-1">课程开设学院</label>
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
                        <label for="inputCourseMajor" class="col-sm-3 control-label col-sm-offset-1">课程开设专业</label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputCourseMajor" placeholder="课程开设专业" ng-model="courseAdd.courseMajor">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseClass" class="col-sm-3 control-label col-sm-offset-1">课程开设班级</label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputCourseClass" placeholder="课程开设班级" ng-model="courseAdd.targetClass">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseBeginWeek" class="col-sm-3 control-label col-sm-offset-1">上课起始周 </label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputCourseBeginWeek" placeholder="上课起始周" ng-model="courseAdd.courseBeginWeek">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseEndWeek" class="col-sm-3 control-label col-sm-offset-1">上课结束周 </label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <input type="text" class="form-control" id="inputCourseEndWeek" placeholder="上课结束周" ng-model="courseAdd.courseEndWeek">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="alert alert-info hide">
                </div>
                <button class="btn btn-success" ng-click="courseInsert()">提交</button>
            </div>
        </div>
    </div>
</div>

<div id="ApplyModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="applyModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h3 id="applyModalLabel">实验室申请</h3>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="labName">实验室名称</label>

                        <div class="controls col-sm-6">
                            <div class="btn-group open choice" id="labName">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseLabSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in academyLabs">
                                        <a ng-click="courseLabSelector(item)">{{item.labName}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="weeks">星期</label>

                        <div class="controls col-sm-6">
                            <div class="btn-group open choice" id="weeks">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseWeekSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in weeks">
                                        <a ng-click="courseWeekSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="orders">时间</label>

                        <div class="controls col-sm-6">
                            <div class="btn-group open choice" id="orders">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseOrderSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in orders">
                                        <a ng-click="courseOrderSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <div class="alert alert-info hide">
                </div>
                <button class="btn btn-success" ng-click="addApply()">提交</button>
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
                <li><a href="./teacher.jsp">首页</a></li>
                <li class="active"><a href="./coursemanager.jsp">课程信息管理</a></li>
                <li><a href="./courseDisplayToTeacher.jsp">查看实验室课程表</a></li>
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
<body>
<div class="container">
    <div class="page-header">
        <h1>课程信息管理</h1>
    </div>

    <div class="row">
        <div class="col-sm-3" ng-repeat="item in course">
            <div class="thumbnail">
                <img data-src="holder.js/100%x200" alt="100%x200"
                     src="#"
                     data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">

                <div class="caption">
                    <h4>课程名称：{{item.name}}</h4>
                    <h5>授课老师：{{user.name}}</h5>
                    <h5>课程开设专业：{{item.courseMajor}}</h5>
                    <h5>上课时间：第{{item.courseBeginWeek}}周 -- 第{{item.courseEndWeek}}周</h5>
                    <div class="well" ng-show="item.apply.length > 0">
                        <p class='text-info'>排课记录：</p>
                        <div ng-repeat="apply in item.apply">
                            <p class='text-info'>星期{{apply.dayOfWeek}}, 第{{apply.orders}}节课</p>
                        </div>

                    </div>
                    <button type='button' class='btn btn-primary' data-toggle="modal" data-target="#ApplyModal" ng:click="apply.courseId = item.id">
                        添加实验室排课
                    </button>
                    <button type='button' class='btn btn-danger pull-right'>删除</button>
                </div>
            </div>
        </div>
    </div>
    <div class='well'>
        <p class='text-info'  ng-show="courseIsEmpty">目前还没有相关课程信息，请添加！</p>

        <div class='btn-group'>
            <button type='button' class='btn btn-success' data-toggle="modal" data-target="#CourseModal">添加实验室信息</button>
        </div>
    </div>

    </p>
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


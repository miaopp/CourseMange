<%@ page import="com.mpp.model.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html ng-app="courseManagerModule" ng-controller="courseManagerCtrl">
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

                            $http.post("/apply/loadAll")
                                    .success(function (response) {
                                        if (200 == response.status) {
                                            for (val in response.data) {
                                                var apply = response.data[val];
                                                for (idx in $scope.course) {
                                                    if ($scope.course[idx].id == apply.courseId) {
                                                        $scope.course[idx].apply.push(apply);
                                                    }
                                                }
                                            }
                                        }
                                    });
                        }
                    });


            $scope.apply = {courseId: -1, labId: -1, userId: $scope.user.uid, dayOfWeek: 0, orders: -1};
            $scope.applyAlert = {labId: false, dayOfWeek: false, orders: false};
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
                if($scope.apply.dayOfWeek != 0){
                    loadOrder();
                }
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
                loadOrder();
            };

            var loadOrder = function () {
                $scope.applyAlert.labId = $scope.apply.labId == -1;
                $scope.applyAlert.dayOfWeek = $scope.apply.dayOfWeek == 0;

                if (!$scope.applyAlert.labId&&!$scope.applyAlert.dayOfWeek) {
                    $scope.toLoadOrders.labId = $scope.apply.labId;
                    $scope.toLoadOrders.dayOfWeek = $scope.apply.dayOfWeek;
                    $http.post("/schedule/availableOrders", $scope.toLoadOrders)
                            .success(function (response) {
                                if (response.status == 200) {
                                    $scope.orders = response.data;
                                    $scope.courseOrderSelect = "未选择";
                                }
                            });
                }
            };
            $scope.orders = [{name: "待载入", code: -1}];
            $scope.courseOrderSelect = "待载入";
            $scope.courseOrderSelector = function (item) {
                $scope.courseOrderSelect = item.name;
                $scope.apply.orders = item.code;
            };

            $scope.toLoadOrders = {labId: -1 ,dayOfWeek: 0, beginWeek: 0,endWeek: 0};

            $scope.clickAddApplyOrderBtn = function (item) {
                $scope.apply.courseId = item.id;
                $scope.toLoadOrders.beginWeek = item.courseBeginWeek;
                $scope.toLoadOrders.endWeek = item.courseEndWeek;
            };

            $scope.addApply = function () {
                $scope.applyAlert.labId = $scope.apply.labId == -1;
                $scope.applyAlert.dayOfWeek = $scope.apply.dayOfWeek == 0;
                $scope.applyAlert.orders = $scope.apply.orders == -1;
                if (!$scope.applyAlert.labId&&!$scope.applyAlert.dayOfWeek&&!$scope.applyAlert.orders) {
                    $http.post("/apply/addApply", $scope.apply)
                            .success(function (response) {
                                if (200 == response.status) {
                                    location.reload();
                                }
                            })
                }
            };

            $scope.courseAdd = {userId: <%=session.getAttribute("uid") %>, name: "", courseDept: -1, courseMajor: 0, targetClass: "", courseBeginWeek: "", courseEndWeek: ""};

            $scope.major = [
                [],
                [{code: 101, name: "计算机科学与技术"}, {code: 102, name: "数字媒体"}],
                [{code: 201, name: "软件工程"}]
            ];
            $scope.majorList = new Array();
            $scope.majorSelected = "未选择";
            $scope.majorSelector = function (item) {
                $scope.majorSelected = item.name;
                $scope.courseAdd.courseMajor = item.code;
            };
            $scope.academy = [{code: -1, name: "未选择"}, {code: 1, name: "计算机学院"}, {code: 2, name: "软件学院"}];
            $scope.academySelected = "未选择";
            $scope.academySelector = function (item) {
                $scope.academySelected = item.name;
                $scope.courseAdd.courseDept = item.code;
                $scope.majorList = $scope.major[item.code];
            };

            $scope.courseInsert = function () {
                $http.post("/course/insertCourseMessage", $scope.courseAdd)
                        .success(function (response) {
                            if (200 == response.status) {
                                location.reload();
                            }
                        })
            };

            $scope.delCourse = function (item) {
                $http.post("/course/delCourse?courseId="+item.id)
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
                            <input type="text" class="form-control" id="inputCourseName" placeholder="课程名称" ng-model="courseAdd.name" tooltip="课程全名" tooltip-trigger="focus" tooltip-placement="right">
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
                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="inputCourseMajor">
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
                        <label for="inputCourseClass" class="col-sm-3 control-label col-sm-offset-1">课程开设班级</label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <div class="input-group">
                                <span class="input-group-addon">第</span>
                                <input type="text" class="form-control" id="inputCourseClass" placeholder="课程开设班级" ng-model="courseAdd.targetClass" tooltip="只能填数字" tooltip-trigger="focus" tooltip-placement="right">
                                <span class="input-group-addon">班</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseBeginWeek" class="col-sm-3 control-label col-sm-offset-1">上课起始周 </label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <div class="input-group">
                                <span class="input-group-addon">第</span>
                                <input type="text" class="form-control" id="inputCourseBeginWeek" placeholder="上课起始周" ng-model="courseAdd.courseBeginWeek" tooltip="只能填数字" tooltip-trigger="focus" tooltip-placement="right">
                                <span class="input-group-addon">周</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCourseEndWeek" class="col-sm-3 control-label col-sm-offset-1">上课结束周 </label>
                        <div class="col-sm-4 col-sm-offset-1">
                            <div class="input-group">
                                <span class="input-group-addon">第</span>
                                <input type="text" class="form-control" id="inputCourseEndWeek" placeholder="上课结束周" ng-model="courseAdd.courseEndWeek" tooltip="只能填数字" tooltip-trigger="focus" tooltip-placement="right">
                                <span class="input-group-addon">周</span>
                            </div>
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

                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="labName">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseLabSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in academyLabs">
                                        <a ng-click="courseLabSelector(item)">{{item.labName}}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="alert alert-danger" role="alert" ng-show="applyAlert.labId">未选择实验室</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="weeks">星期</label>

                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="weeks">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseWeekSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in weeks">
                                        <a ng-click="courseWeekSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="alert alert-danger" role="alert" ng-show="applyAlert.dayOfWeek">未选择星期</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label col-sm-offset-1" for="orders">时间</label>

                        <div class="controls col-sm-4 col-sm-offset-1">
                            <div class="btn-group open choice" id="orders">
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    {{courseOrderSelect}}<span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li ng-repeat="item in orders">
                                        <a ng-click="courseOrderSelector(item)">{{item.name}}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="alert alert-danger" role="alert" ng-show="applyAlert.orders">未选择第几节上课</div>
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
                <li><a href="./teacherPersonalMessage.jsp">个人信息管理</a></li>
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
        <h1>课程信息管理</h1>
    </div>

    <div class="row">
        <div class="col-sm-3" ng-repeat="item in course">
            <div class="thumbnail">
                <%--<img data-src="holder.js/100%x200" alt="100%x200"--%>
                     <%--src="#"--%>
                     <%--data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">--%>

                <div class="caption">
                    <button type="button" class="close" tooltip="删除课程" tooltip-placement="top" ng-click="delCourse(item)"><span aria-hidden="true">&times;</span></button>
                    <h4>课程名称：{{item.name}}</h4>
                    <h5>授课老师：{{user.name}}</h5>
                    <h5>课程开设专业：{{item.courseMajor}}</h5>
                    <h5>上课班级：{{item.targetClass}}班</h5>
                    <h5>上课时间：第{{item.courseBeginWeek}}周 -- 第{{item.courseEndWeek}}周</h5>
                    <div class="callout callout-info" ng-show="item.apply.length > 0">
                        <p class='text-info'>已排课记录：<span class="badge">共{{item.apply.length}}条</span></p>
                        <div ng-repeat="apply in item.apply">
                            <p class='bg-info'>{{apply.labName}}, 星期{{apply.dayOfWeek}}, 第{{apply.orders}}节课</p>
                        </div>

                    </div>
                    <button type='button' class='btn btn-primary' data-toggle="modal" data-target="#ApplyModal" ng-click="clickAddApplyOrderBtn(item)">
                        添加实验室排课
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-danger">
        <div class="panel-heading" ng-show="courseIsEmpty">
            <h3 class="panel-title" id="panel-title">提醒<a class="anchorjs-link" href="#panel-title"><span class="anchorjs-icon"></span></a></h3>
        </div>
        <div class="panel-body" ng-show="courseIsEmpty">
            目前还没有相关课程信息，请添加！
        </div>
        <div class="panel-footer">
            <a href="#" class="btn btn-link" role="button" data-toggle="modal" data-target="#CourseModal">添加课程信息</a>
        </div>
    </div>
    <%--<div class='well'>--%>
        <%--<p class='text-info'  ng-show="courseIsEmpty">目前还没有相关课程信息，请添加！</p>--%>

        <%--<div class='btn-group'>--%>
            <%--<button type='button' class='btn btn-success' data-toggle="modal" data-target="#CourseModal">添加实验室信息</button>--%>
        <%--</div>--%>
    <%--</div>--%>

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


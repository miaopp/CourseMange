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
            $http.get("/user/loadUser")
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

            $scope.userDeletor = function () {

            }
        });

//        function loadUser() {
//            $.get("/user/loadUser", function(data) {
//                var list = data.data;
//                var str = "";
//                str+="<div class='row-fluid'>";
//                str+="  <ul class='thumbnails'>";
//                for(var i = 0; i < list.length; i++) {
//                    if(list[i].power != 2) {
//                        str += "      <li class='span4' style='margin-left: 1%;'>";
//                        str += "          <div class='thumbnail'>";
//                        str += "              <img data-src='holder.js/300x200' alt='300x200' src='#' style='width: 300px; height: 200px;'>";
//                        str += "              <div class='caption'>";
//                        str += "                  <h4>用户名：" + list[i].username + "</h4>";
//                        str += "                  <h5>真实姓名：" + list[i].realName + "</h5>";
//                        str += "                  <h5>所在学院：" + list[i].dept + "</h5>";
//                        str += "                  <h5>所在专业：" + list[i].major + "</h5>";
//                        if(list[i].power == 0) {
//                            str += "                  <h5>身份：学生</h5>";
//                        }
//                        else {
//                            str += "                  <h5>身份：老师</h5>";
//                        }
//                        str += "                  <p><button type='button' class='btn btn-large btn-primary disabled user_del' val='" + list[i].userId + "' >删除</button></p>";
//                        str += "              </div>";
//                        str += "          </div>";
//                        str += "      </li>";
//                    }
//                }
//                $("#showUser").html(str);
//            });
//        }
//
//        function deleteUserBean(userId) {
//            this.userId = userId;
//        }
//
//        $(function () {
//            loadUser();
//            $("#logout").click(function() {
//                $.get("/user/logout" , function() {
//                    location.href = "./login.jsp";
//                });
//            });
//
//            $(document).on("click", ".user_del", function() {
//                var userId = $(this).attr("val");
////                alert(userId);
//                var json = JSON.stringify(new deleteUserBean(userId));
//                $.ajax({
//                    type: "post",
//                    url: "/user/userDelete",
//                    data: json,
//                    contentType: 'application/json',
//                    dataType: 'json',
//                    success: function(data) {
//                        if(200 == data.status) {
//                            location.reload();
//                        }
//                    }
//                });
//            });
//        })
    </script>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1>用户信息管理</h1>
    </div>

    <div class="row">
        <div class="col-sm-3" ng-repeat="item in user">
            <div class="thumbnail">
                <img data-src="holder.js/100%x200" alt="100%x200"
                     src="#"
                     data-holder-rendered="true" style="height: 200px; width: 100%; display: block;">
                <div class="caption">
                    <h4>用户名：{{item.username}}</h4>
                    <h5>真实姓名：{{item.realName}}</h5>
                    <h5>所在专业：{{item.major}}</h5>

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
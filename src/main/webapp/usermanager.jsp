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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <link href="./css/mystyle.css" rel="stylesheet">
    <link href="./css/bootstrap.css" rel="stylesheet">
    <script src="./js/jquery-1.8.3.js"></script>
    <script src="./js/bootstrap.js"></script>
    <script src="./js/json2.js"></script>
    <script type="text/javascript">
        function loadUser() {
            $.get("/user/loadUser", function(data) {
                var list = data.data;
                var str = "";
                str+="<div class='row-fluid'>";
                str+="  <ul class='thumbnails'>";
                for(var i = 0; i < list.length; i++) {
                    if(list[i].power != 2) {
                        str += "      <li class='span4' style='margin-left: 1%;'>";
                        str += "          <div class='thumbnail'>";
                        str += "              <img data-src='holder.js/300x200' alt='300x200' src='#' style='width: 300px; height: 200px;'>";
                        str += "              <div class='caption'>";
                        str += "                  <h4>用户名：" + list[i].username + "</h4>";
                        str += "                  <h5>真实姓名：" + list[i].realName + "</h5>";
                        str += "                  <h5>所在学院：" + list[i].dept + "</h5>";
                        str += "                  <h5>所在专业：" + list[i].major + "</h5>";
                        if(list[i].power == 0) {
                            str += "                  <h5>身份：学生</h5>";
                        }
                        else {
                            str += "                  <h5>身份：老师</h5>";
                        }
                        str += "                  <p><button type='button' class='btn btn-large btn-primary disabled user_del' val='" + list[i].userId + "' >删除</button></p>";
                        str += "              </div>";
                        str += "          </div>";
                        str += "      </li>";
                    }
                }
                $("#showUser").html(str);
            });
        }

        function deleteUserBean(userId) {
            this.userId = userId;
        }

        $(function () {
            loadUser();
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
                });
            });

            $(document).on("click", ".user_del", function() {
                var userId = $(this).attr("val");
//                alert(userId);
                var json = JSON.stringify(new deleteUserBean(userId));
                $.ajax({
                    type: "post",
                    url: "/user/userDelete",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function(data) {
                        if(200 == data.status) {
                            location.reload();
                        }
                    }
                });
            });
        })
    </script>
</head>
<body>
<div class="navbar navbar-inverse" style="position: static;">
    <div class="navbar">
        <div class="navbar-inner">
            <div class="control_dos pull-right">
                <!-- Button to trigger modal -->
                <c:choose>
                    <c:when test="${sessionScope.user==null}">
                        <a href="#loginModal" role="button" class="btn btn-primary" data-toggle="modal">登录</a>
                        <a href="#regModal" role="button" class="btn btn-success" data-toggle="modal">新用户注册</a>
                    </c:when>
                    <c:otherwise>
                        <div class="control_dos pull-right">
                            <ul class="nav pull-right">
                                <li id="fat-menu" class="dropdown">
                                    <a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown"><i
                                            class="icon-user icon-white"></i>当前用户：<%=session.getAttribute("user") %> <b
                                            class="caret"></b></a>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
                                        <li role="presentation" class="divider"></li>
                                        <li role="presentation" id="logout"><a role="menuitem" tabindex="-1">退出</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="nav-collapse">
                <ul class="nav">
                    <li><a href="./manager.jsp">首页</a></li>
                    <li><a href="./labmanager.jsp">实验室管理</a></li>
                    <li><a href="#">实验室课程申请管理</a></li>
                    <li class="active"><a href="usermanager.jsp">用户信息管理</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="mycontianer">
    <div class="container">
        <div class="jumbotron">
            <div class="page-header">
                <h1>用户信息管理</h1>
            </div>

            <p class="p1" id="showUser">

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
    </div>
</div>
</body>
</html>
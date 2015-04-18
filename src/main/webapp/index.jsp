<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <link href="./css/mystyle.css" rel="stylesheet">
    <link href="./css/bootstrap.css" rel="stylesheet">
    <script src="./js/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="./js/bootstrapv2.js" type="text/javascript"></script>
    <script src="./js/json2.js" type="text/javascript"></script>
    <script src="./js/academy.js" type="text/javascript"></script>
    <script src="./js/public.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userid = <%=session.getAttribute("uid") %>;

        $(function () {
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
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
                                            class="icon-user icon-white"></i>当前用户：<%=session.getAttribute("username") %> <b
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
                    <li class="active"><a href="./index.jsp">首页</a></li>
                    <li><a href="#">查看课程表</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="mycontianer">
    <div class="container-fluid">
        <div class="jumbotron">
            <div class="page-header">
                <h1>欢迎登录实验室排课系统</h1>
            </div>

            <p class="lead" id="showNotice">

            </p>
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
</div>
</body>
</html>

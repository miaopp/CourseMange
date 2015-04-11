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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <link href="./css/mystyle.css" rel="stylesheet" type="text/css">
    <link href="./css/bootstrap.css" rel="stylesheet" type="text/css">
    <script src="./js/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="./js/bootstrap.js" type="text/javascript"></script>
    <script src="./js/json2.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loadLab() {
            $.get("/lab/loadLab", function(data) {
                var list = data.data;
                var str = "";
//                alert(list.length);
                if(parseInt(list.length) == parseInt(0)) {
                    str+="<div class='well'>";
                    str+="  <p class='text-info'>目前还没有相关实验室信息，请添加！</p>";
                    str+="  <div class='btn-group'>";
                    str+="      <a href='#LabModal' role='button' class='btn btn-success' data-toggle='modal'>添加实验室信息</a>";
                    str+="  </div>";
                    str+="</div>";
                }
                else {
                    str+="<div class='row-fluid'>";
                    str+="  <ul class='thumbnails'>";
                    for(var i = 0; i < list.length ; i++) {
                        str+="      <li class='span4'>";
                        str+="          <div class='thumbnail'>";
                        str+="              <img data-src='holder.js/300x200' alt='300x200' src='#' style='width: 300px; height: 200px;'>";
                        str+="              <div class='caption'>";
                        str+="                  <h3>"+list[i].labName+"</h3>";
                        str+="                  <h4>"+list[i].labAddress+"</h4>";
                        str+="                  <h4>"+list[i].labDept+"</h4>";
                        str+="              </div>";
                        str+="          </div>";
                        str+="      </li>";
                    }
                    str+="  </ul>";
                    str+="</div>";
                }
                $("#showLab").html(str);
            });
        }

        function labInsertBean(labName, labAddress, labDept) {
            this.labName = labName;
            this.labAddress = labAddress;
            this.labDept = labDept;
        }

        $(function () {
            loadLab();
            $("#logout").click(function() {
                $.get("/user/logout" , function() {
                    location.href = "./login.jsp";
                });
            });
            $("#labinsert").click(function() {
                var labName = $("#LabModal input[name='labname']").val();
                var labAddress = $("#LabModal input[name='labaddress']").val();
                var labDept = $("#LabModal input[name='labdept']").val();
                alert(labDept);
                var json = JSON.stringify(new labInsertBean(labName, labAddress, labDept));
                $.ajax({
                    type: "post",
                    url: "/lab/insertLabMessage",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if(200 == data.status) {
                            location.reload();
                        }
                        $("#LabModal .alert").removeClass("alert-info").addClass("alert-error");
                        $("#LabModal .alert").html("<p class='p1'>failed to Insert!</p>");
                    }
                });
            });
        });
    </script>
</head>
<!-- Modal -->
<div id="LabModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">添加实验室信息</h3>
    </div>
    <div class="modal-body">
        <form class="form-horizontal">
            <fieldset>
                <div class="control-group">
                    <label class="control-label" for="labname">实验室 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="labname" name="labname" placeholder="实验室">

                        <p class="help-block">请在此输入实验室名（大小写敏感）。</p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="labaddress">实验室地点 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="labaddress" name="labaddress" placeholder="实验室地点">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="labdept">所属学院 (必填)：</label>

                    <div class="controls">
                        <input type="text" class="input-xlarge" id="labdept" name="labdept" placeholder="所属学院">
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="modal-footer">
        <div class="alert alert-info hide">
        </div>
        <button class="btn btn-success" id="labinsert">提交</button>
    </div>
</div>
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
                    <li class="active"><a href="./labmanager.jsp">实验室管理</a></li>
                    <li><a href="#">实验室课程申请管理</a></li>
                    <li><a href="#">用户信息管理</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="mycontianer">
    <div class="container">
        <div class="jumbotron">
            <div class="page-header">
                <h1>实验室管理</h1>
            </div>
            <p class="p1" id="showLab">

            </p>
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

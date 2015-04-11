<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <link href="./css/mystyle.css" rel="stylesheet">
    <link href="./css/bootstrap.css" rel="stylesheet">
    <script src="./js/jquery-1.8.3.js"></script>
    <script src="./js/bootstrap.js"></script>
    <script src="./js/json2.js"></script>
    <script type="text/javascript">
        function loginBean(username, password) {
            this.username = username;
            this.password = password;
        }
        function registerBean(username, password, realName, dept, major, classes, power) {
            this.username = username;
            this.password = password;
            this.realName = realName;
            this.dept = dept;
            this.major = major;
            this.classes = classes;
            this.power = power;
        }
        $(function () {
            $("#login").click(function() {
                var username = $("#inputUsername").val();
                var password = $("#inputPassword").val();
                var json = JSON.stringify(new loginBean(username, password));
                $.ajax({
                    type: "post",
                    url: "/user/login",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if (200 == data.status) {
                            location.href = data.data;
                        }
                        else {
                            $("#loginModal .alert").removeClass("alert-info").addClass("alert-error");
                            $("#loginModal .alert").html("<p class='p1'>failed to Login!</p>");
                        }
                    },
                    error: function () {
                        alert("error");
                    }
                });
                return false;
            });
            $("#register").click(function() {
                var username = $("#regModal input[name='username']").val();
                var password = $("#regModal input[name='password']").val();
                var realName = $("#regModal input[name='realname']").val();
                var dept = $("#regModal input[name='dept']").val();
                var major = $("#regModal input[name='major']").val();
                var classes = $("#regModal input[name='class']").val();
                var power = $("input[type='radio']:checked").val();
                var json = JSON.stringify(new registerBean(username, password, realName, dept, major, classes, power));
                $.ajax({
                    type: "post",
                    url: "/user/register",
                    data: json,
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        if (200 == data.status) {
                            location.href = data.data;
                        }
                        else {
                            $("#regModal .alert").removeClass("alert-info").addClass("alert-error");
                            $("#regModal .alert").html("<p class='p1'>failed to Regist!</p>");
                        }
                    }
                });
                return false;
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div id="login-dialog">
        <div class="well login-body">
            <center>
                <div class="header">
                    <h3>账号密码登录</h3>
                    <hr>
                    </hr>
                </div>
            </center>
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="inputUsername">用户名</label>
                    <div class="controls">
                        <input type="text" id="inputUsername" name="username" placeholder="Username">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputPassword">密码</label>
                    <div class="controls">
                        <input type="password" id="inputPassword" name="password" placeholder="Password">
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <button type="submit" class="btn btn-success" id="login">登录</button>
                    </div>
                </div>
                <div class="control-group">
                    <div class="alert fade in hide">
                    </div>
                </div>
            </div>
            <hr>
            </hr>
            <div class="footer">
                <a href="#regModal" role="button" class="btn btn-link pull-right" data-toggle="modal">注册新账号</a>
            </div>
        </div>
    </div>

    <div id="regModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">Register</h3>
        </div>
        <div class="modal-body">
            <div class="form-horizontal">
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="username">用户名 (必填)：</label>

                        <div class="controls">
                            <input type="text" class="input-xlarge" id="username" name="username" placeholder="用户名">

                            <p class="help-block">请在此输入您的用户名（大小写敏感）。</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password">密码 (必填)：</label>

                        <div class="controls">
                            <input type="password" class="input-xlarge" id="password" name="password" placeholder="密码">

                            <p class="help-block">请在此输入您的密码（大小写敏感）。</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="realname">姓名 (必填)：</label>

                        <div class="controls">
                            <input type="text" class="input-xlarge" id="realname" name="realname" placeholder="姓名">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="dept">所在学院 (必填)：</label>

                        <div class="controls">
                            <input type="text" class="input-xlarge" id="dept" name="dept" placeholder="学院">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="realname">所在专业 (必填)：</label>

                        <div class="controls">
                            <input type="text" class="input-xlarge" id="major" name="major" placeholder="专业">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="realname">所在（教授）班级 (必填)：</label>

                        <div class="controls">
                            <input type="text" class="input-xlarge" id="class" name="class" placeholder="班级">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">身份(必选)：</label>

                        <div class="controls">
                            <label class="radio">
                                <input type="radio" name="option" value="0" checked>
                                学生
                            </label>
                            <label class="radio">
                                <input type="radio" name="option" value="1">
                                老师
                            </label>
                        </div>
                    </div>
                </fieldset>
                <br/>
                <div class="modal-footer">
                    <div class="alert alert-info hide">
                    </div>
                    <button type="button" id="register" class="btn btn-success">提交</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
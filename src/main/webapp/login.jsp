<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
    <title>登录</title>
    <!-- 动态导入js文件和css文件 -->
	<jsp:include page="common.jsp"></jsp:include>
	<style type="text/css">
		#container{
			width:736px;
			hight:414px;
			margin-left:150px;
			margin-top:450px;
		}
		body{
			background-image:url("/babyassistantfile/images/pageImgs/login.jpg");
			background-repeat:no-repeat;
			background-size:100% 1750px;
			background-attachment: fixed;
		}
	</style>
</head>
<body>
	<div>
	<form action="/babyassistant/doLogin" method="get" id="login_form">
		<div id="container" class="form-group has-success">
			<span style="color:#ffffff;font-size:70px;">宝宝助手</span>
			<div class="form-group has-success">
				<input id="username" class="form-control" type="text" name="username" placeholder="请输入账号"style="margin-top:50px;margin-bottom:20px;width:730px;height:90px;font-size:45px;" value="<shiro:principal/>" >
			</div>
			<div class="form-group has-success" >
				<input id="password" class="form-control" type="password" name="password"placeholder="请输入密码"style="margin-bottom:20px;width:730px;height:90px;font-size:45px;">
			</div>
			<div class="form-group has-success" style="margin-bottom:20px">
				<input type="checkbox" checked="checked" name="rememberMe" style="zoom:4;">
				<span style="font-size:50px;">记住我</span>
			</div>
			<div>	
				<input type="submit" class="btn btn-success" value="登录" style="margin-bottom:10px;width:730px;height:90px;font-size:50px">
			</div>
			<div>
				<input type="button" class="btn btn-link" value="忘记密码?" style="font-size:40px">
				<input type="button" class="btn btn-link" value="新用户注册" style="margin-left:285px;font-size:40px">
			</div>	
		</div>
	</form>
</div>
</body>
</html>

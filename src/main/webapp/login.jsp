<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title>登录</title>
<!-- 动态导入js文件和css文件 -->
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
body{
	background-image: url("images/bg01.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-attachment: fixed;
}
</style>
<script type="text/javascript">
$(function() {
	/* 
		垂直居中显示
	*/
	var h = $(window).height();
	//var h = document.documentElement.clientHeight || document.body.clientHeight;
	console.log("h = "+h);
	var height = $("#wrapper").css("height").replace("px","");
	console.log("height = "+height);
	$("#wrapper").css("margin-top",(h-parseInt(height))/2+"px");
	
	//获取url中的msg参数值
	var msg = getUrl("msg");
	console.log("msg = "+msg);
	if (msg != null) {
		if (msg == "loginFailed") {
			alert("账号或密码错误");
		}
	}

});

/* 获取请求地址url参数 */
function getUrl(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
</script>
</head>
<body>
<div class="container">
	<div id="wrapper" class="text-center">
		<span class="h1" style="color:#ffffff;">宝宝助手</span>
		<form action="${pageContext.request.contextPath }/doLogin" method="post">
			<div class="form-group has-success">
				<div class="form-group has-success" align="center">
					<input type="text" name="username" class="form-control" placeholder="请输入手机号码" style="margin-top:30px;width:64%;" value="<shiro:principal/>" >
				</div>
				<div class="form-group has-success" align="center">
					<input type="password" name="password" class="form-control" placeholder="请输入密码" style="margin-top:5px;width:64%;">
				</div>
				<div class="form-group has-success" style="margin-top:5px">
					<input type="checkbox" name="rememberMe" style="zoom:1;">
					<span>记住密码</span>
				</div>
				<div>
					<input type="submit" class="btn btn-success" value="登录" style="margin-top:10px;width:60%;">
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>

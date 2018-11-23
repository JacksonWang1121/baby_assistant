<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 动态导入js文件和css文件 -->
<jsp:include page="common.jsp"></jsp:include>
<title>Insert title here</title>
</head>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/exception.jpg");
	}
	
	div{
		margin-left:550px;
		margin-top:330px;
	}
	
	span{
		font-weight: bold;
		font-family:"华文隶书"
	}
	
	a{
		font-style:oblique;
		font-weight: bold;
		font-family:"华文隶书"
	}
</style>

<body>
<%-- <h1>${msg}</h1> --%>
	<div>
		<span>很抱歉，您请求的页面现在无法打开！</span><br>
		<span>您可以&nbsp;&nbsp;</span><a href="main.jsp">返回首页</a>
	</div>
</body>
</html>
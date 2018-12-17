<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通讯录</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">

.coverReturn {
	/* 	border:1px solid #00FA9A; */
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}

.coverSave{
	/* border:1px solid #00FA9A; */
	width: 100px;
	height: 70px;
	position: absolute;
	right: 2px;
	z-index: 100;
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function(){
	
	$(".coverReturn").click(function(){
		
		window.location.href="/babyassistant/listClassesInfo";
	});
	
	
	
});

</script>

</head>
<body>
<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span> 
		<span class="coverReturn" ></span> 
		<span  style="margin-left: 400px; margin-right: 200px;"></span>
	</div>
<div>


<c:forEach  items="${parentInfo}"  var="parentInfo">

<img alt="" src="${parentInfo.user_icon}" style="width:30px;height:30px;border-radius:50%">
<a href="/babyassistant/queryUserInfoByUserId?userId=${ parentInfo.id}">

<h1>
${parentInfo.real_name}
</h1>
</a>
<br>
</c:forEach>
</div>



</body>
</html>
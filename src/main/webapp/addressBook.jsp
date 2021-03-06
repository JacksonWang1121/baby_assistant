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
		<span  style="margin-left: 330px; margin-right: 330px;">班级人员</span>
	</div>
<div>


<c:forEach  items="${parentInfo}"  var="parentInfo">

<table class="table">
<tr>
<td width="10%"><img  src="${parentInfo.user_icon}" style="width:65px;height:65px;border-radius:50%"></td>
	<td width="80%">
		<a href="/babyassistant/queryUserInfoByUserId?userId=${ parentInfo.id}">
		 <h1>${parentInfo.real_name}</h1>
		</a>
	</td>
</tr>
</table>
</c:forEach>

</body>
</html>
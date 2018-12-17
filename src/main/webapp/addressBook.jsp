<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通讯录</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.body{
	font-family:webfont;
    font-style:italic;
	font-weight:bold;
     color: black;

}
.coverReturn {
	/* 	border:1px solid #00FA9A; */
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}

.headline1{
	background-color:#00FA9A;
	text-align:center;
	height:45px;
	font-size:25px;
	color:#ffffff;
	padding-top:5px;
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

	<div class="headline1">
		<span class="glyphicon glyphicon-chevron-left"></span>
         <span class="coverReturn"></span>
		<span  style="margin-left:110px; margin-right: 150px;">通讯录</span>  
	</div>
<div>
		

			<table class="table">
			<c:forEach items="${parentInfo}" var="parentInfo">
				<tr>
					<td width="10%"><img src="${parentInfo.user_icon}"
						style="width: 50px; height: 50px; border-radius: 50%"></td>
					<td width="80%"><a
						href="/babyassistant/queryUserInfoByUserId?userId=${ parentInfo.id}">
							<h3>${parentInfo.real_name}</h3>
					</a></td>
				</tr>
						</c:forEach>
			</table>

		
		
		
		
		
		
		
		</body>
</html>
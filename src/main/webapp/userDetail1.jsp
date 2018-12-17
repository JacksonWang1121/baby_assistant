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
	width: 10px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}
#glyphicon-chevron-left {
	/* 	border:1px solid #00FA9A; */
	size: 300px
}
#top1{
background:url(/babyassistantfile/images/address01.jpg);
background-size:cover;
height: 200px;
width: 100%;
}
#ta{
border-collapse:separate;
border-spacing:10px 50px;
border-bottom-style:red;
border-bottom-top:red;

}
#img{
width: 100;
height: 100;
margin-left: 400px;
border-radius:50%;
}

#labe{
margin-left: 420px;

}
.headline1{
	background-color:#00FA9A;
	text-align:center;
	height:90px;
	font-size:25px;
	color:#ffffff;
	padding-top:5px;
}
</style>
<script type="text/javascript">
$(function(){
	$(".coverReturn").click(function(){
		
		window.location.href="/babyassistant/listBabyInfoByClassId?classId=${user.class_id}"	
		
	});
	
});


</script>

</head>
<body>
<div class="headline1">
		<span class="glyphicon glyphicon-chevron-left"></span>
         <span class="coverReturn"></span>
		<span  style="margin-left:220px; margin-right: 300px;">通讯录</span>  
	</div>
	
<div  id="top1">
	
		<br ><br ><br ><br >
<img alt="" src="${user.user_icon}"  id="img" ><br>
<label  id="labe" ><h2>${user.real_name}</h2></label>
</div>
	<table id="table" class="table" style="border-collapse:separate; border-spacing:0px 45px;">
		<tr>
			<td align="left" width="77%"><h1>手机：</h1></td>

			<td align="right" width="25%"><a><h1>${user.username}</h1></a></td>
		</tr>
		<tr>
			<td align="left" ><h1>角色：</h1></td>

			<td align="right" ><h1>${user.description}</h1></td>
			
		</tr>
		<tr>
		
		<td> <h1>班级：</h1>  </td>
		<td align="right"> <h1>${user.class_name}</h1>  </td>
		
		</tr>
		<tr>
		
		<td> <h1>孩子：</h1>  </td>
		<td align="right"> <h1>${user.baby_name}</h1>  </td>
		
		</tr>
		
	</table>


</body>
</html>
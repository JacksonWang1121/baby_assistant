<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=request.getContextPath()+"/" %>"/>
<title>个人主页</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/personaldata.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
		/* background-color:#F5F5F5; */
	}
	.homePageTitle{
		background-image:url("/babyassistantfile/images/pageImgs/mebg.jpg");
		height:200px;
		font-size:52px;
		color:#ffffff;
		padding-top:5%;
		padding-left:14%;
	}
	input{
		width:400px;
	}
	.list-group-item{
		height:130px;
		line-height:130px;
	}
	.icon{
		width:70px;
		height:70px;
		border-radius:70px;
		margin-left:5%;
		margin-right:2%;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击用户所在div,跳转到个人资料界面 
		$("#user").click(function(){
			window.location.href="/babyassistant/getPersonalData";	
		});
	});
</script>
</head>
<body>
	<div class="content">
		<!-- 标题栏 -->
		<div class="homePageTitle">
			<div class="col-xs-12" id="user">
				<img src="${user.user_icon}" id="bImg" name="bImg" style="width:80px;height:80px;border:solid rgb(30,30,30) 0px;">
				<span id="userName" >${user.real_name}</span>
				<span class="glyphicon glyphicon-chevron-right" style="margin-left:54%;"></span>
			</div>
		</div>
		<!-- 页面主要内容 -->
		<a href="#" class="list-group-item" >
			宝宝助手友情链接<img alt="" src="/babyassistantfile/images/businessIcons/lianjie.jpg"style="width:40px;height:40px;border-radius:40px;">
		</a>
		<div class="list-group" style="margin-top:8%;margin-bottom:15%">
			<a href="http://www.qbaobei.com/chengzhang/703890.html" class="list-group-item">
				<img alt="" src="/babyassistantfile/images/businessIcons/kissbaby.jpg" class="icon">亲亲宝贝
			</a>
			<a href="http://v.qq.com/detail/e/e51zela13gm1zno.html?ptag=baidu.aladdin.cartoon" class="list-group-item">
				<img alt="" src="/babyassistantfile/images/businessIcons/beiwa.jpg" class="icon">贝瓦儿歌
			</a>
			<a href="https://www.ximalaya.com/ertong/15000/" class="list-group-item">
				<img alt="" src="/babyassistantfile/images/businessIcons/hear.jpg" class="icon">喜马拉雅
			</a>
			<a href="https://ertong.rouding.com/diy/" class="list-group-item">
				<img alt="" src="/babyassistantfile/images/businessIcons/rouding.gif" class="icon">肉丁儿童网
			</a>
			<a href="https://www.vipkid.com.cn/sem?channel_id=212&channel_keyword=A3B50C002323D2&bd_vid=13748734201951559862" class="list-group-item">
				<img alt="" src="/babyassistantfile/images/businessIcons/english.jpg" class="icon">少儿英语
			</a>
		</div>
		<a href="${pageContext.request.contextPath}/logout" class="list-group-item" style="text-align:center;">退出登录</a>
		<div style="margin-top:33%;">
			<ul class="nav nav-tabs nav-justified" role="tablist">
	 			 <li >
	 			 	<a href="${pageContext.request.contextPath }/main">
	 			 		<img alt="" src="/babyassistantfile/images/businessIcons/firstPage.jpg" style="width:70px;height:70px;border-radius:70px;">首页
	 			 	</a>
	 			 </li>
				 <li>
				 	<a href="${pageContext.request.contextPath }/listInformByClassId">
				 		<img alt="" src="/babyassistantfile/images/businessIcons/notice.jpg" style="width:70px;height:70px;border-radius:70px;">通知
				 	</a>
				 </li>
				 <shiro:hasPermission name="user:myInfo">
				 	<li class="active">
				 		<a href="${pageContext.request.contextPath }/getPersonalHomePage">
				 			<img alt="" src="/babyassistantfile/images/businessIcons/my.jpg" style="width:70px;height:70px;border-radius:70px;">我
				 		</a>
				 	</li>		
				 </shiro:hasPermission>	
			</ul>
		</div>
	</div>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人资料</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/mebg3.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:1px;
		z-index:100;
		cursor: pointer;
	}
	.coverSave{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}
	input{
		width:400px;
	}
	.col-xs-4{
		margin-bottom:10%;
	}
	.col-xs-8{
		margin-bottom:10%;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/getPersonalHomePage";	
		});
		//点击保存图标修改用户信息
		$(".coverSave").click(function(){
			var formData = new FormData($("dietForm"));
			formData.append("nickName", $("#nickName").val());
			formData.append("personalitySignature", $("#personalitySignature").val());
			formData.append("address", $("#address").val());
			$.ajax({
				url:"${pageContext.request.contextPath }/updateUserInfo",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						window.location.href="${pageContext.request.contextPath }/getPersonalData";
					}else{
						new TipBox({type:'tip',str:'个人信息查找失败，请稍后再试!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
			});	
		});
		//点击头像跳转到头像修改界面
		$("#userIcon").click(function(){
			window.location.href="/babyassistant/updateUserIcon.jsp";	
		}); 
	});
</script>
</head>
<body>
	<div>
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:310px;margin-right:310px;">个人资料</span>
			<span class="glyphicon glyphicon-saved" id="diet"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="container" style="font-size:35px;background-color:white;margin-top:10%;border-radius:80px;">
			<form id="userForm">
				<div class="col-xs-4" style="margin-top:10%;">我的头像</div>
				<div class="col-xs-8" id="userIcon" style="margin-top:6%;">
					<img src="${user.user_icon}" id="bImg" name="bImg" style="width:100px;height:100px;border-radius:90px;border:solid rgb(30,30,30) 0px;">
				</div>
				<div class="col-xs-4">用户昵称</div>
				<div class="col-xs-8"><input type="text" value="${user.nick_name}" id="nickName" name="nickName"></div>
				<div class="col-xs-4">个性签名</div>
				<div class="col-xs-8"><input type="text" value="${user.personality_signature}" id="personalitySignature" name="personalitySignature"></div>
				<div class="col-xs-4">家庭住址</div>
				<div class="col-xs-8"><input type="text" value="${user.address}" id="address" name="address"></div>
			</form>
		</div>
	</div>
</body>
</html>
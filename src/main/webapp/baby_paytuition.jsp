<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名缴费</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	.coverReturn{
		border:1px solid #00FA9A;
		width:120px;
		height:70px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
	}
	li{
		font-size:30px;
		width:720px;
	}
</style>
<script type="text/javascript">
	$(function(){
		//将获取的与宝宝关系值赋给下拉框
		var relation=$("#relation").val();
		$("#relationship option[value='"+relation+"']").attr("selected", true);
		
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/main";	
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
			<span style="margin-left:330px;margin-right:330px;">报名缴费</span>
		</div>
		<!-- 页面主要内容 -->
		<div class="container" style="margin-top:20%">
			<form action="payTuition" id="payForm">
				<div class="content">
					<div class="input-group input-group-sm" style="font-size:30px;margin-bottom:7%">
					  	<input type="text" class="form-control" placeholder="请输入金额" style="font-size:35px;height:80px;width:720px;text-align:center;">
					</div>
					<div class="input-group input-group-sm">
						  <div class="input-group-btn" >
							   <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="font-size:35px;width:720px;height:80px;">请选择支付银行<span class="caret"></span></button>
							   <ul class="dropdown-menu dropdown-menu-right" role="menu">
							       <li><a href="#">建设银行</a></li>
							       <li><a href="#">工商银行</a></li>
							       <li><a href="#">农业银行</a></li>
							  </ul>
						  </div>
				    </div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
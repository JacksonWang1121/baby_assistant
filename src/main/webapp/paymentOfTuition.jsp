<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生网上缴费</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	.coverReturn{
		border:1px solid #00FA9A;
		width:120px;
		height:70px;
		position:absolute;
		left:13px;
		z-index:100;
		cursor: pointer;
	}
	.content{
		margin-bottom:10px;
	}
	.form-control{
		width:550px;
		height:70px;
		font-size:40px;
	}
	img{
		width:320px;
		height:220px;
	}
	input[type="text"]{
		width:400px;
	}
	input[type="radio"]{
		width:30px;
		height:30px;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="${pageContext.request.contextPath }/main.jsp";	
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
			<span style="margin-left:310px;margin-right:310px;">报名缴费</span>
		</div>
		<!-- 页面主要内容 -->
		<div class="container">
			<div class="content">
				<form action="${pageContext.request.contextPath }/payTuition" method="post">
					<div style="margin-top:3%;">
						 金　额：<input type="text" name="money" class="form-control"/><br>
						 选择银行：
					 </div>
					 <input type="radio" name="pd_FrpId" value="ICBC-NET-B2C"/>工商银行
					 <img src="/babyassistantfile/images/businessIcons/icbc.jpg" align="middle"/><br>
					 <input type="radio" name="pd_FrpId" value="BOC-NET-B2C"/>中国银行
					 <img src="/babyassistantfile/images/businessIcons/bc.jpg" align="middle"/><br>
					 <input type="radio" name="pd_FrpId" value="ABC-NET-B2C"/>农业银行
					 <img src="/babyassistantfile/images/businessIcons/abc.jpg" align="middle"/><br>
					 <input type="radio" name="pd_FrpId" value="CCB-NET-B2C"/>建设银行
					 <img src="/babyassistantfile/images/businessIcons/ccb.jpg" align="middle"/><br>
					 <input type="radio" name="pd_FrpId" value="BOCO-NET-B2C"/>交通银行
					 <img src="/babyassistantfile/images/businessIcons/bcc.jpg" align="middle"/><br>
					 <input type="submit" value="确认支付" style="width:550px;"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
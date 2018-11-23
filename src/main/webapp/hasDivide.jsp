<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名列表</title>
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
		width:23%;
		text-align:center;
	}
</style>
<script type="text/javascript">
	$(function(){
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
			<span style="margin-left:330px;margin-right:330px;">报名列表</span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content">
			<!-- 导航栏 -->
			<ul class="nav nav-pills" role="tablist">
	  			<li><a href="/babyassistant/listWaitDivideBabyInfo">待分班</a></li>
	  			<li class="active"><a href="/babyassistant/listClassInfo">已分班</a></li>
	  			<li><a href="/babyassistant/listWaitPayBabyInfo">待付款</a></li>
	  			<li style="width:30%;"><a href="/babyassistant/sumBaby.jsp">各班人数图示</a></li>
			</ul>
			<table class="table table-bordered table-hover" style="font-size:40px;" id="classAttendance">
				<thead>
					<tr class="success">
						<th>年级</th>
						<th>班级</th>
						<th>教师</th>
						<th style="text-align:center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${classInfos}" var="classInfo">
						<tr>
							<td>${classInfo.grade_name}</td>
							<td>${classInfo.class_name}</td>
							<td>${classInfo.real_name}</td>
							<td style="text-align:center">
								<a href="/babyassistant/listBabiesByClassId?classId=${classInfo.class_id}">
									<input type="button" class="btn btn-info" value="学生列表" style="font-size:35px;">
								</a>
							</td>
						 </tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
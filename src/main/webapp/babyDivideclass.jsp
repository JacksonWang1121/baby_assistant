<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝宝分班</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/babydivideclass.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
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
		width:49.8%;
		text-align:center;
	}
	.pageInput{ border-width: 0; }
</style>
<script type="text/javascript">
	$(function(){
		/* 刷新分页信息 */
		$("#pageSize").val('${pv.pageSize }');
		$("#curPage").val('${pv.curPage }');
		$("#pages").val('${pv.pages }');
		/* 注册上一页的点击事件 */
		$("#prevPage").click(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取当前页
			//String转int
			var value = Number($("#curPage").val());
			var curPage = (value-1==0)?1:(value-1);
			window.location.href = "/babyassistant/listBabyEnrollInfo?curPage="+curPage+"&pageSize="+pageSize;
		});
		
		/* 每页条数的失去焦点事件 */
		$("#pageSize").blur(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取当前页
			//String转int
			var curPage = Number($("#curPage").val());
			window.location.href = "/babyassistant/listBabyEnrollInfo?curPage="+curPage+"&pageSize="+pageSize;
		});
		
		/* 当前页的获得焦点事件 */
		$("#curPage").focus(function() {
			//获取当前页
			//String转int
			curPageValue = Number($("#curPage").val());
		});
		
		/* 当前页的失去焦点事件 */
		$("#curPage").blur(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取总页数
			var pages = Number($("#pages").val());
			//获取当前页
			//String转int
			var value = Number($("#curPage").val());
			var curPage = (value>0 && value<(pages+1))?value:curPageValue;
			window.location.href = "/babyassistant/listBabyEnrollInfo?curPage="+curPage+"&pageSize="+pageSize;
		});
		
		/* 注册下一页的点击事件 */
		$("#nextPage").click(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取总页数
			var pages = Number($("#pages").val());
			//获取当前页
			//String转int
			var value = Number($("#curPage").val());
			var curPage = (value+1>pages)?value:(value+1);
			window.location.href = "/babyassistant/listBabyEnrollInfo?curPage="+curPage+"&pageSize="+pageSize;
		});
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
		<span style="margin-left:330px;margin-right:330px;">宝宝分班</span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content">
			<!-- 导航栏 -->
			<ul class="nav nav-pills" role="tablist">
	  			<li class="active"><a href="/babyassistant/listBabyEnrollInfo">待分班</a></li>
	  			<li><a href="/babyassistant/listBabiesInClass">已分班</a></li>
			</ul>
			<table class="table table-bordered table-hover" style="font-size:40px" id="classAttendance">
				<thead>
					<tr class="success">
						<th>报名日期</th>
						<th>宝宝姓名</th>
						<th>联系方式</th>
						<th style="text-align:center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pv.datas}" var="waitDivideInfo">
						<tr>
							<td>${waitDivideInfo.enter_date}</td>
							<td>${waitDivideInfo.baby_name}</td>
							<td>${waitDivideInfo.username}</td>
							<td style="text-align:center">
								<a href="/babyassistant/updateClassInfoToBaby?babyId=${waitDivideInfo.baby_id}&classId=${waitDivideInfo.class_id}"><input type="button" class="btn btn-info" value="加入班级" style="font-size:35px;"></a>
							</td>
						 </tr>
					</c:forEach>
					<tr>
						<td colspan="7" style="text-align:center;">
							<ul class="pager">
								<li><a id="prevPage" href="javascript:">上一页</a></li>
								每页<input type="text" class="pageInput" name="pageSize" id="pageSize" style="width:7%;height:6%;text-align:center;"/>条,
								当前第<input type="text" class="pageInput" name="curPage" id="curPage" style="width:8%;height:6%;text-align:center;"/>页,
								共<input type="text" class="pageInput" name="pages" id="pages" style="width:8%;height:6%;text-align:center;"/>页
								<li><a id="nextPage" href="javascript:">下一页</a></li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
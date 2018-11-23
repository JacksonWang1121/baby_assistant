<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝宝考勤</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/babyattendance.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
	}
	.coverRefresh{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}
	.content{
		margin-bottom:10px;
	}
	.date{
		width:285px;
		height:60px;
		font-size:35px;
	}
	#search{
		width:145px;
		height:60px;
		font-size:40px;
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
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "/babyassistant/listBabyAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate;
		});
		
		/* 每页条数的失去焦点事件 */
		$("#pageSize").blur(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取当前页
			//String转int
			var curPage = Number($("#curPage").val());
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "/babyassistant/listBabyAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate;
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
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "/babyassistant/listBabyAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate;
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
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "/babyassistant/listBabyAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate;
		});
		
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/main";	
		});
		//点击刷新图标 
		$(".coverRefresh").click(function(){
			window.location.href="/babyassistant/listBabyAttendance";	
		});
		//点击查询按钮
		$("#search").click(function(){
			var startDate=$("#startSignDate").val();
			var endDate=$("#endSignDate").val();
			if(endDate==""){
				$("#searchForm").submit();
			}else{
				if(startDate==""){
					/* 若开始日期为空，给出提示信息 */
					new TipBox({type:'tip',str:'请输入查询初始日期!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
				}else{
					$("#searchForm").submit();
				}
			}
		});
	});
</script>
</head>
<body>
	<div id="container">
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:310px;margin-right:310px;">宝宝考勤</span>
			<span class="glyphicon glyphicon-refresh"></span>
			<span class="coverRefresh"></span>
		</div>
		<!-- 条件查询 -->
		<div class="content" style="margin-top:2%;margin-left:5%;margin-bottom:3%">
			<form action="/babyassistant/listBabyAttendanceByTerm?curPage=${requestScope.pv.curPage }&pageSize=${requestScope.pv.pageSize }" id="searchForm" method="post">
				<span>日期</span>
				<input type="text" class="date" name="startSignDate" id="startSignDate" value="${conditionsMap.startSignDate }"class="Wdate" onClick="WdatePicker({el:this})"/>&nbsp;至&nbsp;
				<input type="text" class="date" name="endSignDate" id="endSignDate" value="${conditionsMap.endSignDate }"class="Wdate" onClick="WdatePicker({el:this})"/>
				<input type="button" value="查询" class="btn btn-success" id="search">
			</form>
		</div>
		<!-- 页面主要内容 -->
		<div>
			<table class="table table-bordered table-hover" style="font-size:40px" id="classAttendance">
				<thead>
					<tr class="success">
						<th>签到日期</th>
						<th>宝宝姓名</th>
						<th>年级</th>
						<th>班级</th>
						<th>宝宝学号</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pv.datas}" var="attendance">
						<tr>
							<td>${attendance.attendance_date}</td>
							<td>${attendance.baby_name}</td>
							<td>${attendance.grade_name}</td>
							<td>${attendance.class_name}</td>
							<td>${attendance.baby_no}</td>
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
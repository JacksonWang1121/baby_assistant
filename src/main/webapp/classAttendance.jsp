<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级考勤</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.common.min.js"></script>
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
	.form-control{
		width:310px;
		height:60px;
		font-size:35px;
		margin-bottom:10px;
		border: 1px solid #000000;
	}
	.content{
		margin-bottom:10px;
	}
	.date{
		width:310px;
		height:60px;
		font-size:35px;
	}
	#search{
		width:130px;
		height:60px;
		font-size:40px;
	}
	select{
		width:310px;
		height:60px;
		font-size:35px;
	}
	.pageInput{ border-width: 0; }
</style>
<script type="text/javascript">
	$(function(){
		initMain(); //初始化图标面板
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
			var babyNo=$("#babyNo").val();
			var babyName=$("#babyName").val();
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "${pageContext.request.contextPath }/listClassAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate+"&babyNo="+babyNo+"&babyName="+babyName;
		});
		
		/* 每页条数的失去焦点事件 */
		$("#pageSize").blur(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取当前页
			//String转int
			var curPage = Number($("#curPage").val());
			var babyNo=$("#babyNo").val();
			var babyName=$("#babyName").val();
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "${pageContext.request.contextPath }/listClassAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate+"&babyNo="+babyNo+"&babyName="+babyName;
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
			var babyNo=$("#babyNo").val();
			var babyName=$("#babyName").val();
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "${pageContext.request.contextPath }/listClassAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate+"&babyNo="+babyNo+"&babyName="+babyName;
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
			var babyNo=$("#babyNo").val();
			var babyName=$("#babyName").val();
			var startSignDate=$("#startSignDate").val();
			var endSignDate=$("#endSignDate").val();
			window.location.href = "${pageContext.request.contextPath }/listClassAttendanceByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startSignDate="+startSignDate+"&endSignDate="+endSignDate+"&babyNo="+babyNo+"&babyName="+babyName;
		});
		//页面加载完毕，将所有的姓名和学号添加到下拉列表中
		$.ajax({
		url:'listAllBabies',
		async: false,
		type:'get',
		dataType:'json',
		success:function(data){
			for(var i=0;i<data.length;i++){
				var str='<option value="'+data[i].baby_no+'">'+data[i].baby_no+'</option>';
				$("#babyNo").append(str);
				var str1='<option value="'+data[i].baby_name+'">'+data[i].baby_name+'</option>';
				$("#babyName").append(str1);
			}
		}
		});
		//给查询条件赋值
		var no = $("#no").val();
        $("#babyNo option[value='"+no+"']").attr("selected", true);
        var name = $("#name").val();
        $("#babyName option[value='"+name+"']").attr("selected", true);
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="${pageContext.request.contextPath }/main";	
		});
		//点击刷新图标 
		$(".coverRefresh").click(function(){
			window.location.href="${pageContext.request.contextPath }/listClassAttendance";	
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
function initMain(){
	//获取echart对象
	var myChart=echarts.init(document.getElementById('main')); 
		      
	$.ajax({
		type : "post",
		async : true,    
		url : "${pageContext.request.contextPath }/countAttendanceRate",
		data : {},
		dataType : "json",        //返回数据形式为json
		success : function(result) {
			//获取填充数据
			var option = {
				tooltip: {  
					showContent:true,
					textStyle : {
			            color: 'white',
			            fontSize: 45,
			        },
			    },
				series : [{
							name: '日出勤统计',
	                        type: 'pie',
	                        radius: '68%',
	                        data:[
	                            {value:result.nums[0], name:result.labels[0]},
	                            {value:result.nums[1], name:result.labels[1]}
	                        ],
	                        label: {
				                normal: {
				                    textStyle: {
				                         fontSize:'45',
				                    }
				                }
				            },
						}]
			};  
			//填充数据
			myChart.setOption(option);	             
		},
		error : function(errorMsg) {
			//请求失败时执行该函数
			alert("图表请求数据失败!");    
			myChart.hideLoading();
		}
	}); 
}
</script>
</head>
<body>
	<div id="container">
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:310px;margin-right:310px;">班级考勤</span>
			<span class="glyphicon glyphicon-refresh"></span>
			<span class="coverRefresh"></span>
		</div>
		<div id="main" style="width:100%;height:560px;font-size:70px;margin-bottom:3%;"></div>
		<!-- 条件查询 -->
		<div class="content">
			<form action="${pageContext.request.contextPath }/listClassAttendanceByTerm?curPage=${requestScope.pv.curPage }&pageSize=${requestScope.pv.pageSize }" id="searchForm" method="post">
				<div style="float:left;">学号&nbsp;</div>
				<div style="float:left;"><input type="text" id="no" name="no" value="${conditionsMap.babyNo }" hidden="hidden">
					<select  id="babyNo" name="babyNo">
						<option value=""></option>
					</select>
				</div>
				<div style="float:left;">&nbsp;姓名&nbsp;</div>
				<div><input type="text" id="name" name="name" value="${conditionsMap.babyName }" hidden="hidden">
					<select id="babyName" name="babyName">
						<option value=""></option>
					</select>
				</div>
				<div style="margin-top:15px;margin-bottom:1%">
					<span>日期</span>
					<input type="text" class="date" name="startSignDate" id="startSignDate"  value="${conditionsMap.startSignDate }"class="Wdate" onClick="WdatePicker({el:this})"/>&nbsp;至
					<input type="text" class="date" name="endSignDate" id="endSignDate" value="${conditionsMap.endSignDate }"class="Wdate" style="margin-left:38px;" onClick="WdatePicker({el:this})"/>
					<input type="button" value="查询" class="btn btn-success" id="search">
				</div>
			</form>
		</div>
		<!-- 页面主要内容 -->
		<div>
			<table class="table table-bordered table-hover" style="font-size:40px" id="classAttendance">
				<thead>
					<tr class="success">
						<th>签到日期</th>
						<th>宝宝姓名</th>
						<th>宝宝学号</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pv.datas}" var="attendance">
						<tr>
							<td>${attendance.attendance_date}</td>
							<td>${attendance.baby_name}</td>
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
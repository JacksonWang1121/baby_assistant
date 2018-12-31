<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师请假</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/teacherLeave1.jpg");
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
	.coverSave{
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
	#saveIcon{
		font-size:35px;
		color:#ffffff;
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
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			window.location.href = "/babyassistant/listLeaveInfoByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startDate="+startDate+"&endDate="+endDate;
		});
		
		/* 每页条数的失去焦点事件 */
		$("#pageSize").blur(function() {
			//获取每页的条数
			var pageSize = $("#pageSize").val();
			//获取当前页
			//String转int
			var curPage = Number($("#curPage").val());
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			window.location.href = "/babyassistant/listLeaveInfoByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startDate="+startDate+"&endDate="+endDate;
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
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			window.location.href = "/babyassistant/listLeaveInfoByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startDate="+startDate+"&endDate="+endDate;
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
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
			window.location.href = "/babyassistant/listLeaveInfoByTerm?curPage="+curPage+"&pageSize="+pageSize+"&startDate="+startDate+"&endDate="+endDate;
		});
		//点击查询按钮
		$("#search").click(function(){
			var startDate=$("#startDate").val();
			var endDate=$("#endDate").val();
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
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/main";	
		});
		//点击保存图标，弹出模态框 
		$(".coverSave").click(function(){
			$('#myModal').modal('show');
		});
		/*
		* 在模态框中填写请假信息
		*/
		$("#ensure").bind("click",function(){
			var formData = new FormData($("leaveApplicationForm"));
			formData.append("realName", $("#realName").val());
			formData.append("leaveTime", $("#leaveTime").val());
			formData.append("leaveReason", $("#leaveReason").val());
			$.ajax({
				url:"${pageContext.request.contextPath }/saveLeaveInfo",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						/* 若录入食谱失败，给出提示信息 */
						new TipBox({type:'tip',str:'提交成功，待批准!',clickDomCancel:true,setTime:90000500,hasBtn:true});  
						window.location.href="${pageContext.request.contextPath }/listLeaveInfoById";
					}else{
						/* 若录入食谱失败，给出提示信息 */
						new TipBox({type:'tip',str:'提交失败，请重新提交!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
			});
			$("#myModal").modal('hide');
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
			<span style="margin-left:310px;margin-right:310px;">教师请假</span>
			<span class="glyphicon glyphicon-edit"  style="font-size:50px;"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 条件查询 -->
		<div class="content" style="margin-top:5px;margin-left:5%;margin-bottom:1%">
			<form action="/babyassistant/listLeaveInfoByTerm?curPage=${requestScope.pv.curPage }&amp;pageSize=${requestScope.pv.pageSize }" id="searchForm" method="post">
				<span>日期</span>
				<input type="text" class="date" name="startDate" id="startDate" value="${conditionsMap.startDate }" class="Wdate" onClick="WdatePicker({el:this})">&nbsp;至&nbsp;
				<input type="text" class="date" name="endDate" id="endDate" value="${conditionsMap.endDate }" class="Wdate" onClick="WdatePicker({el:this})">
				<input type="button" value="查询" class="btn btn-success" id="search">
			</form>
		</div>
		<div>
				<table class="table table-bordered table-hover" style="font-size:40px" id="teacherLeave">
					<thead>
						<tr class="success">
							<th>申请时间</th>
							<th>请假理由</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pv.datas}" var="teacherLeave">
							<tr>
								<td>${teacherLeave.submit_date}</td>
								<td>${teacherLeave.leave_reason}</td>
								<td>${teacherLeave.leave_status}</td>
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
	<!-- 动态加载模态框 -->
	<jsp:include page="teacherLeave.jsp"></jsp:include>
</body>
</html>
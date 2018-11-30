<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改周计划</title>
<jsp:include page="public.jsp"></jsp:include>
<script type="text/javascript" src="js/js/public.js"></script>
<script type="text/javascript" src="js/js/dateUtil.js"></script>
<script type="text/javascript" src="js/js/fileUtil.js"></script>
<style type="text/css">
.container {
	margin-top: 52px;
}
</style>
<script type="text/javascript">
//记录本周计划的周时间
var planDate = null;

$(function() {
	
	//获取请求地址url中的参数值
	var planId = getUrl("planId");
	var weekNum = getUrl("weekNum");
	console.log("updateWeeklyPlan:planId = "+planId+", weekNum = "+weekNum);
	
	/* 显示要查询的周计划信息 */
	$.ajax({
		url: "${pageContext.request.contextPath }/weeklyPlan/findWeeklyPlanById",
		type: "POST",
		data: {"planId":planId},
		dataType: "text",
		success: function(result,status) {
			// 根据返回结果指定界面操作
			console.log("updateWeeklyPlan:success-result = "+result);
			//若有数据返回，则显示到相应的位置
			if (result!=null || result!="") {
				//字符串转json对象
				var data = $.parseJSON(result);
				//记录周时间并赋值
				planDate = data.weekDate;
				//显示周计划中具体每天的时间
				showDayTime(data.weekDate);
				$("#MondayMorning").html(data.mondayMorning);
				$("#MondayAfternoon").html(data.mondayAfternoon);
				$("#TuesdayMorning").html(data.tuesdayMorning);
				$("#TuesdayAfternoon").html(data.tuesdayAfternoon);
				$("#WednesdayMorning").html(data.wednesdayMorning);
				$("#WednesdayAfternoon").html(data.wednesdayAfternoon);
				$("#ThursdayMorning").html(data.thursdayMorning);
				$("#ThursdayAfternoon").html(data.thursdayAfternoon);
				$("#FridayMorning").html(data.fridayMorning);
				$("#FridayAfternoon").html(data.fridayAfternoon);
				if (data.weekPicture != null) {
					$("#weekPhoto").after('<img alt="该图片不存在" src="'+data.weekPicture+'">');
				}
			}
		},
		error: function(data,status,e) {
			console.log("updateWeeklyPlan:error = "+e);
			alert("读取失败");
		}
	});
	
	/* 点击保存按钮 */
	$("#updatePlan").click(function() {
		//用FormData对象来发送二进制文件
		//FormData构造函数提供的append()方法，除了直接添加二进制文件还可以附带一些其它的参数，作为XMLHttpRequest实例的参数提交给服务端
		var formData = new FormData($("form_plan_update"));
		formData.append("id", planId);
		formData.append("weekDate", planDate);
		formData.append("mondayMorning", $("#MondayMorning").val());
		formData.append("mondayAfternoon", $("#MondayAfternoon").val());
		formData.append("tuesdayMorning", $("#TuesdayMorning").val());
		formData.append("tuesdayAfternoon", $("#TuesdayAfternoon").val());
		formData.append("wednesdayMorning", $("#WednesdayMorning").val());
		formData.append("wendesdayAfternoon", $("#WednesdayAfternoon").val());
		formData.append("thursdayMorning", $("#ThursdayMorning").val());
		formData.append("thursdayAfternoon", $("#ThursdayAfternoon").val());
		formData.append("fridayMorning", $("#FridayMorning").val());
		formData.append("fridayAfternoon", $("#FridayAfternoon").val());
		formData.append("weekPhoto", $("#weekPhoto")[0].files[0]);
		$.ajax({
			url: "${pageContext.request.contextPath }/weeklyPlan/updateWeeklyPlan",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("updateWeeklyPlan:success-data = "+data);
				if (data == "true") {
					window.location.href = "listWeeklyPlan.jsp?weekNum="+weekNum;
					alert("保存成功");
				} else {
					alert("保存失败");
				}
			},
			error: function(data,status,e) {
				console.log("updateWeeklyPlan:error = "+e);
				alert("保存失败");
			}
		});
	});
});

/* 显示周计划中具体每天的时间 */
function showDayTime(weekDate) {
	var split = weekDate.split("-");
	var year = split[0];
	var week = split[1];
	//指定某年第几周的开始日期（从周一算起）日期格式字符串
	var dateStr = getBeginDateOfWeek(year,week);
	//指定某年第几周的结束日期
	var endDateStr = getEndDateOfWeek(year,week);
	//转换成日期
	var date = parseDate(dateStr);
	//显示日期到相应的位置
	$("#weekTime").html('('+dateStr+'~'+endDateStr+')');
	$(".Mon").html(dateStr);
	date.setDate(date.getDate()+1);
	$(".Tues").html(formatDate(date));
	date.setDate(date.getDate()+1);
	$(".Wed").html(formatDate(date));
	date.setDate(date.getDate()+1);
	$(".Thurs").html(formatDate(date));
	date.setDate(date.getDate()+1);
	$(".Fri").html(formatDate(date));
}
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="${pageContext.request.contextPath }/listWeeklyPlan.jsp" class="z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>${classInfo.className }周计划</label>
	<a id="updatePlan" href="javascript:" class="z-index pull-right" style="margin-right:20px;">
		<img alt="" width="20px" src="images/icons/preservation.svg">
	</a>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
<form id="form_plan_update">
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-12"><strong>周一上午</strong>(<span class="Mon"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="MondayMorning" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-12"><strong>周一下午</strong>(<span class="Mon"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="MondayAfternoon" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周二上午</strong>(<span class="Tues"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="TuesdayMorning" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周二下午</strong>(<span class="Tues"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="TuesdayAfternoon" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周三上午</strong>(<span class="Wed"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="WednesdayMorning" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周三下午</strong>(<span class="Wed"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="WednesdayAfternoon" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周四上午</strong>(<span class="Thurs"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="ThursdayMorning" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周四下午</strong>(<span class="Thurs"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="ThursdayAfternoon" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周五上午</strong>(<span class="Fri"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="FridayMorning" rows="3" cols="30"></textarea>
		</div>
	</div>
	
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-12"><strong>周五下午</strong>(<span class="Fri"></span>)</div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea id="FridayAfternoon" rows="3" cols="30"></textarea>
		</div>
	</div>
	<!-- 周图片 -->
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-4 text-right"><strong>下周计划</strong></div>
		<div class="col-xs-8"><input type="file" id="weekPhoto" onchange="checkFile(this);showFile(this)" accept="image/*"></div>
	</div>
</form>
</div>
</body>
</html>
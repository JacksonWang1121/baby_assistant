<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>周计划</title>
<jsp:include page="public.jsp"></jsp:include>
<link rel="stylesheet" href="css/swiper.min.css">
<script type="text/javascript" src="js/swiper.min.js"></script>
<script type="text/javascript" src="js/js/dateUtil.js"></script>
<style type="text/css">
#switchWeek {
	padding-top:48px;
}
#switchWeek>a {
	padding-top:4px;
}
#switchWeek>label {
	font-size:24px;
}
#moreModal {
	margin-top: 10%;
}
</style>
<script type="text/javascript">
//记录点击了上一周或下一周
var weekCount = 0;
//记录存在的本周计划的id
var planId = 0;
//记录本周计划的周时间
var planDate = null;

$(function() {
	
	/* 页面初始化 */
	showWeeklyPlan(weekCount);
	
	/* 页面右上角的更多按钮注册事件 */
	$("#more").bind('click', function() {
		$("#moreModal").modal('show');
	});
	
	/* 添加周计划按钮注册事件 */
	$("#saveWeeklyPlanBtn").bind('click', function() {
		//隐藏modal框
		$("#moreModal").modal('hidden');
		//若周计划不存在，则跳转到添加周计划页面，否则提示该周计划已存在
		if (planId == 0) {
			//跳转页面
			window.location.href = "saveWeeklyPlan.jsp?planDate="+planDate;
		} else {
			//提示框
			new TipBox({
				type:'error',
				str:'本周计划已存在',
				hasBtn:true
			});
		}
	});
	
	/* 修改周计划按钮注册事件 */
	$("#updateWeeklyPlanBtn").bind('click', function() {
		//隐藏modal框
		$("#moreModal").modal('hidden');
		//若周计划存在，则跳转到修改周计划页面，否则提示该周计划不存在
		if (planId == 0) {
			//提示框
			new TipBox({
				type:'error',
				str:'本周计划不存在',
				hasBtn:true
			});
		} else {
			//跳转页面
			window.location.href = "updateWeeklyPlan.jsp?planId="+planId;
		}
	});
	
	/* 点击上一周按钮 */
	$("#prevWeek").bind('click',function() {
		//weekNum减一
		weekCount--;
		//刷新周计划内容
		showWeeklyPlan(weekCount);
	});
	
	/* 点击下一周按钮 */
	$("#nextWeek").bind('click',function() {
		//weekNum加一
		weekCount++;
		//刷新周计划内容
		showWeeklyPlan(weekCount);
	});
});

/* 显示周计划的内容 */
function showWeeklyPlan(weekNum) {
	console.log("weekNum = "+weekNum);
	$.ajax({
		url: "${pageContext.request.contextPath }/weeklyPlan/findWeeklyPlan",
		type: "POST",
		data: {"weekNum":weekNum},
		dataType: "text",
		success: function(result,status) {
			// 根据返回结果指定界面操作
			console.log("listWeeklyPlan:success-result = "+result);
			//重置周计划id
			planId = 0;
			//清空上一次显示的数据
			$("#weekTime").html('');
			//若周计划图片已隐藏，则重新显示
			var hidd = $("#weekPicture").parent().attr("hidden");
			if (hidd) {
				//显示周计划图片，即删除hidden属性
				$("#weekPicture").parent().removeAttr("hidden","hidden");
			}
			$("#weekPicture").html('');
			$("#MondayMorning").html('');
			$("#MondayAfternoon").html('');
			$("#TuesdayMorning").html('');
			$("#TuesdayAfternoon").html('');
			$("#WednesdayMorning").html('');
			$("#WednesdayAfternoon").html('');
			$("#ThursdayMorning").html('');
			$("#ThursdayAfternoon").html('');
			$("#FridayMorning").html('');
			$("#FridayAfternoon").html('');
			
			//若有数据返回，则显示到相应的位置
			if (result!=null || result!="") {
				//字符串转json对象
				var data = $.parseJSON(result);
				/* 显示周计划中具体每天的时间 */
				showDayTime(data.weekDate);
				console.log("listWeeklyPlan:plan_id = "+data.id);
				if (data.id!=null || data.id!="") {
					//周计划存在并赋值
					planId = data.id;
					planDate = data.weekDate;
					if (data.weekPicture != null) {
						$("#weekPicture").html('<img alt="该图片不存在" src="'+data.weekPicture+'">');
					} else {
						//隐藏周计划图片
						$("#weekPicture").parent().attr("hidden","hidden");
					}
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
				}
			}
		},
		error: function(data,status,e) {
			console.log("listWeeklyPlan:error = "+e);
			alert("读取失败");
		}
	});
}

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
	<a href="${pageContext.request.contextPath }/main" class="z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>${classInfo.className }周计划</label>
	<!-- 只有教师才有此权限 -->
	<shiro:hasPermission name="plan:more">
		<a id="more" href="javascript:" class="z-index pull-right" style="margin-right:20px;">
			<img alt="" width="20px" src="images/icons/more.svg">
		</a>
	</shiro:hasPermission>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<!-- 上周 本周 下周 -->
<div id="switchWeek" class="text-center">
	<a id="prevWeek" href="javascript:" class="pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/turnleft.svg">
		<span>上周</span>
	</a>
	<label>本周</label><span id="weekTime"></span>
	<a id="nextWeek" href="javascript:" class="pull-right" style="margin-right:20px;">
		<span>下周</span>
		<img alt="" width="20px" src="images/icons/turnright.svg">
	</a>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
<div class="swiper-container">
	<div class="swiper-wrapper">
	
	<div class="swiper-slide">
		<div id="weekPicture"></div>
	</div>
	
	<div class="swiper-slide">
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-12"><strong>周一上午</strong>(<span class="Mon"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="MondayMorning"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-12"><strong>周一下午</strong>(<span class="Mon"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="MondayAfternoon"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周二上午</strong>(<span class="Tues"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="TuesdayMorning"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周二下午</strong>(<span class="Tues"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="TuesdayAfternoon"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周三上午</strong>(<span class="Wed"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="WednesdayMorning"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周三下午</strong>(<span class="Wed"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="WednesdayAfternoon"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周四上午</strong>(<span class="Thurs"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="ThursdayMorning"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周四下午</strong>(<span class="Thurs"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="ThursdayAfternoon"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周五上午</strong>(<span class="Fri"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="FridayMorning"></p>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-1"></div>
			<div class="col-xs-12"><strong>周五下午</strong>(<span class="Fri"></span>)</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<p id="FridayAfternoon"></p>
			</div>
		</div>
	</div>
	
	</div>
</div>
</div>

<!-- 更多按钮Modal -->
<div class="modal fade" id="moreModal" tabindex="-1" role="dialog" aria-labelledby="moreModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="moreModalLabel">Modal title</h4>
			</div> -->
			<div class="modal-body">
				<div>
					<button id="saveWeeklyPlanBtn" class="btn btn-primary" style="width:100%">添加周计划</button>
				</div>
				<div style="margin-top: 10px;">
					<button id="updateWeeklyPlanBtn" class="btn btn-primary" style="width:100%">修改周计划</button>
				</div>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div> -->
		</div>
	</div>
</div>

<script type="text/javascript">
/* 上下滑动 */
var swiper1 = new Swiper('.swiper-container', {
	direction: 'vertical',  //垂直切换选项
});
</script>
</body>
</html>
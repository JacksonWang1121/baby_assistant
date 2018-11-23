<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>周计划</title>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" href="css/swiper.min.css">
<script type="text/javascript" src="js/swiper.min.js"></script>
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
</style>
<script type="text/javascript">
//记录点击了上一周或下一周
var weekCount = 0;

$(function() {
	
	/* 页面初始化 */
	showWeeklyPlan(weekCount);
	
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

//获取某年某周的开始日期
function getBeginDateOfWeek(paraYear, weekIndex){
	var firstDay = GetFirstWeekBegDay(paraYear);
	//7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
	var time=(weekIndex-1)*7*24*3600000;
	var beginDay = firstDay;
	//为日期对象 date 重新设置成时间 time
	beginDay.setTime(firstDay.valueOf()+time);
	return formatDate(beginDay);
}

//获取某年某周的结束日期
function getEndDateOfWeek(paraYear, weekIndex){
	var firstDay = GetFirstWeekBegDay(paraYear);
	//7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
	var time=(weekIndex-1)*7*24*3600000;
	var weekTime = 6*24*3600000;
	var endDay = firstDay;
	//为日期对象 date 重新设置成时间 time
	endDay.setTime(firstDay.valueOf()+weekTime+time);
	return formatDate(endDay);
}

//获取某年的第一天
function GetFirstWeekBegDay(year) {
	var tempdate = new Date(year, 0, 1);
	var temp = tempdate.getDay();
	if (temp == 1){
		return tempdate;
	}
	temp = temp==0?7:temp;
	tempdate = tempdate.setDate(tempdate.getDate() + (8 - temp));
	return new Date(tempdate);
}

//格式化日期：yyyy-MM-dd HH:mm:ss
function formatDate(date) {
	//年
	var year = date.getFullYear();
	//月
	var month = twoDigits(date.getMonth()+1);
	//日
	var day = twoDigits(date.getDate());
  //星期几
	var week = " 星期" + "日一二三四五六 ".charAt(date.getDay());
	//时
	var hour = twoDigits(date.getHours());
	//分
	var min = twoDigits(date.getMinutes());
	//秒
	var sec = twoDigits(date.getSeconds());

	return (year+"-"+month+"-"+day);
}

/* 月日时分秒中个位数格式化两位数 */
function twoDigits(val) {
  if (val < 10) {
  	return "0" + val;
  }
  return val;
}

/* 字符串转换成日期 */
function parseDate(dateStr){
    var dateArr = dateStr.split("-");
    var year = parseInt(dateArr[0]);
    //处理月份为04这样的情况
    var month;
    if(dateArr[1].indexOf("0") == 0){
        month = parseInt(dateArr[1].substring(1));
    }else{
         month = parseInt(dateArr[1]);
    }
    //同月份处理方式
    var day;
    if(dateArr[2].indexOf("0") == 0){
        day = parseInt(dateArr[2].substring(1));
    }else{
        day = parseInt(dateArr[2]);
    }
    var date = new Date(year,month-1,day);
    return date;
}
</script>
</head>
<body>
<!-- 标题 -->
<div class="title">
	<a href="${pageContext.request.contextPath }/main" class="pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>${classInfo.className }周计划</label>
	<a href="javascript:void(0);" class="pull-right" style="margin-right:20px;">
		<img alt="" width="20px" src="images/icons/more.svg">
	</a>
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
<script type="text/javascript">
/* 上下滑动 */
var swiper1 = new Swiper('.swiper-container', {
	direction: 'vertical',  //垂直切换选项
});
</script>
</body>
</html>
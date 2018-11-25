<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加周计划</title>
<jsp:include page="public.jsp"></jsp:include>
<script type="text/javascript" src="js/js/dateUtil.js"></script>
<script type="text/javascript">
$(function() {
	
	//获取请求地址url中的参数值
	var planId = getUrl("planId");
	var planDate = getUrl("planDate");
	console.log("planId = "+planId+", planDate = "+planDate);
	
	/* 显示周计划中具体每天的时间 */
	showDayTime(planDate);
	
	/* 点击保存按钮 */
	$("#savePlan").click(function() {
		//用FormData对象来发送二进制文件
		//FormData构造函数提供的append()方法，除了直接添加二进制文件还可以附带一些其它的参数，作为XMLHttpRequest实例的参数提交给服务端
		var formData = new FormData($("form_plan_save"));
		formData.append("id", planId);
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
		formData.append("weekPicture", $("#weekPicture")[0].files[0]);
		$.ajax({
			url: "${pageContext.request.contextPath }/weeklyPlan/saveWeeklyPlan",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("plan_save::saveWeeklyPlan:success-data = "+data);
				alert("保存成功");
			},
			error: function(data,status,e) {
				console.log("plan_save::saveWeeklyPlan:error-data = "+data);
				alert("保存失败");
			}
		});
	});
});

/* 检查上传文件的格式 */
function checkFile(file) {
    var value = $(file).val();
    var fileName = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
	if (fileName !== "png" && fileName !== "jpg" && fileName !== "jpeg" && fileName !== "gif") {
        //清除输入框后面的文件，即删除img元素
        var element = $(file).nextAll("img");
		console.log("plan_save::checkFile-element_length = "+element.length);
		if (element.length > 0) {
	    	element.eq(0).remove();
			console.log("plan_save::checkFile-element is removed.");
		}
        //清空输入框
        $(file).val("");
        //$(file).get(0).outerHTML=$(file).get(0).outerHTML.replace(/(value=\").+\"/i,"$1\"");
        alert("上传图片格式不正确，请重新上传");
    }
}

/* 显示文件 */
function showFile(file) {
	//清除输入框后面的文件，即删除img元素
    var element = $(file).nextAll("img");
	console.log("plan_save::checkFile-element_length = "+element.length);
	if (element.length > 0) {
    	element.eq(0).remove();
		console.log("plan_save::showFile-element is removed.");
	}
	//获取上传文件
	var files = $(file)[0].files;
	console.log("plan_save::showFile-files_length = "+files.length);
	if (files.length > 0) {
		//获取上传文件的绝对路径
	    var url = getObjectURL($(file)[0].files[0]);
		$(file).after('<img width="100px" alt="该图片不存在" src="'+url+'">');
	}
}

/* 获取上传文件的绝对路径 */
function getObjectURL(file) {
    var url = null ;
    if (window.createObjectURL!=undefined) { // basic
        url = window.createObjectURL(file) ;
    } else if (window.URL!=undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file) ;
    } else if (window.webkitURL!=undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file) ;
    }
    console.log("website_save::getObjectURL-url = "+url);
    return url ;
}

/* 获取请求地址url参数 */
function getUrl(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
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
	<a href="${pageContext.request.contextPath }/listWeeklyPlan.jsp" class="z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>${classInfo.className }周计划</label>
	<a id="savePlan" href="javascript:" class="z-index pull-right" style="margin-right:20px;">
		<img alt="" width="20px" src="images/icons/preservation.svg">
	</a>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
<form id="form_plan_save">
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
</form>
</div>
</body>
</html>
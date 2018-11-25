<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布微官网</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	/* 每次访问该页面时，查询是否已存在该幼儿园的微官网 */
	$.ajax({
		url: "${pageContext.request.contextPath }/website/findWebsite",
		type: "GET",
		dataType: "text",
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("website_save::findWebsite:success-data = "+data);
			//若有数据返回，则提示微官网已存在，并禁用保存按钮
			if (data!="") {
				alert("微官网已存在");
				//禁用保存按钮
				$("#saveWebsiteBtn").attr("disabled","disabled");
			}
		},
		error: function(data,status,e) {
			console.log("website_save::findWebsite:error = "+e);
			alert("读取失败");
			//禁用保存按钮
			$("#saveWebsiteBtn").attr("disabled","disabled");
		}
	});
	
	/* 点击保存按钮 */
	$("#saveWebsiteBtn").click(function() {
		//用FormData对象来发送二进制文件
		//FormData构造函数提供的append()方法，除了直接添加二进制文件还可以附带一些其它的参数，作为XMLHttpRequest实例的参数提交给服务端
		var formData = new FormData($("form_website_save"));
		formData.append("schoolIntro", $("#schoolIntro").val());
		formData.append("schoolIntroPhoto", $("#schoolIntroPicture")[0].files[0]);
		formData.append("certificateName1", $("#certificateName1").val());
		formData.append("certificatePhoto1", $("#certificatePicture1")[0].files[0]);
		formData.append("certificateName2", $("#certificateName2").val());
		formData.append("certificatePhoto2", $("#certificatePicture2")[0].files[0]);
		formData.append("certificateName3", $("#certificateName3").val());
		formData.append("certificatePhoto3", $("#certificatePicture3")[0].files[0]);
		formData.append("teacherIntro1", $("#teacherIntro1").val());
		formData.append("teacherPhoto1", $("#teacherPicture1")[0].files[0]);
		formData.append("teacherIntro2", $("#teacherIntro2").val());
		formData.append("teacherPhoto2", $("#teacherPicture2")[0].files[0]);
		formData.append("teacherIntro3", $("#teacherIntro3").val());
		formData.append("teacherPhoto3", $("#teacherPicture3")[0].files[0]);
		for(var i=0; i<$('#stuWorks')[0].files.length; i++) {
			formData.append('stuWorkPhotos', $('#stuWorks')[0].files[i]);
		}
		//console.log("website_save::fromData = "+formData);
		$.ajax({
			url: "${pageContext.request.contextPath }/website/saveWebsite",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("website_save::saveWebsite:success-data = "+data);
				alert("保存成功");
			},
			error: function(data,status,e) {
				console.log("website_save::saveWebsite:error-data = "+data);
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
		console.log("website_update::checkFile-element_length = "+element.length);
		if (element.length > 0) {
			for (var i = 0; i < element.length; i++) {
		    	element.eq(i).remove();
				console.log("website_save::checkFile-element("+i+") is removed.");
			}
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
	console.log("website_update::checkFile-element_length = "+element.length);
	if (element.length > 0) {
		for (var i = 0; i < element.length; i++) {
	    	element.eq(i).remove();
			console.log("website_save::showFile-element("+i+") is removed.");
		}
	}
	//获取上传文件
	var files = $(file)[0].files;
	console.log("website_save::showFile-files_length = "+files.length);
	if (files.length > 0) {
		for (var i = 0; i < files.length; i++) {
			//获取上传文件的绝对路径
		    var url = getObjectURL($(file)[0].files[i]);
			$(file).after('<img width="100px" alt="该图片不存在" src="'+url+'">');
		}
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
</script>
</head>
<body>
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
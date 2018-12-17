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
	
	//从session作用域中获取schoolId
	//var schoolId = '${sessionScope.schoolId }';
	var schoolId = 1;//测试用
	
	/* 每次访问该页面时，查询是否已存在该幼儿园的微官网 */
	var data = new FormData();
	data.append("schoolId", schoolId);
	$.ajax({
		url: "${pageContext.request.contextPath }/website/findWebsite",
		type: "POST",
		data: data,
		dataType: "json",
		async: true,         //同步或异步请求方式，默认为true，异步
		cache: false,
		processData: false,  //不要对data参数进行序列化处理，默认为true
		contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("website_save::findWebsite:success-data = "+data);
			//若有数据返回，则提示微官网已存在，并禁用保存按钮
			if (data != null) {
				alert("微官网已存在");
				$("#saveWebsiteBtn").attr("disabled","disabled");
			}
		},
		error: function(data,status,e) {
			console.log("website_save::findWebsite:error-data = "+data);
			alert("读取失败");
		}
	});
});

/* 显示文件 */
function showFile(file) {
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
</script>
</head>
<body>
<div class="container">
	<!-- 首页（幼儿园信息） -->
	<div class="row">
		<div class="col-xs-4"></div>
		<div class="col-xs-4 text-center"><h3>宝贝示范园</h3></div>
		<div class="col-xs-4"></div>
	</div>
	<div class="row">
		<div class="col-xs-3"></div>
		<div class="col-xs-6"><p>dsfahfhadskjfhkasjdhfjkashdfkjdas</p></div>
		<div class="col-xs-3"></div>
	</div>
	<div class="row">
		<div class="col-xs-3"></div>
		<div class="col-xs-6"><img alt="ss" width="300px" src="E:/图片/刀剑神域/135633dnd84y2j9jhbnv42.jpg"></div>
		<div class="col-xs-3"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-3"><strong>地址</strong></div>
		<div class="col-xs-5"><span>faskfasdklhfsdaj</span></div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-3"><strong>电话</strong></div>
		<div class="col-xs-5"><span>12345678</span></div>
		<div class="col-xs-2"></div>
	</div>
	
	<!-- 校园简介 -->
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 text-center"><h3>校园简介</h3></div>
		<div class="col-xs-8"></div>
	</div>
	<div class="row">
		<div class="col-xs-3"></div>
		<div class="col-xs-6"><img alt="ss" width="300px" src="E:/图片/刀剑神域/135633dnd84y2j9jhbnv42.jpg"></div>
		<div class="col-xs-3"></div>
	</div>
	<div class="row">
		<div class="col-xs-3"></div>
		<div class="col-xs-6"><p>dsfahfhadskjfhkasjdhfjkashdfkjdas</p></div>
		<div class="col-xs-3"></div>
	</div>
</div>
</body>
</html>
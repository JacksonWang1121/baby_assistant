<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代接送</title>
<jsp:include page="public.jsp"></jsp:include>
<script type="text/javascript" src="js/js/fileUtil.js"></script>
<style type="text/css">
.nav {
	width: 100%;
	padding-top: 48px;
	position: fixed;
	background-color: #fff;
}
.container {
	padding-top: 100px;
}
</style>
<script type="text/javascript">
$(function() {

	/* 代接按钮注册事件 */
	$("#send").bind('click', function() {
		//手动触发点击事件
		$("#takePicture").click();
	});

	/* 拍照或选择相册后input框发生改变的注册事件 */
	$("#takePicture").on('change', function() {
		/* var file = $("#takePicture")[0].files[0];
		var filePath = getObjectURL(file);
		var ss = window.sessionStorage;
		ss.setItem("personPhoto", filePath);
		ss.setItem("personPhotoVal", $("#takePicture").val());
		window.location.href = "saveGenerateSend.jsp"; */
		
		var formData = new FormData();
		formData.append("personPhoto", $("#takePicture")[0].files[0]);
		$.ajax({
			url: "${pageContext.request.contextPath }/generateSend/takePicture",
			type: "POST",
			data: formData,
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("listGenerateSend::takePicture:success-data = "+data);
				if (data == null) {
					alert("上传文件失败");
				} else {
					var ss = window.sessionStorage;
					ss.setItem("send_person_photo", data);
					window.location.href = "saveGenerateSend.jsp";
				}
			},
			error: function(data,status,e) {
				console.log("listGenerateSend::takePuicture-error = "+e);
				alert("上传文件失败");
			}
		});
		
		//$("#form_take_picture").submit();
	});

	/* 待确定注册事件 */
	$("#pending").bind('click', function() {
		$(".container").html('<iframe style="width:100%;height:500px;" frameborder="0" allowTransparency="true" '
				+'src="${pageContext.request.contextPath }/generateSend/listGenerateSendPending"></iframe>');
	});

	/* 已确定注册事件 */
	$("#confirmed").bind('click', function() {
		$(".container").html('<iframe style="width:100%;height:500px;" frameborder="0" allowTransparency="true" '
				+'src="${pageContext.request.contextPath }/generateSend/listGenerateSendConfirmed"></iframe>');
	});
	
	/* 初始显示待审核页面*/
	$("#pending").click();
});
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="${pageContext.request.contextPath }/main" class="z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>代接送</label>
	<!-- 只有教师和园长才有此权限 -->
	<shiro:hasPermission name="send:save">
		<a id="send" href="javascript:" class="z-index pull-right" style="margin-right:20px;">
			<img alt="" width="20px" src="images/icons/take_pictures.svg">
		</a>
		<%-- <form id="form_take_picture" action="${pageContext.request.contextPath }/generateSend/takePicture" method="post" enctype="multipart/form-data"> --%>
		<input type="file" id="takePicture" accept="image/*" style="display:none;">
	</shiro:hasPermission>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<ul class="nav nav-tabs text-center" role="tablist">
	<li style="width:50%"><a id="pending" href="javascript:">待确认</a></li>
	<li style="width:50%"><a id="confirmed" href="javascript:">已确认</a></li>
</ul>
<div class="container"></div>
</body>
</html>
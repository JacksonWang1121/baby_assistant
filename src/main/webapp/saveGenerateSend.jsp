<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代接</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.container {
	margin-top: 52px;
}
</style>
<script type="text/javascript">
//记录表单是否已提交，默认未提交
var isFormSubmit = false;

$(function() {

	var ss = window.sessionStorage;
	var filePath = ss.getItem("send_person_photo");
	var description = ss.getItem("send_description");
	var clsName = ss.getItem("send_cls_name");
	var babyName = ss.getItem("send_baby_name");
	var babyId = ss.getItem("send_baby_id");
	var parentId = ss.getItem("send_parent_id");
	console.log("saveGenerateSend::takePicture-personPhoto = " + filePath 
			+ ", description = "+ description + ", clsName = " + clsName 
			+ ", babyName = " + babyName + ", babyId = " + babyId 
			+ ", parentId = " + parentId);
	$("#personPhoto").html(
			'<img alt="该图片不存在" src="'+filePath+'" width="200px">');
	if (description != null) {
		$("#description").val(description);
	}
	if (babyName == null) {
		$("#babyName").html("");
	} else {
		$("#babyName").html('<strong>代接的宝贝：</strong>' + clsName + ' ' + babyName);
	}

	$("#chooseBaby").bind('click', function() {
		//将描述的内容存放到sessionStorage中
		ss.setItem("send_description", $("#description").val());
		window.location.href = "${pageContext.request.contextPath }/chooseBaby";
	});

	/* 点击保存按钮 */
	$("#saveSend").click(function() {
		//用FormData对象来发送二进制文件
		//FormData构造函数提供的append()方法，除了直接添加二进制文件还可以附带一些其它的参数，作为XMLHttpRequest实例的参数提交给服务端
		var formData = new FormData();
		formData.append("parentId", parentId);
		formData.append("babyId", babyId);
		formData.append("babyName", babyName);
		//判断描述文本域的内容是否为空
		description = $("#description").val();
		if (description=="" || description==null) {
			description = "让TA代接您的宝贝吗？";
		}
		formData.append("description", description);
		formData.append("personPicture", filePath);
		$.ajax({
			url : "${pageContext.request.contextPath }/generateSend/saveGenerateSend",
			type : "POST",
			data : formData,
			dataType : "text",
			async : true, //同步或异步请求方式，默认为true，异步
			cache : false,
			processData : false, //不要对data参数进行序列化处理，默认为true
			contentType : false, //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success : function(data, status) {
				// 根据返回结果指定界面操作
				console.log("saveGenerateSend::saveSend:success-data = " + data);
				if (data == "true") {
					//标记表单已提交
					isFormSubmit = true;
					window.location.href = "listGenerateSend.jsp";
				} else {
					alert("发送失败");
				}
			},
			error : function(data, status, e) {
				console.log("saveGenerateSend::saveSend:error = " + e);
				alert("发送失败");
			}
		});
	});

	// 页面的 visibility 属性可能返回三种状态
	// prerender，visible 和 hidden
	//let pageVisibility = document.visibilityState;
	// 监听 visibility change 事件
	document.addEventListener('visibilitychange', function() {
		// 页面变为不可见时触发 
		if (document.visibilityState == 'hidden') {
			//若离开页面时表单未提交，提示用户是否取消本次表单提交
			if (!isFormSubmit) {
				if (confirm("是否结束本次代接送信息的发送？")) {
					//标记表单未提交
					isFormSubmit = false;
					//删除之前的图片
					window.location.href = "${pageContext.request.contextPath }/generateSend/deletePersonPicture?personPhoto="+filePath;
				} else {
					//标记表单未提交
					isFormSubmit = false;
					return;
				}
			}
		} 
		// 页面变为可见时触发 
		//if (document.visibilityState == 'visible') {} 
	});
});
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="listGenerateSend.jsp" class="icon-z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>代接</label>
	<a id="saveSend" href="javascript:" class="icon-z-index pull-right" style="margin-right:20px;">
		<img alt="" width="20px" src="images/icons/checkmark.svg">
	</a>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-4"><h3>代接人</h3></div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center" id="personPhoto"></div>
	</div>
	<div class="row" style="margin-top:10px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-4"><h3>描述</h3></div>
	</div>
	<div class="row">
		<div class="col-xs-12 text-center">
			<textarea rows="5" cols="30" id="description"></textarea>
		</div>
	</div>
	<div class="row" style="margin-top:10px;">
		<div class="col-xs-12 text-center">
			<button id="chooseBaby" class="btn btn-success" style="width:60%">选择代接的宝贝</button>
		</div>
	</div>
	<div class="row" style="margin-top:5px;">
		<div class="col-xs-12 text-center" id="babyName"></div>
	</div>
</div>
</body>
</html>
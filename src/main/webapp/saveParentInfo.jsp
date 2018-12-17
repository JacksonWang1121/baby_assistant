<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>完善个人资料</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
#return {
	/* border:1px red solid; */
	float: left;
	margin-left: 18px;
}
#userIcon {
	display:none;
}
#confirm {
	float: right;
	margin-right: 18px;
}
</style>
<script type="text/javascript">
$(function() {
	
	$.ajax({
		url: "${pageContext.request.contextPath }/findUser",
		type: "POST",
		dataType: "json",
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("saveParentInfo:success-data = "+data);
			//若有数据返回，则显示到相应的位置
			$("#headPortrait").attr("src",data.userIcon);
			$("#realName").val(data.realName);
			$("#nickName").val(data.nickName);
			$("#personalitySignature").val(data.personalitySignature);
			$("#address").val(data.address);
		},
		error: function(data,status,e) {
			console.log("saveParentInfo:error-data = "+data);
			alert("读取失败");
		}
	});
	
	/* 点击返回按钮 */
	$("#return").click(function() {
		//提示  
        new TipBox({
            type: 'tip',
            str: '确定退出？',
            clickDomCancel: true,
            setTime: 10000500,
            hasBtn: true,
            callBack: function() {
            	window.location.href = "${pageContext.request.contextPath }/doLogout";
            }
        });
		/* if (confirm("确定退出？")) {
			window.location.href = "${pageContext.request.contextPath }/doLogout";
		} */
	});
	
	/* 点击头像图片热点链接区域 */
	$("#headPortrait").click(function() {
		//直接执行选择文件
		$("#userIcon").click();
	});
	
	/* 点击保存按钮 */
	$("#confirm").click(function() {
		var formData = new FormData($("#form_parent_save"));
		if ($("#userIcon")) {
			formData.append("headPortrait", $("#userIcon")[0].files[0]);
		}
		formData.append("realName", $("#realName").val());
		formData.append("nickName", $("#nickName").val());
		formData.append("personalitySignature", $("#personalitySignature").val());
		formData.append("address", $("#address").val());
		$.ajax({
			url: "${pageContext.request.contextPath }/saveParent",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("saveParentInfo::confirm:success-data = "+data);
				//若有数据返回，则提示微官网已存在，并禁用保存按钮
				if (data == "true") {
					window.location.href = "saveBabyInfo.jsp";
				} else {
					alert("保存失败");
				}
			},
			error: function(data,status,e) {
				console.log("saveParentInfo::confirm:error-data = "+data);
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
		console.log("saveParentInfo::checkFile-element_length = "+element.length);
		if (element.length > 0) {
		    element.eq(0).remove();
			console.log("saveParentInfo::checkFile-element is removed.");
		}
        //清空输入框
        $(file).val("");
        //$(file).get(0).outerHTML=$(file).get(0).outerHTML.replace(/(value=\").+\"/i,"$1\"");
        alert("上传图片格式不正确，请重新上传");
    }
}

/* 显示文件 */
function showFile(file) {
	//获取上传文件
	var files = $(file)[0].files;
	console.log("saveParentInfo::showFile-files_length = "+files.length);
	if (files.length > 0) {
		//获取上传文件的绝对路径
	    var url = getObjectURL($(file)[0].files[0]);
		$(file).prev("img").attr("src",url);
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
<div class="">
	<!-- 标题 -->
	<div class="title">
		<a id="return" href="javascript:">
			<img width="50px" alt="errror" src="images/return.svg">
		</a>
		<span style="width:100%;">完善个人资料</span>
		<a href="javascript:">
			<img id="confirm" width="50px" alt="errror" src="images/confirm.svg">
		</a>
	</div>
	<!-- 清除浮动 -->
	<div class="clearfix"></div>
	
<form action="" id="form_parent_save">
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>头像</strong></div>
		<div class="col-xs-6">
			<a href="javascript:">
				<img  id="headPortrait" width="100px" alt="errror" src="images/head_portrait.svg">
				<input type="file" name="userIcon" id="userIcon" onchange="checkFile(this);showFile(this)" accept="image/*"/>
			</a>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>姓名</strong></div>
		<div class="col-xs-6 content">
			<input type="text" name="realName" id="realName" />
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>昵称</strong></div>
		<div class="col-xs-6 content">
			<input type="text" name="nickName" id="nickName" />
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>联系电话</strong></div>
		<div class="col-xs-6 content">
			<input type="text" value="${username }" disabled="disabled" />
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>个人签名</strong></div>
		<div class="col-xs-6 content">
			<textarea rows="3" cols="24" name="personalitySignature" id="personalitySignature"></textarea>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>家庭住址</strong></div>
		<div class="col-xs-6 content">
			<textarea rows="3" cols="24" name="address" id="address"></textarea>
		</div>
	</div>
</form>
</div>
</body>
</html>
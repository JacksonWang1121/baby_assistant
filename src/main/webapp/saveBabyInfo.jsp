<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>完善宝贝资料</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
#return {
	/* border:1px red solid; */
	float: left;
	margin-left: 18px;
}
#babyIcon {
	display:none;
}
.sex {
	width: 60px;
}
#birthday {
	/* height: 60px; */
}
#relationship {
	width: 100px;
	height: 60px;
}
#confirm {
	float: right;
	margin-right: 18px;
}

label{
  position: relative;
  top: 14px;
  font-size: 32px;
  line-height: 16px;
}
input[type="radio"]{
  display: none;
}
input[type='radio']+label:before{
  margin-top: -2px;
  content: '';
  display: inline-block;
  width: 36px;
  height: 36px;
  margin-right: 6px;
  border-radius: 100%;
  vertical-align: middle;
  border: 1px solid #E4E4E4;
  background: #FFFFFF;
}
 
input[type='radio']:checked+label:before{
  background-image: url('images/checkmark.png');
  background-position: center center;
  /*background: #777777;*/
}
</style>
<script type="text/javascript">
$(function() {
	
	$.ajax({
		url: "${pageContext.request.contextPath }/findBaby",
		type: "POST",
		dataType: "json",
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("saveBabyInfo::findBaby:success-data = "+data);
			//若有数据返回，则显示到相应的位置
			if (data.baby_icon != null) {
				$("#headPortrait").attr("src",data.baby_icon);
			}
			$("#babyName").val(data.baby_name);
			if (data.sex == "男") {
				$(':radio[value="男"]').attr("checked","checked");
			} else if (data.sex == "女") {
				$(':radio[value="女"]').attr("checked","checked");
			}
			$("#birthday").val(data.birthday);
			$("#relationship").val(data.relationship);
		},
		error: function(data,status,e) {
			console.log("saveBabyInfo::findBaby:error = "+e);
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
		$("#babyIcon").click();
	});
	
	/* 点击保存按钮 */
	$("#confirm").click(function() {
		var formData = new FormData($("#form_baby_save"));
		if ($("#babyIcon")) {
			formData.append("headPortrait", $("#babyIcon")[0].files[0]);
		}
		formData.append("babyName", $("#babyName").val());
		formData.append("sex", $(".sex:checked").val());
		formData.append("birthday", $("#birthday").val());
		formData.append("relationship", $("#relationship").val());
		$.ajax({
			url: "${pageContext.request.contextPath }/saveBaby",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("saveBabyInfo::confirm:success-data = "+data);
				//若有数据返回，则提示微官网已存在，并禁用保存按钮
				if (data == "true") {
					window.location.href = "${pageContext.request.contextPath }/main";
				} else {
					alert("保存失败");
				}
			},
			error: function(data,status,e) {
				console.log("saveBabyInfo::confirm:error = "+e);
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
		if (element.length > 0) {
		    element.eq(0).remove();
			console.log("saveBabyInfo::checkFile-element is removed.");
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
		<span style="width:100%;">完善宝贝资料</span>
		<a href="javascript:">
			<img id="confirm" width="50px" alt="errror" src="images/confirm.svg">
		</a>
	</div>
	<!-- 清除浮动 -->
	<div class="clearfix"></div>
	
<form action="" id="form_baby_save">
	<div class="row" style="margin-top: 20px;">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>头像</strong></div>
		<div class="col-xs-6">
			<a href="javascript:">
				<img  id="headPortrait" width="100px" alt="errror" src="images/head_portrait.svg">
				<input type="file" name="babyIcon" id="babyIcon" onchange="checkFile(this);showFile(this)" accept="image/*"/>
			</a>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>姓名</strong></div>
		<div class="col-xs-6 content">
			<input type="text" name="babyName" id="babyName" />
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>性别</strong></div>
		<div class="col-xs-6 content">
			<input type="radio" name="sex" value="男" class="sex" id="man">
        	<label for="man">男</label>
       		<input type="radio" name="sex" value="女" class="sex" id="female">
        	<label for="female">女</label>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>出生日期</strong></div>
		<div class="col-xs-6 content">
			<input type="text" class="Wdate" name="birthday" id="birthday" onclick="WdatePicker({'dateFmt':'yyyy-MM-dd'})"/>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-3 content"><strong>与宝宝的关系</strong></div>
		<div class="col-xs-6 content">
			<select id="relationship" name="relationship">
				<option value="爸爸">爸爸</option>
				<option value="妈妈">妈妈</option>
				<option value="爷爷">爷爷</option>
				<option value="奶奶">奶奶</option>
				<option value="姥爷">姥爷</option>
				<option value="姥姥">姥姥</option>
				<option value="哥哥">哥哥</option>
				<option value="姐姐">姐姐</option>
				<option value="其他">其他</option>
			</select>
		</div>
	</div>
</form>
</div>
</body>
</html>
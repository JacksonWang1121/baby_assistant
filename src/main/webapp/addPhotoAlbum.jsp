<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加班级作业</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
.coverReturn {
	border: 1px solid #00FA9A;
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}

.coverSave {
	border: 1px solid #00FA9A;
	width: 100px;
	height: 70px;
	position: absolute;
	right: 2px;
	z-index: 100;
	cursor: pointer;
}
#homeworkContent{
width: 100%;
	height: 400px;
	size:100px;
	
	
}

}
</style>
<script type="text/javascript">
	$(function() {

		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function() {
			window.location.href = "/babyassistant/listHomeworkByClassId";
		});
		$("#tianjia").click(function() {
			var  photoAddress=$("#imagePath").val();
			alert("aaaaas")
			$.ajax({
				url:"/babyassistant/savePhotoAlbum",//发送请求地址
				type:"post",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"photoAddress":photoAddress},
				success:function(data){//请求成功后回调函数
					if (data=="true") {
						alert("保存成功")			
					} else {
						alert("保存失败")
					}							
				},
				error:function(){//请求失败后回调函数
					alert('后台报错')
				} 
			});

		});
		$('#imagePath').on('change',function(){
			//获取到input的value，里面是文件的路径
		    var filePath = $(this).val();      
		    fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    // 检查是否是图片
		    if( !fileFormat.match(/.png|.jpg|.jpeg/) ) {
		    	error_prompt_alert('上传错误,文件格式必须为：png/jpg/jpeg');
		        return;  
		    }
		    $('#dImg').attr('src',src);
		    $("#classImg").val(filePath);
		});
	});
</script>
</head>
<body>
	<div>
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="coverReturn"></span> <span
				style="margin-left: 260px; margin-right: 260px;">添加班级相册</span> <span
				class="glyphicon glyphicon-saved" id="photoAlbum"></span> <span
				class="coverSave"></span>
		</div>
		<div>
			<form action="savePhotoAlbum" id="savePhotoAlbum">

		<table class="table table-bordered" style="font-size:40px" >
        <th><span>图片</span></th>
							<td >
								<img id="dImg" name="dImg">
							</td>
							<td>
								<input type="file" id="imagePath" name="imagePath">
								<input type="text" id="classImg" name="classImg" hidden="hidden">
							</td>

</table>
			</form>

			<button id="tianjia"> sssssssss</button>
		</div>
	</div>
</body>
</html>
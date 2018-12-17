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
			var filePath=$("#photoImg").val();
		
			var startIndex = filePath.lastIndexOf("/");
		     var  photoAddress= filePath.substring(startIndex+1, filePath.length).toLowerCase();
			
			
			
			    //创建formdata对象，formData用来存储表单的数据，表单数据时以键值对形式存储的。
			    var formData = new FormData($("savePhotoAlbum"));
			    formData.append('photoAddress', photoAddress);
			    formData.append("file", $("#photoPath")[0].files[0]);
			alert(photoAddress)
			
			$.ajax({
				url:"/babyassistant/savePhotoAlbum",//发送请求地址
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
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
		
		$('#photoPath').on('change',function(){
			 
			//获取到input的value，里面是文件的路径
		    var filePath = $(this).val();      
		    type = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    // 检查是否是图片
		    if(type!=".jpg"&&type!=".gif"&&type!=".jpeg"&& type!=".png"){
				 alert("您上传图片的类型不符合(.jpg|.jpeg|.gif|.png)！");
				 return false;
		    }
		    $('#bImg').attr('src',src);
		    $("#photoImg").val(filePath);
	
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
							
							<td>
								<img id="bImg" name="bImg">
							</td>
							
							<td>
								<input type="file" id="photoPath" name="photoPath" class="form-control">
								<input type="text" id="photoImg" name="photoImg" hidden="hidden">
							</td>
							
						</tr>
			
				</table>
			</form>

			<button id="tianjia"> sssssssss</button>
		</div>
	</div>
</body>
</html>
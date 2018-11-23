<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改头像</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/updateIcon.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:1px;
		z-index:100;
		cursor: pointer;
	}
	.coverSave{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}
	input{
		width:400px;
	}
	div{
		margin-bottom:3%;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/getPersonalData";	
		});
		 
		/* 上传头像 */
		$('#userImg').on('change',function(){
			//获取到input的value，里面是文件的路径
		    var filePath = $(this).val();      
		    fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    // 检查是否是图片
		    if( !fileFormat.match(/.png|.jpg|.jpeg/) ) {
		    	error_prompt_alert('上传错误,文件格式必须为：png/jpg/jpeg');
		        return;  
		    }
		    $('#uImg').attr('src',src);
		    $("#iconPath").val(filePath);
		});
		//点击保存图标修改头像
		$(".coverSave").click(function(){
			 var formData = new FormData($("dietForm"));
			formData.append("iconPath", $("#userImg")[0].files[0]);
			$.ajax({
				url:"${pageContext.request.contextPath }/updateUserIcon",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						window.location.href="${pageContext.request.contextPath }/getPersonalData";
					}else{
						/* 若头像上传失败，给出提示信息 */
						new TipBox({type:'tip',str:'上传失败!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
			});	
		}); 
	});
</script>
</head>
<body>
	<div>
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:310px;margin-right:310px;">修改头像</span>
			<span class="glyphicon glyphicon-saved" id="diet"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="container" style="font-size:30px;margin-top:40%;margin-left:20%;">
			<form action="updateUserIcon" id="iconForm">
				<div class="col-xs-12">
					<input type="file" id="userImg" name="userImg">
					<input type="text" id="iconPath" name="iconPath" hidden="hidden">
				</div>
				<div class="col-xs-12" id="userIcon">
					<img src="" id="uImg" name="uImg" style="width:400px;height:400px;border:solid rgb(30,30,30) 0px;">
				</div>
			</form>
		</div>
	</div>
</body>
</html>
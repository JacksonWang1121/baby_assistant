<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝宝资料</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/mebg3.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:120px;
		height:70px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
	}
	.coverSave{
		border:1px solid #00FA9A;
		width:120px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}
	input {
		width:400px;
	}
	select{
		width:400px;
		height:50px;
	}
	#sex{
		width:25px;
		height:25px;
	}
	.col-xs-4{
		margin-bottom:10%;
	}
	.col-xs-8{
		margin-bottom:10%;
	}
</style>
<script type="text/javascript">
	$(function(){
		//将获取的性别值赋给单选按钮
		var sex=$("#babySex").val();
		$("#sex[value='"+sex+"']").attr("checked", true);
		//将获取的与宝宝关系值赋给下拉框
		var relation=$("#relation").val();
		$("#relationship option[value='"+relation+"']").attr("selected", true);
		
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/getPersonalHomePage";	
		});
		//点击头像跳转到头像修改界面
		$("#babyIcon").click(function(){
			window.location.href="/babyassistant/updateBabyIcon.jsp";	
		}); 
		
		//点击个人资料
		$("#parentData").click(function(){
			window.location.href="/babyassistant/getPersonalData";	
		});
		//点击宝宝资料
		$("#babyData").click(function(){
			window.location.href="/babyassistant/getBabyDataByParentId";	
		});
		//点击保存图标修改宝宝信息
		$(".coverSave").click(function(){
			var formData = new FormData($("dietForm"));
			formData.append("babyName", $("#babyName").val());
			formData.append("sex", $('input[name="sex"]:checked').val());
			formData.append("birthday", $("#birthday").val());
			formData.append("relationship", $("#relationship option:selected").val());
			$.ajax({
				url:"${pageContext.request.contextPath }/updateBabyData",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						window.location.href="${pageContext.request.contextPath }/getBabyDataByParentId";
					}else{
						/* 若头像上传失败，给出提示信息 */
						new TipBox({type:'tip',str:'宝宝信息查询失败，请稍后再试!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
			});	
		});
		/* 上传头像 */
		$('#breakfastPath').on('change',function(){
			//获取到input的value，里面是文件的路径
		    var filePath = $(this).val();      
		    fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    // 检查是否是图片
		    if( !fileFormat.match(/.png|.jpg|.jpeg/) ) {
		    	error_prompt_alert('上传错误,文件格式必须为：png/jpg/jpeg');
		        return;  
		    }
		    $('#bImg').attr('src',src);
		    $("#breakfastImg").val(filePath);
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
			<span style="margin-left:160px;margin-right:160px;"><span id="parentData">个人资料</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="babyData">宝宝资料</span></span>
			<span class="glyphicon glyphicon-saved" id="diet"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="container"  style="font-size:35px;background-color:white;margin-top:10%;border-radius:80px;">
			<form id="babyForm">
				<div class="col-xs-4"style="margin-top:10%;">我的头像</div>
				<div class="col-xs-8" id="babyIcon"style="margin-top:10%;">
					<img src="${baby.baby_icon}" id="bImg" name="bImg" style="width:100px;height:100px;border-radius:90px;border:solid rgb(30,30,30) 0px;">
				</div>
				<div class="col-xs-4">宝宝姓名</div>
				<div class="col-xs-8"><input type="text" value="${baby.baby_name}" id="babyName" name="babyName"></div>
				<div class="col-xs-4">性别</div>
				<div class="col-xs-8">
					<input type="text" value="${baby.sex}" id="babySex" name="babySex" hidden="hidden">
					<input type="radio" id="sex" name="sex" value="男">男
					<input type="radio" id="sex" name="sex" value="女">女
				</div>
				<div class="col-xs-4">出生日期</div>
				<div class="col-xs-8">
					<input type="text" id="birthday" name="birthday" value="${baby.birthday}" class="Wdate" style="height:50px;font-size:35px;" onClick="WdatePicker({el:this})"/>
				</div>
				<div class="col-xs-4">入园时间</div>
				<div class="col-xs-8"><input type="text" value="${baby.enter_date}" id="registrationDate" name="registrationDate" disabled="disabled"></div>
				<div class="col-xs-4">所在班级</div>
				<div class="col-xs-8"><input type="text" value="${baby.class_name}" id="className" name="className" disabled="disabled"></div>
				<div class="col-xs-4">宝宝学号</div>
				<div class="col-xs-8"><input type="text" value="${baby.baby_no}" id="babyNo" name="babyNo" disabled="disabled"></div>
				<div class="col-xs-4">与宝宝的关系</div>
				<div class="col-xs-8"><input type="text" value="${baby.relationship}" id="relation" name="relation" hidden="hidden">
					<select id="relationship" name="relationship">
						<option value="父亲">父亲</option>
						<option value="母亲">母亲</option> 
						<option value="祖父祖母">祖父/祖母</option> 
						<option value="外祖父祖母">外祖父/祖母</option>  
					</select> 
				</div>
			</form>
		</div>
	</div>
</body>
</html>
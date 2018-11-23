<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布宝宝食谱</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/babydiet1.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:13px;
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
	.content{
		margin-bottom:10px;
	}
	.form-control{
		width:320px;
		height:60px;
		font-size:40px;
	}
	.Wdate{
		width:320px;
		height:60px;
		font-size:40px;
	}
	#save{
		width:160px;
		height:80px;
		font-size:40px;
	}
	img{
		width:320px;
		height:220px;
	}
	input{
		width:320px;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="${pageContext.request.contextPath }/getBabyDietByDate";	
		});
		//页面加载完毕通过ajax根据输入的日期获取食谱信息，若已存在提示已存在
		$("#dietDate").blur(function(){
			//获取文本框的值
			var dietDate=$(this).val();
			$.ajax({
				url:"${pageContext.request.contextPath }/isExistBabyDietOfThisDate?dietDate="+dietDate,
				type:"get",
				dataType:"json",
				success:function(data){
					if(data==true){
						/* 若输入的日期已存在食谱，给出提示信息 */
						new TipBox({type:'tip',str:'当前日期的食谱信息已存在!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
						$(".form-control").attr("disabled",true);//将input框设置为不可编辑
					}else{
						$(".form-control").attr("disabled",false);//将input框设置为可编辑
					}
				}   
			});
		});	
		//点击保存图标发布宝宝食谱
		$(".coverSave").click(function(){
			var formData = new FormData($("dietForm"));
			formData.append("dietDate", $("#dietDate").val());
			formData.append("breakfast", $("#breakfast").val());
			formData.append("lunch", $("#lunch").val());
			formData.append("dinner", $("#dinner").val());
			formData.append("breakfastPicture", $("#breakfastPath")[0].files[0]);
			formData.append("lunchPicture", $("#lunchPath")[0].files[0]);
			formData.append("dinnerPicture", $("#dinnerPath")[0].files[0]);
			$.ajax({
				url:"${pageContext.request.contextPath }/saveBabyDiet",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						/* 若录入食谱失败，给出提示信息 */
						new TipBox({type:'tip',str:'宝宝食谱录入成功!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}else{
						/* 若录入食谱失败，给出提示信息 */
						new TipBox({type:'tip',str:'宝宝食谱录入失败!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
			});
		});
		
		/* 上传早饭图片 */
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
		/* 上传午饭图片 */
		$('#lunchPath').on('change',function(){
			//获取到input的value，里面是文件的路径
		    var filePath = $(this).val();      
		    fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    // 检查是否是图片
		    if( !fileFormat.match(/.png|.jpg|.jpeg/) ) {
		    	error_prompt_alert('上传错误,文件格式必须为：png/jpg/jpeg');
		        return;  
		    }
		    $('#lImg').attr('src',src);
		    $("#lunchImg").val(filePath);
		});
		/* 上传晚饭图片 */
		$('#dinnerPath').on('change',function(){
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
		    $("#dinnerImg").val(filePath);
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
			<span style="margin-left:260px;margin-right:260px;">发布宝宝食谱</span>
			<span class="glyphicon glyphicon-saved" id="diet"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div>
			<form id="dietForm">
				<table class="table table-bordered" style="font-size:40px" >
					<tbody>
						<tr>
							<th><span>食谱应用日期</span></th>
							<td colspan="2">
								<input type="text" id="dietDate" name="dietDate" class="Wdate" onClick="WdatePicker({el:this})"/>
							</td>
						</tr>
						<tr>
							<th><span>早饭名称</span></th>
							<td colspan="2">
								<input  id="breakfast" name="breakfast" class="form-control">
							</td>
						</tr>
						<tr>
							<th><span>午饭名称</span></th>
							<td colspan="2">
								<input  id="lunch" name="lunch" class="form-control">
							</td>
						</tr>
						<tr>
							<th><span>晚饭名称</span></th>
							<td colspan="2">
								<input id="dinner" name="dinner" class="form-control">
							</td>
						</tr>
						<tr>
							<th><span>早饭图片</span></th>
							<td >
								<img id="bImg" name="bImg">
							</td>
							<td>
								<input type="file" id="breakfastPath" name="breakfastPath" class="form-control">
								<input type="text" id="breakfastImg" name="breakfastImg" hidden="hidden">
							</td>
						</tr>
						<tr>
							<th><span>午饭图片</span></th>
							<td >
								<img id="lImg" name="lImg">
							</td>
							<td>
								<input type="file" id="lunchPath" name="lunchPath" class="form-control">
								<input type="text" id="lunchImg" name="lunchImg" hidden="hidden">
							</td>
						</tr>
						<tr>
							<th><span>晚饭图片</span></th>
							<td >
								<img id="dImg" name="dImg">
							</td>
							<td>
								<input type="file" id="dinnerPath" name="dinnerPath" class="form-control">
								<input type="text" id="dinnerImg" name="dinnerImg" hidden="hidden">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
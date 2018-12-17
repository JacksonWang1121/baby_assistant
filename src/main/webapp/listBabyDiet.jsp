<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看宝宝食谱</title>
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
		left:2px;
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
	.Wdate{
		width:700px;
		height:60px;
		font-size:40px;
	}
	#search{
		width:145px;
		height:60px;
		font-size:40px;
	}
	#update{
		width:160px;
		height:80px;
		font-size:40px;
	}
	img{
		width:400px;
		height:220px;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/main";	
		});
		//点击添加图标 
		$(".coverSave").click(function(){
			window.location.href="/babyassistant/saveBabyDiet.jsp";	
		});
		/* 点击修改按钮 */
		var dietDate=$("#dDate").val();
		    $("#update").click(function(){
				$.ajax({
					url:'isBeforeCurrentDate',
					async : false,
					type:'get',
					dataType:'json',
					data:{'dietDate':dietDate},
					success:function(data){
						if(data=="null"){
							/* 若选中的食谱日期为空，给出提示信息 */
							new TipBox({type:'tip',str:'未上传的食谱不能修改!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
						}
						else if(data=="true"){
							/* 若选中的食谱在当前日期之前，给出提示信息 */
							new TipBox({type:'tip',str:'食谱已采用，不能修改!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
						}else{
							window.location.href="/babyassistant/toupdateBabyDiet?dietDate="+dietDate;
						}
					}
				}); 
		});
	});
</script>
</head>
<body>
	<div id="container">
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:310px;margin-right:310px;">宝宝饮食</span>
			<shiro:hasPermission name="baby:saveDiet">
				<span class="glyphicon glyphicon-plus-sign" id="sign"></span>
				<span class="coverSave"></span>
			</shiro:hasPermission>
		</div>
		<!-- 条件查询 -->
		<div class="content" style="margin-top:2%;margin-bottom:3%;">
			<form action="listBabyDietByTerm">
				<span>日期</span>
				<input type="text" name="dietDate" id="dietDate" class="Wdate" onClick="WdatePicker({el:this})"/>
				<input type="submit" value="查询" class="btn btn-success" id="search">
			</form>
		</div>
		<!-- 页面主要内容 -->
		<div>
			<table class="table table-bordered" style="font-size:40px">
				<tbody>
					<tr>
						<th colspan="2">食谱应用日期</th>
					</tr>
					<tr>
						<td colspan="2">${diet.diet_date}</td>
					</tr>
					<tr>
						<th>早饭</th>
						<td rowspan="2"><img src="${diet.breakfast_img}"></td>
					</tr>
					<tr>
						<td>${diet.breakfast}</td>
					</tr>
					<tr>
						<th>午饭</th>
						<td rowspan="2"><img src="${diet.lunch_img}"></td>
					</tr>
					<tr>
						<td>${diet.lunch}</td>
					</tr>
					<tr>
						<th>晚饭</th>
						<td rowspan="2"><img src="${diet.dinner_img}"></td>
					</tr>
					<tr>
						<td>${diet.dinner}</td>
						<input value="${diet.diet_date}" id="dDate" name="dDate" hidden="hidden">
					</tr>
				</tbody>
			</table></br>
			<shiro:hasPermission name="baby:updateDiet">
				<a id="edit_btn" >
					<input type="button" value="修改" class="btn btn-success" id="update"> 
				</a>
			</shiro:hasPermission>
		</div>
	</div>
</body>
</html>
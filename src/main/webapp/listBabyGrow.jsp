<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝宝成长记录</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/savegrow.jpg");
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
	.coverDelete{
		border:1px solid #ffffff;
		width:200px;
		height:75px;
		position:absolute;
		left:80px;
		z-index:160;
		cursor: pointer;
	}
	img{
		margin-right:10px;
	}
	hr{
		margin-bottom:0px;
	}
	.dv_dialog_box{
	   top: 0px;
	   width: 100%;
	   height: 100%;
	   z-index: 2000;
	   position: absolute;
	   background-color: rgba(0,0,0,0.6);
	}
	.dv_dialog{
	   width: 500px;
	   height: 270px;
	   margin-left:25%;
	   margin-top: 60%;
	   background-color: #fff;
	   border-radius: 8px;
	}
	.dv_title{
	   padding-left: 25%;;
	   padding-top: 15%;
	   width: 100%;
	   height: 80px;
	   font-size: 40px;
	   line-height: 25px;
	   font-family: "Microsoft YaHei";
	}
	.dv_btn{
	   width: 100%;
	   height: 30px;
	}
	#sure{
	   width: 100px;
	   height: 60px;
	   border: 1px solid #858585;
	   border-radius: 6px;
	   cursor: pointer;
	   background-color: #fff;
	   margin-top: 17%;
	   margin-left:25%;
	   font-size: 40px;
	   font-family: "Microsoft YaHei";
	} 
	#cancel{
	   width: 120px;
	   height: 60px;
	   border: 1px solid #858585;
	   border-radius: 6px;
	   cursor: pointer;
	   background-color: #fff;
	   margin-left:5%;
	   font-size: 40px;
	   font-family: "Microsoft YaHei";
	} 
	a{
		font-size:35px;
		color:#ffffff;
	}
</style>
<script type="text/javascript">
$(function(){
	//点击返回图标，返回到主界面 
	$(".coverReturn").click(function(){
		window.location.href="/babyassistant/main";	
	});
});
	//点击删除图标 
	function remove(id){
		var t='<div class="dv_dialog_box">';
	       t+=' <div class="dv_dialog">';
	       t+=' <div class="dv_title">确定要删除吗？</div>';
	       t+='<div class="dv_btn">';
	       t+='<input type="button"  id="sure" value="确定"><input type="button"  id="cancel" value="取消">';
	       t+='</div>';
	       t+=' </div>';
	       t+='</div>';
	       $(t).appendTo("body");
	       $("#sure").click(function(){
	       	   location.href='/babyassistant/deleteBabyGrow?growId='+id;
	           $(".dv_dialog_box").remove();
	       });
	       $("#cancel").click(function(){
	           $(".dv_dialog_box").remove();
	       });
	} 
</script>
</head>
<body>
	<!-- 标题栏 -->
	<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span>
		<span class="coverReturn"></span>
		<span style="margin-left:310px;margin-right:310px;">宝宝成长</span>
		<a href="/babyassistant/saveBabyGrow.jsp" >
			<span class="glyphicon glyphicon-edit"  style="font-size:50px;"></span>
		</a>
	</div>
	<div class="container">
		<div class="content">
			<!-- 用户 -->
			<div style="margin-bottom:1%;margin-left:42%;">
				<%-- <img alt="" src="${babyInfo.baby_icon}"  style="width:120px;height:120px;border-radius:120px;border:solid rgb(30,30,30) 0px;"> --%>
				<img alt="" src="${grows.get(0).baby_icon}"  style="width:120px;height:120px;border-radius:120px;border:solid rgb(30,30,30) 0px;">
			</div>
			<div style="margin-left:43%;">
				<%-- <label >${babyInfo.baby_name}</label> --%>
				<label >${grows.get(0).baby_name}</label>
			</div>
			<div style="margin-top:2%;">
				<c:forEach items="${grows}" var="grow">
					<label >${grow.publish_date}</label>
					<!-- 记录内容 -->
					<div id="growContent">
						${grow.grow_content}
					</div>
					<!-- 记录图片 -->
					<div id="images" style="margin-bottom:1%;">
						 <c:forEach items="${grow.grow_img}" var="path" varStatus="p">
						 	<input type="text" class="imgPath" value="${path}" hidden="hidden"> 
						 	<img class="img" id="cropedBigImg"  width="180" height="150" src="${path}"> 
						 </c:forEach>
					</div>
					<div>
						<span class="glyphicon glyphicon-trash"></span>
						<span class="coverDelete" onclick="remove('${grow.grow_id}')"></span>
					</div><hr>
				</c:forEach>
			</div> 
		</div>
	</div>
</body>
</html>
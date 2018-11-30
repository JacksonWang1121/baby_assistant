<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
.coverReturn {
	border: 1px solid #00FA9A;
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer
}
.deleteInform{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}

</style>

<script type="text/javascript">
	$(function() {
		$(".coverReturn").click(function()
				{
					window.location.href="/babyassistant/listInformByClassId";

				});
		$(".coverSave").click(function()
		{
			window.location.href="/babyassistant/queryInformByInformId";

		});
        $(".deleteInform").click(function(){
        	var informId=${inform.getInformId()}
        	 $.ajax({
					url:"/babyassistant/deleteInformByInformId",//发送请求地址
					type:"post",//发送请求的方法
					dataType:"text",//返回的数据类型
					data:{"informId":informId},
					success:function(data,status){//请求成功后回调函数
						if (data=="true") {
						alert("删除成功")	
						window.location.href="/babyassistant/listInformByClassId";
						} else {
							alert("删除失败")
						}							
					},
					error:function(){//请求失败后回调函数
						alert('后台报错')
					} 
				});
        	
        });
	});
     
</script>
</head>
<body>
	<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span> 
		<span  class="coverReturn"></span> 
		<span style="margin-left: 260px; margin-right: 260px;">通知</span>
		 <span  class="glyphicon glyphicon-trash" id="inform"></span> 
		 <span class="deleteInform"></span>
	</div>
	<div class="content">
				<div class="homework">
				<div class="title1">
			    
			
					<span style="margin-left: 300px; font-size:20px" >${inform.getInformDate()}</span>
				</div>
				<div class="content"  style="margin-top: 50px ">
					<span style="margin-left: 90px  ">	${inform.getInformContent()}</span>
				</div>
			</div>
	</div>
	
	
	
	
	

</body>
</html>
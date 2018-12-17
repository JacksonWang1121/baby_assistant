<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	right: 13px;
	z-index: 100;
	cursor: pointer;
}
#informTitle{
	width: 100%;
	height: 70px;
	font-size: 40px;
	font-weight: 700;
}
#informContent{
width: 100%;
	height: 500px;
	font-size: 30px;
	

}
</style>
<script type="text/javascript">
$(function() {

	//点击返回图标，返回到主界面 
	$(".coverReturn").click(function() {
		window.location.href = "/babyassistant/listInformByClassId";
	}); 

	$(".coverSave").click(function(){
	  var  informTitle=$('#informTitle').val();
	  var  informContent=$('#informContent').val();
	  $.ajax({
		  url:"/babyassistant/saveInform",
			type:"post",
			dataType:"json",
		  data:{"informTitle":informTitle,"informContent":informContent},
	      success:function(data){
	    	if(data=="true"){
	    		alert("添加成功");
	    		window.location.href="/babyassistant/listInformByClassId";
	    	}  
	    	else{
	    		alert("添加失败");
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
			<span  style="margin-left: 260px; margin-right: 260px;">添加班级通知</span>
			 <span class="glyphicon glyphicon-saved"></span> 
			 <span  class="coverSave"></span>
		</div>
		<div>
		<form action="saveInform" id="saveInform">
		<textarea  id="informTitle"    placeholder="请输入通知标题"></textarea>
		<textarea  id="informContent"    placeholder="请输入通知内容"></textarea>
		</form>
		</div>
</body>
</html>
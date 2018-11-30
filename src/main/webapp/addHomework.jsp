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

#homeworkContent {
	width: 100%;
	height: 400px;
	size: 100px;
}
}
</style>
<script type="text/javascript">
	$(function() {
		
		

		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function() {
			window.location.href = "/babyassistant/listHomeworkByClassId";
		});
		$(".coverSave").click(function() {
			
			 	var  homeworkContent=$('#homeworkContent').val();
				if(homeworkContent==null||homeworkContent==""){
					 alert("没有填写作业");
					return; 
				}
	$.ajax({
				url:"/babyassistant/saveHomework",
				type:"post",
				dataType:"json",
				data:{"homeworkContent":homeworkContent},
				success:function(data){
					 if(data=="true"){
					alert('保存成功')
					window.location.href="/babyassistant/listHomeworkByClassId"
					}
					else{
						alert('保存失败')
					} 
				},
				error:function(data){
                        alert('后台出错');
				}
			})
		});
	});
</script>
</head>
<body>
	<div>
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="coverReturn"></span> <span
				style="margin-left: 260px; margin-right: 260px;">添加班级作业</span> <span
				class="glyphicon glyphicon-saved" id="homework"></span> <span
				class="coverSave"></span>
		</div>
		<div>
			<form action="saveHomework" id="homeworkForm">
				<textarea name="homeworkContent" id="homeworkContent"  style="font-size: 40px"></textarea>
			

			</form>
		</div>
	</div>
</body>
</html>
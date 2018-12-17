<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级作业</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.homework {
	width: 100%;
	 height:auto!important;   
    height:200px;   
    min-height:100px;   
	margin: 5px 10px 5px 10px;
	border-top: 2px solid #f00;
	border-bottom: 2px solid #f00;
	border-color: red;
}

.title1 {
width:100%;
height: 50px;
}

.content {
	height: 150px;
}

.name {
	font-family: "微软雅黑";
	font-size: 40px;
	font-weight: 900;
	margin-left: 30px
}

.date {
	font-family: "微软雅黑";
	font-size: 16px
}

.content {
	font-family: "微软雅黑";
	font-size: 35px
}

.coverReturn {
	/* 	border:1px solid #00FA9A; */
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}
.coverSave {
	border: 1px solid #00FA9A;
	width: 50px;
	height: 5px;
	position: absolute;
	right: 2px;
	z-index: 100;
	cursor: pointer;
}
.headline1{
	background-color:#00FA9A;
	text-align:center;
	height:45px;
	font-size:25px;
	color:#ffffff;
	padding-top:5px;
}
</style>
<script type="text/javascript">
	$(function() {
		//点击班级添加班级作业按钮
		$(".coverReturn").click(function() {
			window.location.href = "/babyassistant/main.jsp";
		});
		$(".coverSave").click(function() {
			window.location.href = "/babyassistant/addHomework.jsp";	
		});

		
		$(".delete").click(function(){
				
				var  homeworkId=$(this).attr("id");
				console.log(homeworkId);
				$.ajax({
					url:"/babyassistant/deleteHomeworkByHomeworkId",
					type:"post",
					dataType:"json",
					data:{"homeworkId":homeworkId},
					success:function(data){
						 if(data=="true"){
						alert('删除成功')
						window.location.href="/babyassistant/listHomeworkByClassId"
						}
						else{
							alert('删除失败')
						}  
					},
					error:function(data){
	                        alert('系统错误');
					}
				})	
	
		}); 
		
		
		
	});
</script>
</head>

<body>
	<div class="headline1">
		<span class="glyphicon glyphicon-chevron-left"></span>
		<span class="coverReturn"></span> 
		<span style="margin-left: 80px; margin-right: 80px;">${homeworks.get(0).class_name}作业</span>
		<span class="glyphicon glyphicon-plus-sign" id="sign"></span> 
		<span class="coverSave"></span>
	</div>
	<div class="content">
		<c:forEach items="${homeworks}" var="homework">

			<div class="homework">
				<div class="title1">
					<img alt="" src="${homework.user_icon}"
						style="width: 30px; height: 30px; border-radius: 50%"> <span
						class="name">${homework.nick_name}</span> <span
						style="margin-left: 300px; font-size: 20px">${homework.homework_date}</span>
				</div>
				<div class="content" style="margin-top: 50px">
					<span style="margin-left: 90px">${homework.homework_content}</span>

					<a href="javascript:"> <span
						class="glyphicon glyphicon-trash delete"
						id="${homework.homework_id}"></span>
					</a>
				</div>


				<div></div>
			</div>


		</c:forEach>
	</div>
</body>
</html>
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

.className1 {
	width: 30%;
	height: 60px;
	font-size: 40px;
	font-weight: 700;
}

.className {
	width: 55%;
	height: 60px;
	font-size: 30px;
	border-width: 7px;
	border-style: solid;
	border-color: black
}

#grade {
	width: 118px,;
	margin-right: 100px
}
</style>
<script type="text/javascript">
	$(function() {

		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function() {
			window.location.href = "/babyassistant/listInformByClassId";
		});
		$(".coverSave").click(function() {
			$("#addclass1").submit();
        });
		$("#addClass1").blur(function(){
			//将值作为参数传送到servlet ，已ajax方式传送到servlet
			//创建一个xhr，作为前台界面与后台servlet交互的关键对象
		var  className=$('#className').val();
		var  gradeId=$('#gradeId').val();	
			 $.ajax({
				url:"/babyassistant/addclass",//发送请求地址
				type:"post",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"className":className,"gradeId":gradeId},
				success:function(data){//请求成功后回调函数
					if (data == '1') {
						alert('添加成功');
					} else {
						alert('添加失败');
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
		<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="coverReturn"></span> <span
			style="margin-left: 260px; margin-right: 260px;">添加班级</span> <span
			class="glyphicon glyphicon-saved" id="class"></span> <span
			class="coverSave"></span>
	</div>
	<div>
		<form action="addclass1" id="addclass1">
			<span class="className1"  id="classNamesadsa">班级名称：</span>
			<input type="text"  name="className" id="className">
			<br> 
				<select id="grade">
				<c:forEach items="${grade}" var="grade1">
					<div>
						<h1 class="text-success" name="className"  id="gradeId">
							<option value="${grade1.getGradeId()}" id="gradeid">${grade1.getGradeName()} </option>
						</h1>
					</div>

				</c:forEach>
			</select>
		</form>
	<input  type="button"   id="addClass1" class="btn btn-success" value="添加班级" >

</div>
		
	</div>
</body>
</html>
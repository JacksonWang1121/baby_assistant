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

.coverSave {
	border: 1px solid #00FA9A;
	width: 100px;
	height: 70px;
	position: absolute;
	right: 2px;
	z-index: 100;
	cursor: pointer
}

.title1 {
	width: 100%;
	height: 100px;
}

button {
	background-color: white;
	border: none;
	color: red;
	margin-left: 180px;
	font-size: 50px;
}

.button1 {
	background-color: white;
	border: none;
	color: black;
	margin-left: 300px;
	font-size: 50px;
}

</style>
<script type="text/javascript">
	$(function() {
		$(".coverSave").click(function() {
			window.location.href = "/babyassistant/addPhotoAlbum.jsp";

		});

	});
</script>
</head>
<body>
	<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="coverReturn"></span> <span
			style="margin-left: 260px; margin-right: 260px;">${photo.get(0).getPhotoId()}班级相册</span>
		<span class="glyphicon glyphicon-saved" id="homework"></span> <span
			class="coverSave"></span>
	</div>
	<div class="title1">
		<button calss="button">相册</button>
		<button calss="button">视频</button>
		
		<div class="content">
			<table class="table table-hover">

				<c:forEach items="${photos}" var="photo">
					<td><span class="name"><img  alt="Responsive image"  class="img-responsive"
							src="${photo.getPhotoAddress()}"></span></td>
					


				</c:forEach>

			</table>

		</div>

	</div>



</body>
</html>
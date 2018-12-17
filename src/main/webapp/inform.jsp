<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
.inform {
	width:94%;
	
	height: 200px;
	min-height: 100px;
	margin: 10px 10px 30px 30px;
	border-top: 2px solid #f00;
	border-left: 2px solid #f00;
	border-right: 2px solid #f00;
	border-bottom: 2px solid #f00;
	border-color: red;
}

.title1 {
	width: 100%;
	height: 50px;
	margin-top:40px;
	margin-left:70px;
	margin-bottom:10px;

}

.titleStyle {
color:black

}
.titleDate{
margin-top:20px;
	margin-left:70px;
	margin-bottom:10px;

}
.dateStyle{
font-size: 20px;
color: black
}
.usernameStyle{
margin-left:30px;
font-size: 20px;
color: black
}
.lookStyle{
margin-left:400px;
font-size: 20px;
color: black
}
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
</style>

<script type="text/javascript">
	$(function() {
		

		$(".coverReturn").click(function() {
			window.location.href = "/babyassistant/main.jsp";

		});
		
		$(".coverSave").click(function() {
			window.location.href = "/babyassistant/addInform.jsp";

		});

	});
</script>
</head>
<body>
	<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="coverReturn"></span> <span
			style="margin-left: 260px; margin-right: 260px;">班级通知</span> <span
			class="glyphicon glyphicon-saved" id="inform"></span> <span
			class="coverSave"></span>
	</div>
	<div class="content">

		<c:forEach items="${informs}" var="inform">
			<a id="informDetail"
				href="queryInformByInformId?informId=${inform.inform_id}<%-- &lookState=${inform.look_state} --%>">
				<div class="inform">
					<div class="title1">
						<span class="titleStyle" > ${inform.inform_title}</span>
						<a  href="javascript:">
						
						</a>
					</div>
					<div class="titleDate" >
						<span class="dateStyle">${inform.inform_date}</span>
						<span class="usernameStyle">${inform.nick_name}</span>
						<span class="lookStyle">${inform.look_state}           </span>
					</div>
					
				</div>
			</a>
		</c:forEach>



	</div>

</body>
</html>
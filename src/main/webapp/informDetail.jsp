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

</style>

<script type="text/javascript">
	$(function() {
		$(".coverSave").click(function()
		{
			window.location.href="/babyassistant/queryInformByInformId";

		});
        $(".coverReturn").click(function(){
        	
        	
        	
        	
        });
	});
     
</script>
</head>
<body>
	<div class="title">
		<span class="glyphicon glyphicon-chevron-left"></span> 
		<span  class="coverReturn"></span> 
		<span style="margin-left: 260px; margin-right: 260px;">֪ͨ</span>
		 <span  class="glyphicon glyphicon-saved" id="inform"></span> <span
				class="coverSave"></span>
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
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
.coverReturn{
	border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
}
.input{

	font-family:webfont;
    font-style:italic;
	font-weight:bold;
     color: black
  
  }

.input-count{
	font-family:webfont;
    font-style:italic;
	font-weight:bold;
	color: black;
	margin-right: 30px;

}
.table{

width: 100%;
border-spacing:10px 70px;
border-collapse:separate;
}

</style>
<script type="text/javascript">

$(function(){
	$(".coverReturn").click(function(){
		window.location.href="/babyassistant/main.jsp";
	});
	<c:forEach items="${class1}" var="class2">

	$("#${class2.class_id}").click(function(){
		
		window.location.href="/babyassistant/listBabyInfoByClassId?classId="+"${class2.class_id}";
	});

</c:forEach>

	
	
});
</script>



</head>
<body>
	<div class="title">
		<span   class="glyphicon glyphicon-chevron-left"></span>
		<span  class="coverReturn"></span>
		<span  style="margin-left: 260px; margin-right: 260px;">ͨѶ¼</span> 
	</div>
<div width="100%">
		<table    class="table" >
			<c:forEach items="${class1}" var="class2">
				<tr>
					<td  width="70%">
					     <a  href="/babyassistant/listBabyInfoByClassId?classId=${class2.class_id}">
						 	<h1 class="input">${class2.class_name}</h1>
					     </a>
					</td>
				    <td width="30%" align="right" >
				             <h1   class="input-count">${class2.count}</h1>
				    </td>
				</tr>
					
			</c:forEach>
		</table>
	</div>
</body>
</html>
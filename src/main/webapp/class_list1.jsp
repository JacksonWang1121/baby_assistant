<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 动态导入js文件和css文件 -->
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.coverReturn {
	/* 	border:1px solid #00FA9A; */
	width: 100px;
	height: 70px;
	position: absolute;
	left: 13px;
	z-index: 100;
	cursor: pointer;
}
.input{

	font-family:webfont;
    font-style:italic;
	font-weight:bold;
     color: black;
  
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

$(function(){
	$(".coverReturn").click(function() {
		window.location.href = "/babyassistant/main.jsp";
	});
	$(".queryUserByRealName").click(function() {
		var realName=$("#realName").val()
		window.location.href = "/babyassistant/main.jsp";
	});
	<c:forEach items="${class1}" var="class2">
	$("#${class2.class_id}").click(function(){		
		window.location.href="/babyassistant/listBabyInfoByClassId?classId="+"${class2.class_id}";
	});
    </c:forEach>


$("#queryUser").click(function(){
	  
	   val name=$("#userName").val();
	
	   window.location.href="/babyassistant/queryUserInfoByName?name="+"name";
	   
});
	
});
</script>
</head>
<body>


<div class="headline1">
	    <span class="glyphicon glyphicon-chevron-left"></span>
         <span class="coverReturn"></span>
		<span  style="margin-left:110px; margin-right: 150px;">通讯录</span>  
</div>


	<div  style="width: 100%;height: 60px;margin-top: 30px">

	            <input type="text" name="realName" id="realName"  style="margin-left: 50px;">
				<input id="queryUserByRealName" type="button" class="btn btn-info" value="查询">
	</div>
	
	
	<div width="100%">
		<table    class="table" >
			<c:forEach items="${class1}" var="class2">
				<tr>
					<td  width="70%">
					     <a  href="/babyassistant/listBabyInfoByClassId?classId=${class2.class_id}">
						 	<h3 class="input">${class2.class_name}</h3>
					     </a>
					</td>
				    <td width="30%" align="right" >
				             <h3   class="input-count">${class2.count}人</h3>
				    </td>
				</tr>
					
			</c:forEach>
		</table>
	</div>

</body>
</html>
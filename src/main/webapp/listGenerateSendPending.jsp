<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待确认</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.container {
	margin: 0;
	padding: 0;
}
</style>
<script type="text/javascript">
/* 重发通知 */
function saveGenerateSendAgain(sendId) {
	$.ajax({
		url : "${pageContext.request.contextPath }/generateSend/saveGenerateSendAgain",
		type : "POST",
		data : {"id":sendId},
		dataType : "text",
		success : function(data, status) {
			// 根据返回结果指定界面操作
			console.log("listGenerateSend::saveGenerateSendAgain:success-data = " + data);
			if (data == "true") {
				//标记表单已提交
				alert("发送成功");
				window.location.href = "${pageContext.request.contextPath }/generateSend/listGenerateSendPending";
			} else {
				alert("发送失败");
			}
		},
		error : function(data, status, e) {
			console.log("listGenerateSend::saveGenerateSendAgain:error = " + e);
			alert("发送失败");
		}
	});
}
</script>
</head>
<body>
<div class="container">
<c:forEach items="${sendList }" var="send">
	<div class="row">
		<div class="col-xs-3">
			<img alt="" src="${send.personPicture }">
		</div>
		<div class="col-xs-6">
			<div>
				<p>${send.description }</p>
			</div>
			<div style="bottom:0;">
				<span>${send.generateTime }</span>
			</div>
		</div>
		<div class="col-xs-3" style="padding-top:10px;">
			<shiro:hasPermission name="send:resend">
				<%-- <a class="btn btn-warning" href="${pageContext.request.contextPath }/generateSend/saveGenerateSendAgain?id=${send.id }" style="font-size:6px;">重发通知</a> --%>
				<a class="btn btn-warning" href="javascript:saveGenerateSendAgain(${send.id })" style="font-size:6px;">重发通知</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="send:agree">
				<a class="btn btn-success" href="${pageContext.request.contextPath }/generateSend/auditGenerateSend?id=${send.id }&auditState=1" style="font-size:8px;">同意</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="send:refused">
				<a class="btn btn-danger" href="${pageContext.request.contextPath }/generateSend/auditGenerateSend?id=${send.id }&auditState=2" style="font-size:8px;">拒绝</a>
			</shiro:hasPermission>
		</div>
	</div>
</c:forEach>
</div>
</body>
</html>
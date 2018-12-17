<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代接送</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.container {
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
<div class="container">
<c:forEach items="${sendList }" var="send">
	<div class="row">
		<div class="col-xs-3">
			<img alt="" src="${send.personPicture }" width="50px">
		</div>
		<div class="col-xs-6">
			<div>
				<p>${send.description }</p>
			</div>
			<div style="bottom:0;">
				<span>${send.generateTime }</span>
			</div>
		</div>
		<div class="col-xs-3" style="padding-top:20px;">
			<c:if test="${send.auditState eq 1 }"><span style="font-size:12px;color:#00ff00">已同意</span></c:if>
			<c:if test="${send.auditState eq 2 }"><span style="font-size:12px;color:#ff0000">已拒绝</span></c:if>
		</div>
	</div>
</c:forEach>
</div>
</body>
</html>
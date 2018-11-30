<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择宝贝</title>
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
.container {
	margin-top: 52px;
}
</style>
<script type="text/javascript">
function chooseBaby(value) {
	console.log("chooseBaby::chooseBaby-value = "+value);
	var split = value.split(",");
	var ss = window.sessionStorage;
	ss.setItem("send_cls_name", split[0]);
	ss.setItem("send_baby_name", split[1]);
	ss.setItem("send_baby_id", split[2]);
	ss.setItem("send_parent_id", split[3]);
	window.location.href = "saveGenerateSend.jsp";
}
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="listGenerateSend.jsp" class="z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>选择宝贝</label>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
<div class="panel-group" id="accordion">
<c:forEach items="${stuMap }" var="cls">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" href="#collapse${cls.value.get(0).class_id }">
					${cls.key }
				</a>
			</h4>
		</div>
		<div id="collapse${cls.value.get(0).class_id }" class="panel-collapse collapse">
			<div class="panel-body">
				<c:forEach items="${cls.value }" var="stu">
					<a href="javascript:chooseBaby('${cls.key },${stu.baby_name },${stu.baby_id },${stu.user_id }');">
						<div style="float:left;width:50px;height:64px;text-align:center;margin:15px;">
							<div style="width:50px;height:50px;">
								<img alt="*" src="${stu.baby_icon }" style="width:50px;height:50px;">
							</div>
							<span style="font-size:12px;">${stu.baby_name }</span>
						</div>
					</a>
				</c:forEach>
				<!-- 清除浮动 -->
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</c:forEach>
</div>
</div>
</body>
</html>
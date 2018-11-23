<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假申请</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	button{
		height:60px;
		width:100px;
	}
	.contentArea{
		margin-bottom:3%;
	}
</style>
</head>
<body>
<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  	<div class="modal-dialog modal-lg" style="height:840px;width:800px;"role="document" >
	    	<div class="modal-content">
	    		<!-- 模态框头部信息 -->
	     		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h1 class="modal-title" id="myModalLabel" style="color:green">请填写请假申请...</h1>
	      		</div>
	      		<div class="container">
		      		<div class="content">
			      		<!-- 模态框主题信息 -->
			      		<div class="modal-body" style="height:840px;width:782px;overflow:scroll;">
			      			<div class="container-fluid">
			      				<form id="leaveApplicationForm">
									<div class="contentArea">请假人姓名</div>
									<div class="contentArea">
										<textarea rows="1" cols="25"  id="realName" name="realName" ></textarea>
									</div>
									<div class="contentArea">请假时间简述</div>
									<div class="contentArea">
										<textarea rows="2" cols="25" id="leaveTime" name="leaveTime"></textarea>
									</div>
									<div class="contentArea">请假理由简述</div>
									<div class="contentArea">
										<textarea rows="4" cols="25" id="leaveReason" name="leaveReason"></textarea>
									</div>
								</form>
			      			</div>
			      		</div>
			      		<!-- 模态框脚部信息 -->
				      	<div class="modal-footer">
				      		<button type="button" id="ensure" class="btn btn-success" style="font-size:30px;">确定</button>
				        	<button type="button" class="btn btn-default" data-dismiss="modal" style="font-size:30px;">关闭</button>
				      	</div>
			      	</div>
   				</div>
	  		</div>
	  	</div>
	</div>
</body>
</html>
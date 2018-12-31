<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>审核教师请假申请</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	.contentArea{
		margin-bottom:3%;
	}
	th{
		text-align:center;
	}
</style>
<script type="text/javascript">
	$(function(){
		$.ajax({
				url:'${pageContext.request.contextPath }/listLeaveApplication',
				type:'get',
				dataType:'json',
				success:function(data){
					$(data).each(
                    	function (i, values) {
	                        $("#leaveInfo").html($("#leaveInfo").html()
	                            +"<tr><td>"+values.submit_date+"</td>"
	                            +"<td>"+values.real_name+"</td>"
	                            +"<td>"+values.leave_time+"</td>"
	                            +"<td>"+values.leave_reason+"</td>"
	                            +"<td>"
	                            +"<input type='button' class='btn btn-success' value='同意'style='font-size:10px;' onclick='agreeAudit("+values.leave_id+")'>"
	                            +"<input type='button' class='btn btn-success' value='驳回'style='font-size:10px;margin-left:2%;'onclick='refuseAudit("+values.leave_id+")'>"
	                            +"</td></tr>"
	                        );
                    	}
                	);
				}
		});
	});
	function agreeAudit(leaveId){
			$.ajax({
				url:'${pageContext.request.contextPath }/auditLeaveApplication',
				type:'get',
				dataType:'json',
				data:{
					leaveId:leaveId,
					audit:"同意",
				},
				success:function(data){
					if(data=="true"){
						alert("已批准!")
						window.location.href="${pageContext.request.contextPath }/main";
					}else{
						alert("审核失败!")
						window.location.href="${pageContext.request.contextPath }/main";
					}
				}
			});
	}
	function refuseAudit(leaveId){
			$.ajax({
				url:'${pageContext.request.contextPath }/auditLeaveApplication',
				type:'get',
				dataType:'json',
				data:{
					leaveId:leaveId,
					audit:"驳回",
				},
				success:function(data){
					if(data=="true"){
						alert("已驳回!")
						window.location.href="${pageContext.request.contextPath }/main";
					}else{
						alert("审核失败!")
						window.location.href="${pageContext.request.contextPath }/main";
					}
				}
			});
	}
</script>
</head>
<body>
<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  	<div class="modal-dialog modal-lg" style="height:390px;width:365px;margin-top:10%;"role="document" >
	    	<div class="modal-content">
	    		<!-- 模态框头部信息 -->
	     		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h2 class="modal-title" id="myModalLabel" style="color:green">请审核教师请假申请...</h2>
	      		</div>
		      		<div class="content">
			      		<!-- 模态框主题信息 -->
			      		<div class="modal-body" style="height:380px;width:350px;overflow:scroll;">
			      				<table class="table table-bordered table-hover" style="width:600px;font-size:13px" id="teacherLeave">
									<thead>
										<tr class="success">
											<th>申请时间</th>
											<th>姓名</th>
											<th>请假时间</th>
											<th>请假理由</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody id="leaveInfo">
									
									</tbody>
								</table>
			      		</div>
			      		<!-- 模态框脚部信息 -->
				      	<div class="modal-footer">
				        	<button type="button" class="btn btn-success" data-dismiss="modal" style="font-size:13px;">关闭</button>
				      	</div>
			      	</div>
	  		</div>
	  	</div>
	</div>
</body>
</html>
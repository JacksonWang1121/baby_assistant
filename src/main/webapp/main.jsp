<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<title>主页</title>
<!-- 动态导入js文件和css文件 -->
<jsp:include page="public.jsp"></jsp:include>
<style type="text/css">
body{
	background-image:url("images/bg03.jpg");
	background-repeat:no-repeat;
	background-size:cover;
	background-attachment: fixed;
}
#adv{
	width:100%;
	padding-top: 48px;
    position: fixed;
}
#adv>img{
	width:100%;
	height:200px;
	display:none;
}
#function {
	padding-top: 248px;
	margin-bottom: 64px;
}
#footer {
	width: 100%;
    height: 64px;
    text-align: center;
    background-color:#00FA9A;
    padding-top: 5px;
    position: fixed;
    bottom: 0;
}
#footer-content {
	width:100%;
	height:100%;
	text-align:center;
}
#footer-content>div {
	width:100%;
	height:36px;
}
#footer-content img {
	width: 36px;
	height: 36px;
	border-radius: 36px;
}
</style>
<script type="text/javascript">
$(function(){
	//获取轮播图片
	var imgs=document.getElementsByClassName('major');
	//首先显示第一张图片
	imgs[0].style.display='inline';
	//开启定时器，显示当前位置i对应的图片
	var i=1;
	window.setInterval(function(){
		imgs[(i-1)%3].style.display='none';//隐藏上一张图片
		imgs[i%3].style.display='inline';//显示当前图片
		i++
	},2000);
	
	//判断登录用户是否是园长，若是园长检查是否有待审核的教师请假申请
	var role=$("#role").val();
	if(role=="principal"){
		$.ajax({
			url:'${pageContext.request.contextPath }/isExistLeaveApplication',
			type:'get',
			dataType:'json',
			success:function(data){
				if(data=="true"){
					$('#myModal').modal('show');
				}
			}
		}); 
	}
	
	//点击学生网上缴费按钮
	$("#onlinePayment").click(function(){
		$.ajax({
			url:'${pageContext.request.contextPath }/hasPayTuition',
			async : false,
			type:'get',
			dataType:'json',
			success:function(data){
				if(data==false){
					window.location.href="${pageContext.request.contextPath }/paymentOfTuition.jsp";
				}else{
					new TipBox({type:'tip',str:'您已成功缴费，请勿重复操作!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
				}
			}
		});
		
	});
	
});
</script>
</head>
<body>
<!-- 头部 -->
<div class="headline">
	<label>宝贝助手</label>
</div>

<!-- 广告轮播 -->
<div id="adv">
	<img class='major'src="/babyassistantfile/images/pageImgs/adv2.jpg" alt="" />
	<img class='major'src="/babyassistantfile/images/pageImgs/adv3.jpg" alt="" />
	<img class='major'src="/babyassistantfile/images/pageImgs/adv1.jpg" alt="" />
</div>

<!-- 功能列表 -->
<div id="function">
	<c:forEach items="${permissions }" var="perm">
		<c:if test="${perm.description eq '网上缴费' }">
			<a href="javascript:" id="onlinePayment">
		</c:if>
		<c:if test="${perm.description ne '网上缴费' }">
			<a href="${pageContext.request.contextPath }/${perm.url }">
		</c:if>
			<div style="float:left;width:50px;height:64px;text-align:center;margin:15px;">
				<div style="width:50px;height:50px;">
					<img alt="*" src="images/imgs/${perm.icon }" style="width:50px;height:50px;">
				</div>
				<span style="font-size:12px;">${perm.description }</span>
			</div>
		</a>
	</c:forEach>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<!-- 底部导航栏 -->
<div id="footer">
	<div class="row">
		<div class="col-xs-4">
			<a href="${pageContext.request.contextPath }/main">
				<div id="footer-content" align="center">
					<div>
	 					<img alt="" src="images/imgs/home.jpg">
	 				</div>
					<span style="font-size:12px;color:#fff;">首页</span>
				 </div>
 			 </a>
		</div>
		<div class="col-xs-4">
			<a href="${pageContext.request.contextPath }/listInformByClassId">
				<div id="footer-content" align="center">
					<div>
				 		<img alt="" src="images/imgs/notice.jpg">
					</div>
			 		<span style="font-size:12px;color:#fff;">通知</span>
			 	</div>
		 	</a>
		</div>
		<div class="col-xs-4">
			<a href="${pageContext.request.contextPath }/getPersonalHomePage">
	 			<div id="footer-content" align="center">
	 				<div>
			 			<img alt="" src="images/imgs/mine.jpg">
	 				</div>
		 			<span style="font-size:12px;color:#fff;">我</span>
	 			</div>
			 </a>
		</div>
	</div>
</div>

<!-- 动态加载模态框 -->
<jsp:include page="auditTeacherLeave.jsp"></jsp:include>
</body>
</html>

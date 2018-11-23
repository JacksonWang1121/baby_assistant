<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微官网</title>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" href="css/swiper.min.css">
<script type="text/javascript" src="js/swiper.min.js"></script>
<style type="text/css">
.container {
	padding-top: 48px;
	position: relative;
	height: 100%;
}

.swiper1,.swiper2 {
	width: 100%;
	height: 100%;
}

.swiper-slide {
	
}
</style>
<script type="text/javascript">
$(function() {

	/* 每次访问该页面时，查询是否已存在该幼儿园的微官网 */
	$.ajax({
		url: "${pageContext.request.contextPath }/website/findWebsite",
		type: "POST",
		dataType: "json",
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("find_website-data = "+data);
			//若有数据返回，则提示微官网已存在，并禁用保存按钮
			if (data == null) {
				alert("微官网不存在");
			} else {
				//幼儿园信息
				$("#schoolName").html(data.kindergarten.name);
				$("#description").html(data.kindergarten.description);
				if (data.kindergarten.picture != null) {
					$("#picture").html('<img alt="该图片不存在" width="300px" src="'+data.kindergarten.picture+'"/>');
				}
				$("#address").html(data.kindergarten.address);
				$("#telephone").html(data.kindergarten.telephone);
				/*
				 * 微官网信息
				 */
				//校园简介
				if (data.website.schoolIntroPicture != null) {
					$("#schoolPicture").html('<img alt="该图片不存在" width="300px" src="'+data.website.schoolIntroPicture+'"/>');
				}
				$("#schoolIntro").html(data.website.schoolIntro);
				//教师风采
				if (data.website.teacherPicture1 != null) {
					$("#teacherPicture1").html('<img alt="该图片不存在" width="300px" src="'+data.website.teacherPicture1+'"/>');
				}
				$("#teacherIntro1").html(data.website.teacherIntro1);
				if (data.website.teacherPicture2 != null) {
					$("#teacherPicture2").html('<img alt="该图片不存在" width="300px" src="'+data.website.teacherPicture2+'"/>');
				}
				$("#teacherIntro2").html(data.website.teacherIntro2);
				if (data.website.teacherPicture3 != null) {
					$("#teacherPicture3").html('<img alt="该图片不存在" width="300px" src="'+data.website.teacherPicture3+'"/>');
				}
				$("#teacherIntro3").html(data.website.teacherIntro3);
				//资质证书
				$("#certificateName1").html(data.website.certificateName1);
				if (data.website.certificatePicture1 != null) {
					$("#certificatePicture1").html('<img alt="该图片不存在" width="300px" src="'+data.website.certificatePicture1+'"/>');
				}
				$("#certificateName2").html(data.website.certificateName2);
				if (data.website.certificatePicture2 != null) {
					$("#certificatePicture2").html('<img alt="该图片不存在" width="300px" src="'+data.website.certificatePicture2+'"/>');
				}
				$("#certificateName3").html(data.website.certificateName3);
				if (data.website.certificatePicture3 != null) {
					$("#certificatePicture3").html('<img alt="该图片不存在" width="300px" src="'+data.website.certificatePicture3+'"/>');
				}
				//学生作品
				if (data.website.stuWorks != null) {
					var photos = data.website.stuWorks.split(";");
					for (var i = 0; i < photos.length; i++) {
						$("#stuWorks").append('<img alt="该图片不存在" width="150px" src="'+photos[i]+'"/>');
					}
				}
			}
		},
		error: function(data,status,e) {
			console.log("find_website-error = "+e);
			alert("读取失败");
		}
	});

});
</script>
</head>
<body>
<!-- 头部 -->
<div class="title">
	<a href="${pageContext.request.contextPath }/main" class="pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>微官网</label>
	<a href="javascript:void(0);" class="pull-right" style="margin-right:20px;">
		<img alt="" width="20px" src="images/icons/more.svg">
	</a>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<div class="container">
<div class="swiper1">
<div class="swiper-wrapper">
	<!-- 首页（幼儿园信息） -->
	<div id="firstPage" class="swiper-slide">
		<div class="row">
			<div class="col-xs-12 text-center"><span class="h3" id="schoolName"></span></div>
		</div>
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-11"><p id="description"></p></div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center" id="picture"></div>
		</div>
		<div class="row">
			<div class="col-xs-3"><strong>地址</strong></div>
			<div class="col-xs-8"><span id="address"></span></div>
		</div>
		<div class="row">
			<div class="col-xs-3"><strong>电话</strong></div>
			<div class="col-xs-8"><span id="telephone"></span></div>
		</div>
	</div>
		
	<!-- 校园简介 -->
	<div id="secondPage" class="swiper-slide">
		<div class="row">
			<div class="col-xs-6"><h3>校园简介</h3></div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center" id="schoolPicture"></div>
		</div>
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-11"><p id="schoolIntro"></p></div>
		</div>
	</div>
	
	<!-- 教师风采 -->
	<div id="thirdPage" class="swiper-slide swiper2">
		<div class="swiper-wrapper">
		    <div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>教师风采</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="teacherPicture1"></div>
				</div>
				<div class="row">
					<div class="col-xs-1"></div>
					<div class="col-xs-11"><p id="teacherIntro1"></p></div>
				</div>
			</div>
			
			<div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>教师风采</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="teacherPicture2"></div>
				</div>
				<div class="row">
					<div class="col-xs-1"></div>
					<div class="col-xs-11"><p id="teacherIntro2"></p></div>
				</div>
			</div>
			
			<div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>教师风采</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="teacherPicture3"></div>
				</div>
				<div class="row">
					<div class="col-xs-1"></div>
					<div class="col-xs-11"><p id="teacherIntro3"></p></div>
				</div>
			</div>
		</div>
		
		<!-- Add Arrows -->
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
	
	<!-- 资质证书 -->
	<div id="forthPage" class="swiper-slide swiper2">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>资质证书</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center"><span id="certificateName1"></span></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="certificatePicture1"></div>
				</div>
			</div>
		
			<div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>资质证书</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center"><span id="certificateName2"></span></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="certificatePicture2"></div>
				</div>
			</div>
		
			<div class="swiper-slide">
				<div class="row">
					<div class="col-xs-6"><h3>资质证书</h3></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center"><span id="certificateName3"></span></div>
				</div>
				<div class="row">
					<div class="col-xs-12 text-center" id="certificatePicture3"></div>
				</div>
			</div>
		</div>
		
		<!-- Add Arrows -->
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>
	
	<!-- 学生作品 -->
	<div id="fifthPage" class="swiper-slide">
		<div class="row">
			<div class="col-xs-6"><h3>学生作品</h3></div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center" id="stuWorks"></div>
		</div>
	</div>
	
</div><!-- wrapper -->
</div>
</div>

<script type="text/javascript">
/* 上下滑动 */
var swiper1 = new Swiper('.swiper1', {
	direction: 'vertical',  //垂直切换选项
});
/* 左右滑动 */
var swiper2 = new Swiper('.swiper2', {
	navigation: {
		nextEl: '.swiper-button-next',
		prevEl: '.swiper-button-prev',
	}
});
</script>

</body>
</html>
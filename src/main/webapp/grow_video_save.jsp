<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布宝宝成长记录</title>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/css/fileinput.min.css" />
<script type="text/javascript" src="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/js/fileinput.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/js/locales/zh.js"></script>
<style type="text/css">
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:13px;
		z-index:100;
		cursor: pointer;
	}
	.coverSave{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		right:2px;
		z-index:100;
		cursor: pointer;
	}
	.coverVideo{
		border:1px solid #ffffff;
		width:150px;
		height:120px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
	}
	.content{
		margin-bottom:10px;
	}
	.form-control{
		width:320px;
		height:60px;
		font-size:40px;
	}
	.Wdate{
		width:320px;
		height:60px;
		font-size:40px;
	}
	#save{
		width:160px;
		height:80px;
		font-size:40px;
	}
	img{
		width:320px;
		height:220px;
	}
	input{
		width:320px;
	}
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/listBabyGrow";	
		});
		//点击保存图标发布宝宝成长记录
		$(".coverSave").click(function(){
			$("#growForm").submit();
		});
		//点击视频图标跳转到录制视频界面
		$(".coverVideo").click(function(){
			window.location.href="/babyassistant/video.jsp";	
		});
		//0.初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("files", "saveBabyGrow");
	});
	//上传图片
	var FileInput = function () {
        var oFile = new Object();
        //初始化fileinput控件（第一次初始化）
        oFile.Init = function (ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);
            //初始化上传控件的样式
            control.fileinput({
            	uploadAsync: true, //异步上传  
                language:'zh', //设置语言
                uploadUrl:uploadUrl, //上传的地址
                allowedFileExtensions: ['jpg', 'gif', 'png','jpeg'],//接收的文件后缀
                showUpload: false, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-info", //按钮样式
                dropZoneEnabled: false,//是否显示拖拽区域
                maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                maxFileCount: 3, //表示允许同时上传的最大文件个数
                minFileCount: 0,
                enctype: 'multipart/form-data',
                validateInitialCount: true,
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                fileActionSettings : {
                   showUpload: false,
                   showRemove: true,
                   showZoom:true
                },
            });
        };
        return oFile;
    };
</script>
</head>
<body>
	<div>
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:260px;margin-right:260px;">发布宝宝成长</span>
			<span class="glyphicon glyphicon-saved" id="grow"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content">
			<form action="saveBabyGrow" method="post" id="growForm" enctype="multipart/form-data">
				<div id="growDiv">
					<textarea style="width:100%;height:280px;" name="growContent" id="growContent" class="form-control" placeholder="记录成长，记录宝宝的美好时光!"></textarea>
				</div>
				<div style="width:100%;height:380px;border:solid 1px gray">
		   			<span class="glyphicon glyphicon-facetime-video" id="grow" style="font-size:100px;"></span>
					<span class="coverVideo"></span>
		   		</div>
			</form>
		</div>
	</div>
</body>
</html>
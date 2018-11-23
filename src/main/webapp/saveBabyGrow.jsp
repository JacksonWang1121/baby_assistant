<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布宝宝成长记录</title>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/css/fileinput.min.css" />
<script type="text/javascript" src="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/js/fileinput.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/bootstrap-fileinput/4.4.2/js/locales/zh.js"></script>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/savegrow.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
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
                allowedFileExtensions: ['jpg', 'gif', 'png','jpeg','mp4'],//接收的文件后缀
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
    function saveGrow(){
    	 //点击保存图标发布宝宝成长记录
			var formData = new FormData($("growForm"));
			formData.append("growContent", $("#growContent").val());
 			for(var i=0; i<$('#files')[0].files.length; i++) {
				formData.append('files', $('#files')[0].files[i]);
			}   
 			$.ajax({
				url:"${pageContext.request.contextPath }/saveBabyGrow",
				type:"post",
				dataType:"text",
				data:formData,
				async: true,         //同步或异步请求方式，默认为true，异步
				cache: false,
				processData: false,  //不要对data参数进行序列化处理，默认为true
				contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
				success:function(data){
					if(data=="true"){
						/* 若发布成长成功，返回到查看成长界面 */
						window.location.href="${pageContext.request.contextPath }/listBabyGrow";  
					}else{
						/* 若发布失败，给出提示信息 */
						new TipBox({type:'tip',str:'发布失败,请稍后重试!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
					}
				}   
		});
    }
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
			<span class="coverSave" onclick="saveGrow()"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content">
			<form method="post" id="growForm" enctype="multipart/form-data">
				<div id="growDiv">
					<textarea style="width:100%;height:280px;" name="growContent" id="growContent" class="form-control" placeholder="记录成长，记录宝宝的美好时光!"></textarea>
				</div>
				<div style="width:100%;height:400px;border:solid 1px gray">
					<div style="float:left">
		   				<input id="files" type="file" name="files" multiple class="file-loading">
		   			</div>
		   		</div>
			</form>
		</div>
	</div>
</body>
</html>
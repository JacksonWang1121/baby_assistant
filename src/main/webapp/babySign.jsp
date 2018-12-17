<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝宝签到</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
	body{
		background-image:url("/babyassistantfile/images/pageImgs/babysign.jpg");
		background-repeat:no-repeat;
		background-size:100% 1750px;
		background-attachment: fixed;
	}
	.coverReturn{
		border:1px solid #00FA9A;
		width:100px;
		height:70px;
		position:absolute;
		left:2px;
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
</style>
<script type="text/javascript">
	$(function(){
		//点击返回图标，返回到主界面 
		$(".coverReturn").click(function(){
			window.location.href="/babyassistant/main";	
		});
		//点击全选复选框选中所有学生
	 	$(".allSel").click(function() { 
	        var one=$("input[name='babyId']");//获取到复选框的名称
	        if(this.checked==true){//因为获得的是数组，所以要循环 为每一个checked赋值
	            for(var i=0;i<one.length;i++){
	                one[i].checked=true;
	            }
	        }else{
	            for(var j=0;j<one.length;j++){
	                one[j].checked=false;
	            }
	        }
		}); 
			/* 获取选中复选框的id */
			var babyId;
		    /* 点击添加图标给选中的宝宝签到 */
		    $(".coverSave").click(function(){
		    	var babyIdLists = [];
				//根据当前父类别，获取子类别
				var groupCheckbox=$("input[name='babyId']");
				for(var i=0;i<groupCheckbox.length;i++){
		        	if(groupCheckbox[i].checked){
		           		babyIdLists.push(groupCheckbox[i].value);
		        	}
		    	} 
			    babyId=JSON.stringify(babyIdLists);
			    if(babyId=='[]'){
			    	//判断babyId如果为空提示用户先选择要签到的宝宝
			    	new TipBox({type:'tip',str:'请先选择要签到的宝宝!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
			    }else{
			    //若不为空进行验证签到
				$.ajax({
					url:'${pageContext.request.contextPath }/isExistAttendance',
					async : false,
					type:'get',
					dataType:'json',
					data:{'babyId':babyId},
					success:function(data){
						if(data==false){
							$.ajax({
								url:'${pageContext.request.contextPath }/babiesSign',
								async : false,
								type:'get',
								dataType:'json',
								data:{'babyId':babyId},
								success:function(data){
								 /* 若选中的宝宝没有签到，则给选中的宝宝签到 */
									if(data==true){
										new TipBox({type:'success',str:'签到成功!',hasBtn:true});
									}else{
										new TipBox({type:'error',str:'签到失败!',hasBtn:true});  
									}
								}
							}); 
						}else{
							/* 若选中的宝宝已签到，给出提示信息 */
							new TipBox({type:'tip',str:'存在已签到宝贝，请重新选择!',clickDomCancel:true,setTime:10000500,hasBtn:true});  
						}
					}
				});
			} 
		});
	});
</script>
</head>
<body>
	<div id="container">
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:650px;">签到</span>
			<span class="glyphicon glyphicon-saved" id="sign"></span>
			<span class="coverSave"></span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content" style="margin-top:42%;margin-left:5%;">
			<div>
				<input type="checkbox" class="allSel" name="allSel" style="zoom:240%;"><span id="mySpan">全选</span>
			</div>
			<c:forEach items="${babies}" var="baby">
				<div class="col-xs-1 col-xs-offset-2">
					 <input type="checkbox" class="babyId" name="babyId" value="${baby.baby_id}" style="zoom:240%;">
				</div>
				<div class="col-xs-4">${baby.baby_name}</div>
				<div class="col-xs-4">${baby.baby_no}</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
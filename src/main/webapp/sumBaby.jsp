<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名列表</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.common.min.js"></script>
<style type="text/css">
	.coverReturn{
		border:1px solid #00FA9A;
		width:120px;
		height:70px;
		position:absolute;
		left:2px;
		z-index:100;
		cursor: pointer;
	}
	li{
		width:23%;
		text-align:center;
	}
</style>
<script type="text/javascript">
$(function(){
	initMain(); //初始化图标面板
	//点击返回图标，返回到主界面 
	$(".coverReturn").click(function(){
		window.location.href="/babyassistant/main";	
	});
});
function initMain(){
	//获取echart对象
	var myChart=echarts.init(document.getElementById('main')); 
		      
	$.ajax({
		type : "post",
		async : true,    
		url : "countBabiesInClass",
		data : {},
		dataType : "json",        //返回数据形式为json
		success : function(result) {
			//获取填充数据
			var option = {
				title : { text: '' },
				tooltip: {  
					show: true,
					textStyle : {
			            color: 'white',
			            fontSize: 45,
			        },
			    },
				legend: {  
						data:result.type, 
				},
				xAxis : [{
							type : 'category',
							data : result.labels,
							axisLabel: {        
                                show: true,
                                textStyle: {
                                    fontSize:'45'
                                }
                            },
						}],
				yAxis : [{  type : 'value',
							axisLabel: {        
                                show: true,
                                textStyle: {
                                    fontSize:'45'
                                }
                            }, 
                        }],
				series : [{
							'name':result.type,
							'type':'bar',
							'data':result.nums,
						}]
			};  
			//填充数据
			myChart.setOption(option);	             
		},
		error : function(errorMsg) {
			//请求失败时执行该函数
			alert("图表请求数据失败!");    
			myChart.hideLoading();
		}
	}); 
}
</script>
</head>
<body>
	<div >
		<!-- 标题栏 -->
		<div class="title">
			<span class="glyphicon glyphicon-chevron-left"></span>
			<span class="coverReturn"></span>
			<span style="margin-left:330px;margin-right:330px;">报名列表</span>
		</div>
		<!-- 页面主要内容 -->
		<div class="content">
			<!-- 导航栏 -->
			<ul class="nav nav-pills" role="tablist">
	  			<li><a href="/babyassistant/listWaitDivideBabyInfo">待分班</a></li>
	  			<li><a href="/babyassistant/listClassInfo">已分班</a></li>
	  			<li><a href="/babyassistant/listWaitPayBabyInfo">待付款</a></li>
	  			<li class="active" style="width:30%;"><a href="/babyassistant/sumBaby.jsp">各班人数图示</a></li>
			</ul>
		</div>
		<div class="container" id="main" style="width:90%;height:600px;font-size:40px;margin-top:20%;"></div>
	</div>
</body>
</html>
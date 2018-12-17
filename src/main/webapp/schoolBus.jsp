<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no" />
<title>校车</title>
<jsp:include page="public.jsp"></jsp:include>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=h1ftaAWtybFRa6L1ifGy6SRdayuvb5oW"></script>
<style type="text/css">
html {
	height: 100%;
}  
body {
	height: 100%;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
}
</style>
<script type="text/javascript">
$(function() {

	//创建地图实例,参数div的id
	var map=new BMap.Map("map");
	//创建点坐标,默认天安门
	var point=new BMap.Point(116.404, 39.915);
	//初始化地图，设置中心点坐标和地图级别,zoom有1-20级别
	map.centerAndZoom(point,12);
	//开启鼠标滚轮缩放
	//map.enableScrollWheelZoom(true);
	
	map.addControl(new BMap.GeolocationControl());
	map.addControl(new BMap.NavigationControl());
	map.addControl(new BMap.ScaleControl());
	//map.setCurrentCity("北京"); // 仅当设置城市信息时，MapTypeControl的切换功能才能可用
	
	// 创建标注
	var marker = new BMap.Marker(point);
	// 将标注添加到地图中
	map.addOverlay(marker);
	//给点加上文字描述
	marker.setLabel(new BMap.Label('<a href="javascript:void(0);">我在这</a>',{"offset":new BMap.Size(20,-10)}));
	//监听标注事件
	marker.addEventListener("click", function(){    
	    alert("您点击了标注");    
	});
	
	if(navigator.geolocation) {
		/* 浏览器定位 */
		var geolocation = new BMap.Geolocation();
		console.log("schoolBus::geolocation = "+JSON.stringify(geolocation));
		//alert("schoolBus::geolocation = "+JSON.stringify(geolocation));
		geolocation.getCurrentPosition(function(r){
			console.log("schoolBus::getCurrentPosition-r = "+JSON.stringify(r));
			//alert("schoolBus::getCurrentPosition-r = "+JSON.stringify(r));
			if(this.getStatus() == BMAP_STATUS_SUCCESS){
				var mk = new BMap.Marker(r.point);
				map.addOverlay(mk);
				map.panTo(r.point);
				console('您的位置：'+r.point.lng+','+r.point.lat);
				//alert('您的位置：'+r.point.lng+','+r.point.lat);
			}
			else {
				alert('failed'+this.getStatus());
			}
		});
		//关于状态码
		//BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
		//BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
		//BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
		//BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
		//BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
		//BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
		//BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
		//BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
		//BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)
	} else {
		alert("HTML5 Geolocation is not supported in your browser.");
	}
});
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="${pageContext.request.contextPath }/main" class="icon-z-index pull-left" style="margin-left:20px;">
		<img alt="" width="20px" src="images/icons/return.svg">
	</a>
	<label>校车</label>
</div>
<!-- 清除浮动 -->
<div class="clearfix"></div>

<!-- 定义一个div，放置地图 -->
<div id="map" style="height: 900px;"></div>
</body>
</html>
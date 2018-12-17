<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>校车</title>
<jsp:include page="public.jsp"></jsp:include>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript">
$(function() {

	//在mapdiv中加载地图
	var map=new BMap.Map("map");//参数div的id
	var point=new BMap.Point(121.453449,37.492814);//创建一个点
	map.centerAndZoom(point,18);//zoom有1-20级别
	//标注甲骨文餐厅的位置point
	var marker=new BMap.Marker(point);
	map.addOverlay(marker);//在地图上加上覆盖物
	//给点加上文字描述
	marker.setLabel(new BMap.Label("<a href=\"http://localhost:8081/mt/findFoods\">甲骨文餐厅，欢迎进入！</a>",{"offset":new BMap.Size(20,-10)}));

});
</script>
</head>
<body>
<!-- 标题 -->
<div class="headline">
	<a href="${pageContext.request.contextPath }/main" class="z-index pull-left" style="margin-left:20px;">
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
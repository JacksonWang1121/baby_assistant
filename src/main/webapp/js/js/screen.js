/* 自定义扫描客户端类型：移动端和PC端 */
$(function() {
	var system = {};
	var p = navigator.platform;
	var u = navigator.userAgent;
	console.log("platform = "+p);
	console.log("userAgent = "+u);

	system.win = p.indexOf("Win") == 0;
	system.mac = p.indexOf("Mac") == 0;
	system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);

	if (system.win || system.mac || system.xll) {//如果是PC端
		if ((u.indexOf('iPhone')>-1) || (u.indexOf('Android')>-1)) {  //win手机端
			console.log("win手机端");
		}else {
			console.log("PC端");
			//window.location.href = "exception.jsp";
			document.write("页面出错啦");
			/*var url = window.location.href;
			console.log("url = "+url);
			//给exception.jsp页面放行
			if (url.indexOf('exception.jsp')>-1) {
				console("exception.jsp页面放行");
			} else {
				console("exception.jsp页面放行");
			}*/
			//window.location.href = " <%=ctx%>/jsp/mobile/allChannel/addChannelPCerror.jsp";
		}
	}
});	
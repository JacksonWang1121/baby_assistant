/* 检查上传文件的格式 */
function checkFile(file) {
    var value = $(file).val();
    var fileName = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
	if (fileName !== "png" && fileName !== "jpg" && fileName !== "jpeg" && fileName !== "gif") {
        //清除输入框后面的文件，即删除img元素
        var element = $(file).nextAll("img");
		console.log("checkFile-element_length = "+element.length);
		if (element.length > 0) {
			for (var i = 0; i < element.length; i++) {
		    	element.eq(i).remove();
				console.log("checkFile-element("+i+") is removed.");
			}
		}
        //清空输入框
        $(file).val("");
        //$(file).get(0).outerHTML=$(file).get(0).outerHTML.replace(/(value=\").+\"/i,"$1\"");
        alert("上传图片格式不正确，请重新上传");
    }
}

/* 显示文件 */
function showFile(file) {
	//清除输入框后面的文件，即删除img元素
    var element = $(file).nextAll("img");
	console.log("checkFile-element_length = "+element.length);
	if (element.length > 0) {
		for (var i = 0; i < element.length; i++) {
	    	element.eq(i).remove();
			console.log("showFile-element("+i+") is removed.");
		}
	}
	//获取上传文件
	var files = $(file)[0].files;
	console.log("showFile-files_length = "+files.length);
	if (files.length > 0) {
		for (var i = 0; i < files.length; i++) {
			//获取上传文件的绝对路径
		    var url = getObjectURL($(file)[0].files[i]);
			$(file).after('<img width="100px" alt="该图片不存在" src="'+url+'">');
		}
	}
}

/* 获取上传文件的绝对路径 */
function getObjectURL(file) {
    var url = null ;
    if (window.createObjectURL!=undefined) { // basic
        url = window.createObjectURL(file) ;
    } else if (window.URL!=undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file) ;
    } else if (window.webkitURL!=undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file) ;
    }
    console.log("getObjectURL-url = "+url);
    return url ;
}
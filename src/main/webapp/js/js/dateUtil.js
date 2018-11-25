//获取某年某周的开始日期
function getBeginDateOfWeek(paraYear, weekIndex){
	var firstDay = GetFirstWeekBegDay(paraYear);
	//7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
	var time=(weekIndex-1)*7*24*3600000;
	var beginDay = firstDay;
	//为日期对象 date 重新设置成时间 time
	beginDay.setTime(firstDay.valueOf()+time);
	return formatDate(beginDay);
}

//获取某年某周的结束日期
function getEndDateOfWeek(paraYear, weekIndex){
	var firstDay = GetFirstWeekBegDay(paraYear);
	//7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
	var time=(weekIndex-1)*7*24*3600000;
	var weekTime = 6*24*3600000;
	var endDay = firstDay;
	//为日期对象 date 重新设置成时间 time
	endDay.setTime(firstDay.valueOf()+weekTime+time);
	return formatDate(endDay);
}

//获取某年的第一天
function GetFirstWeekBegDay(year) {
	var tempdate = new Date(year, 0, 1);
	var temp = tempdate.getDay();
	if (temp == 1){
		return tempdate;
	}
	temp = temp==0?7:temp;
	tempdate = tempdate.setDate(tempdate.getDate() + (8 - temp));
	return new Date(tempdate);
}

//格式化日期：yyyy-MM-dd HH:mm:ss
function formatDate(date) {
	//年
	var year = date.getFullYear();
	//月
	var month = twoDigits(date.getMonth()+1);
	//日
	var day = twoDigits(date.getDate());
  //星期几
	var week = " 星期" + "日一二三四五六 ".charAt(date.getDay());
	//时
	var hour = twoDigits(date.getHours());
	//分
	var min = twoDigits(date.getMinutes());
	//秒
	var sec = twoDigits(date.getSeconds());

	return (year+"-"+month+"-"+day);
}

/* 月日时分秒中个位数格式化两位数 */
function twoDigits(val) {
  if (val < 10) {
  	return "0" + val;
  }
  return val;
}

/* 字符串转换成日期 */
function parseDate(dateStr){
    var dateArr = dateStr.split("-");
    var year = parseInt(dateArr[0]);
    //处理月份为04这样的情况
    var month;
    if(dateArr[1].indexOf("0") == 0){
        month = parseInt(dateArr[1].substring(1));
    }else{
         month = parseInt(dateArr[1]);
    }
    //同月份处理方式
    var day;
    if(dateArr[2].indexOf("0") == 0){
        day = parseInt(dateArr[2].substring(1));
    }else{
        day = parseInt(dateArr[2]);
    }
    var date = new Date(year,month-1,day);
    return date;
}
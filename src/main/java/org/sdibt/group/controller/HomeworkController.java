package org.sdibt.group.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.converter.StringToDateConverter;
import org.sdibt.group.entity.Homework;
import org.sdibt.group.service.IHomeworkService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeworkController {
	@Resource
	private IHomeworkService homeworkservice;

	public IHomeworkService getHomeworkservice() {
		return homeworkservice;
	}

	public void setHomeworkservice(IHomeworkService homeworkservice) {
		this.homeworkservice = homeworkservice;
	}


	/**
     * 通过班级Id查看班级作业信息
     */
	@RequestMapping("/listHomeworkByClassId")
	public String lisHomeworkByClassId(Map map) {
		int classId = 1;
		if (classId > 0) {
			List<Map> homeworks = this.homeworkservice
					.listHomeworkByClassId(classId);
			if (homeworks != null) {
				map.put("homeworks", homeworks);
				return "homework";
			} else {
				return "homework";
			}
		}else{
		return "format";
		}
	}

	/**
     * 添加班级作业
     */
	@ResponseBody
	@RequestMapping("/saveHomework")
	public String saveHomework(HttpSession session, Homework homework) {
		long teacherId1 = (long) session.getAttribute("userId");
		int teacherId = (int) teacherId1;
		int classId = 1;
		// Date homeworkDate=stringToDateConverter.convert(new Date());
		SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String homeworkDate = tempDate.format(new Date());
		homework.setHomeworkDate(homeworkDate);
		homework.setClassId(classId);
		homework.setTeacherId(teacherId);
		if(homework!=null){
	
			Boolean result= this.homeworkservice.saveHomework(homework);
			if(result==true){
				return "true";
			}else{
				return "false";
			}
		}else{
			return "format";
		}
			
	}
	/**
     * 通过作业Id删除班级作业
     */
	@ResponseBody
	@RequestMapping("/deleteHomeworkByHomeworkId")
	public String deleteHomeworkByHomeworkId(int homeworkId){
		if(homeworkId>0){
			Boolean  deleteResult=this.homeworkservice.deleteHomeworkByHomeworkId(homeworkId);
			if(deleteResult==true){
				return "true";
			}else{
				return "false";
			}
		}else{
			return "formatFail";
		}
	}
	
	
	

}

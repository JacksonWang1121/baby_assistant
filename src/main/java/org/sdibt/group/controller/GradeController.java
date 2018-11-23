package org.sdibt.group.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.entity.Grade;
import org.sdibt.group.service.IGradeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GradeController {
  
	@Resource
	private  IGradeService gradeService;

	public IGradeService getGradeService() {
		return gradeService;
	}

	public void setGradeService(IGradeService gradeService) {
		this.gradeService = gradeService;
	}
	@RequestMapping("/listGrade")
	public String listGrade(Map map){
		List<Grade>  grade=this.gradeService.listGrade();
	map.put("grade", grade);
		return "addClass"; 
	}
	
	
	
	
	
	
	
	
	
}

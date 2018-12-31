package org.sdibt.group.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Class;
import org.sdibt.group.entity.WeeklyPlan;
import org.sdibt.group.service.IWeeklyPlanService;
import org.sdibt.group.utils.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * weeklyPlan业务流程层
 * @title WeeklyPlanController.java
 * @author JacksonWang
 * @date 2018年11月21日 下午4:52:54
 * @package org.sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/weeklyPlan")
public class WeeklyPlanController {

	@Resource
	private IWeeklyPlanService weeklyPlanService;

	public void setWeeklyPlanService(IWeeklyPlanService weeklyPlanService) {
		this.weeklyPlanService = weeklyPlanService;
	}

	/**
	 * 查询周计划
	 * @return
	 */
	@RequestMapping("/findWeeklyPlan")
	@ResponseBody
	public WeeklyPlan findWeeklyPlan(HttpSession session, String weekNum) {
		//从session作用域中获取classInfo
		org.sdibt.group.entity.Class cls = (Class) session.getAttribute("classInfo");
		System.out.println("WeeklyPlanController::findWeeklyPlan-classId = "+cls.getClassId());
		//空处理
		if ("".equals(weekNum)) {
			//查询本周的周计划
			weekNum = "0";
		}
		WeeklyPlan weeklyPlan = this.weeklyPlanService.findWeeklyPlan(cls.getClassId(), Integer.parseInt(weekNum));
		return weeklyPlan;
	}

	/**
	 * 查询周计划
	 * @return
	 */
	@RequestMapping("/findWeeklyPlanById")
	@ResponseBody
	public WeeklyPlan findWeeklyPlanById(String planId) {
		WeeklyPlan weeklyPlan = null;
		if ("".equals(planId) || planId==null) {
			return null;
		} else {
			weeklyPlan = this.weeklyPlanService.findWeeklyPlanById(Integer.parseInt(planId));
		}
		return weeklyPlan;
	}

	/**
	 * 添加周计划
	 * @param weeklyPlan
	 * @return
	 */
	@RequestMapping("/saveWeeklyPlan")
	@ResponseBody
	public String saveWeeklyPlan(HttpServletRequest request, WeeklyPlan weeklyPlan, MultipartFile weekPhoto) {
		if (weeklyPlan.getWeekDate() == null) {
			System.out.println("WeeklyPlanController::saveWeeklyPlan:failed...");
			return "false";
		} else {
			//获取session
			HttpSession session = request.getSession();
			//从session作用域中获取classInfo
			org.sdibt.group.entity.Class cls = (Class) session.getAttribute("classInfo");
			weeklyPlan.setClassId(cls.getClassId());
			//上传文件
			if (weekPhoto != null) {
				String fileName = FileUtil.uploadFile(request, weekPhoto, "images/weeklyPlan");
				weeklyPlan.setWeekPicture("images/weeklyPlan/"+fileName);
			}
			boolean isSave = this.weeklyPlanService.saveWeeklyPlan(weeklyPlan);
			if (isSave) {
				return "true";
			}
		}
		return "false";
	}

	/**
	 * 修改周计划
	 * @param weeklyPlan
	 * @return
	 */
	@RequestMapping("/updateWeeklyPlan")
	@ResponseBody
	public String updateWeeklyPlan(HttpServletRequest request, WeeklyPlan weeklyPlan, MultipartFile weekPhoto) {
		System.out.println("mondayMorning = "+weeklyPlan.getMondayMorning());
		//上传文件
		if (weekPhoto != null) {
			String fileName = FileUtil.uploadFile(request, weekPhoto, "images/weeklyPlan");
			weeklyPlan.setWeekPicture("images/weeklyPlan/"+fileName);
		}
		boolean isUpdate = this.weeklyPlanService.updateWeeklyPlan(weeklyPlan);
		if (isUpdate) {
			return "true";
		}
		return "false";
	}

}

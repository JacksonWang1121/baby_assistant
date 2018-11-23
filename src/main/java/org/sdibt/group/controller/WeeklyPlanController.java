package org.sdibt.group.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Class;
import org.sdibt.group.entity.WeeklyPlan;
import org.sdibt.group.service.IWeeklyPlanService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

}

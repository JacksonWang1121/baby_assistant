package org.sdibt.group.service;

import org.sdibt.group.entity.WeeklyPlan;

/**
 * weeklyPlan业务逻辑接口
 * @title WeeklyPlanService.java
 * @author JacksonWang
 * @date 2018年11月19日 下午4:54:36
 * @package org.sdibt.group.service
 * @version 1.0
 *
 */
public interface IWeeklyPlanService {

	/**
	 * 查询周计划
	 * @param classId
	 * @param weekNum
	 * @return
	 */
	public WeeklyPlan findWeeklyPlan(int classId, int weekNum);

}

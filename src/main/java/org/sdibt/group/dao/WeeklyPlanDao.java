package org.sdibt.group.dao;

import java.util.Map;

import org.sdibt.group.entity.WeeklyPlan;

/**
 * weeklyPlan数据访问层
 * @title WeeklyPlanDao.java
 * @author JacksonWang
 * @date 2018年11月19日 下午4:52:27
 * @package org.sdibt.group.dao
 * @version 1.0
 *
 */
public interface WeeklyPlanDao {

	/**
	 * 查询周计划
	 * @param week
	 * @return
	 */
	public WeeklyPlan findWeeklyPlan(Map week);

	/**
	 * 查询周计划
	 * @param planId
	 * @return
	 */
	public WeeklyPlan findWeeklyPlanById(int planId);

	/**
	 * 添加周计划
	 * @param weeklyPlan
	 */
	public int saveWeeklyPlan(WeeklyPlan weeklyPlan);

	/**
	 * 修改周计划
	 * @param weeklyPlan
	 */
	public int updateWeeklyPlan(WeeklyPlan weeklyPlan);

}

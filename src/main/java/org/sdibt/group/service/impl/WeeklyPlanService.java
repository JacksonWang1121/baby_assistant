package org.sdibt.group.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.WeeklyPlanDao;
import org.sdibt.group.entity.WeeklyPlan;
import org.sdibt.group.service.IWeeklyPlanService;
import org.sdibt.group.utils.DateUtil;
import org.sdibt.group.utils.FileUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * WeeklyPlan业务逻辑层
 * @title WeeklyPlanService.java
 * @author JacksonWang
 * @date 2018年11月19日 下午4:56:32
 * @package org.sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class WeeklyPlanService implements IWeeklyPlanService {

	@Resource
	private WeeklyPlanDao weeklyPlanDao;
	//文件访问路径
	private String filePath = FileUtil.httpFilePath + "images/weeklyPlan/";

	public void setWeeklyPlanDao(WeeklyPlanDao weeklyPlanDao) {
		this.weeklyPlanDao = weeklyPlanDao;
	}

	/**
	 * 查询周计划
	 * @param classId
	 * @param weekNum-以本周为基础，向前或向后推的周数,如-2表示上上周
	 * @return
	 */
	@Override
	public WeeklyPlan findWeeklyPlan(int classId, int weekNum) {
		//得到日历实例
		Calendar c = Calendar.getInstance();
		//设置星期一为每周的第一天
		c.setFirstDayOfWeek(Calendar.MONDAY);
		//今天的日期
		Date date = new Date();
		//向日历中插入日期
		c.setTime(date);
		//获取当前年份
		int curYear = c.get(Calendar.YEAR);
		//获取当前周是今年的第几周,从1开始计算
		int curWeek = c.get(Calendar.WEEK_OF_YEAR);
		//得到要查询的周时间
		String weekDate = obtainedWeekDate(curYear, curWeek, weekNum, c);
		System.out.println("WeeklyPlanService::findWeeklyPlan-weekDate = "+weekDate);
		Map week = new HashMap();
		week.put("classId", classId);
		week.put("weekDate", weekDate);
		WeeklyPlan weeklyPlan = this.weeklyPlanDao.findWeeklyPlan(week);
		//若查询不到周计划，则只是单纯的吧周时间加到weeklyPlan对象中，为了页面显示该周时间
		if (weeklyPlan == null) {
			weeklyPlan = new WeeklyPlan();
			weeklyPlan.setWeekDate(weekDate);
		} else {
			if (weeklyPlan.getWeekPicture() != null) {
				weeklyPlan.setWeekPicture(filePath + weeklyPlan.getWeekPicture());
			}
		}
		return weeklyPlan;
	}

	/**
	 * 查询周计划
	 * @param planId
	 * @return
	 */
	@Override
	public WeeklyPlan findWeeklyPlanById(int planId) {
		WeeklyPlan weeklyPlan = this.weeklyPlanDao.findWeeklyPlanById(planId);
		if (weeklyPlan.getWeekPicture()!= null) {
			weeklyPlan.setWeekPicture(filePath+weeklyPlan.getWeekPicture());
		}
		return weeklyPlan;
	}

	/**
	 * 添加周计划
	 * @param weeklyPlan
	 */
	@Transactional
	@Override
	public boolean saveWeeklyPlan(WeeklyPlan weeklyPlan) {
		int count = this.weeklyPlanDao.saveWeeklyPlan(weeklyPlan);
		if (count == 1) {
			return true;
		}
		return false;
	}

	/**
	 * 修改周计划
	 * @param weeklyPlan
	 */
	@Transactional
	@Override
	public boolean updateWeeklyPlan(WeeklyPlan weeklyPlan) {
		int count = this.weeklyPlanDao.updateWeeklyPlan(weeklyPlan);
		if (count == 1) {
			return true;
		}
		return false;
	}

	/**
	 * 得到要查询的周时间
	 */
	private String obtainedWeekDate(int curYear, int curWeek, int weekNum, Calendar c) {
		System.out.println("--------<<正在计算周时间>>---------");
		System.out.println("当前年份："+curYear);
		System.out.println("当前周："+curWeek);
		System.out.println("查询周数："+weekNum);
		try {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			// 获取今年的最大周数
			int curWeekOfYear = DateUtil.getMaxWeekNumOfYear(curYear);
			System.out.println(curYear+"年的总周数："+curWeekOfYear);
			//根据curWeek与weekNum的和值判断要查询的年份是上几年还是下几年
			int value = curWeek + weekNum;
			//若curWeek+weekNum>0，则表示查询的周是今年的周或下一年的周
			if (value > 0) {
				//若value在今年总周数的范围内，则直接返回要查询的周
				if (curWeekOfYear >= value) {
					//若要查询的周时间正好是今年的最后一个周，且若今年的最后一个周和下一年的第一个周在同一个周内，
					//则默认表示为下一年的第一个周
					if (curWeekOfYear == value) {
						System.out.println("最终周时间为"+(curYear+1)+"-1");
						return (curYear+1)+"-1";
					}
					System.out.println("最终周时间为"+curYear+"-"+value);
					return curYear+"-"+value;
				}
				//若value值超出今年总周数的范围，则递归执行
				else {
					//curYear为下一年,curWeek为下一年的第一个周,weekNum为超出部分的差值
					obtainedWeekDate(curYear+1, 1, value-curWeekOfYear, c);
				}
			}
			//若curWeek+weekNum<=0，则表示查询的周是上一年的周,递归执行
			else {
				//日历翻到上一年的最后一天
				c.setTime(sf.parse((curYear-1)+"-12-31"));
				//上一年的总周数
				int prevWeekOfYear = c.get(Calendar.WEEK_OF_YEAR);
				//curYear为下一年,curWeek为下一年的第一个周,weekNum为超出部分的差值
				obtainedWeekDate(curYear-1, prevWeekOfYear, value, c);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

}

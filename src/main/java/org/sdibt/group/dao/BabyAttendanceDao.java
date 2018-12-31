package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyAttendance;

/**
 * 
 * Title:BabyAttendanceDao
 * @author hanfangfang
 * date:2018年8月31日 下午5:07:53
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface BabyAttendanceDao {
	/**
	 * 查询该教师所在班级的所有学生
	 * @param userId
	 * @return
	 */
	public List<Baby> listBabies(int userId);
	/**
	 * 根据宝宝id和当前日期查询宝宝是否已经签到
	 * @return
	 */
	public List<BabyAttendance> isExistAttendance(Map map);
	/**
	 * 宝宝签到
	 * @return
	 */
	public int saveAttendance(Map map);
	/**
	 * 班级考勤
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listClassAttendance(int userId);
	/**
	 * 统计班级考勤记录共多少条
	 * @return
	 */
	public int countClassAttendance(Map map);
	/**
	 * 条件查询班级考勤信息
	 * @return
	 */
	public List<BabyAttendance> listClassAttendanceByTerm(Map map);
	/**
	 * 查询今日出勤人数
	 * @return
	 */
	public int countAttendanceSize(Map map);
	/**
	 * 查询班级总人数
	 * @param userId
	 * @return
	 */
	public int countClassSize(int userId);
	/**
	 * 统计宝宝考勤记录共多少条
	 * @return
	 */
	public int countBabyAttendance(Map map);
	/**
	 * 宝宝考勤
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listBabyAttendance(int userId);
	//public List<BabyAttendance> listBabyAttendance(Map map);
	/**
	 * 条件查询宝宝考勤信息
	 * @param userId
	 * @return
	 */
	public List<BabyAttendance> listBabyAttendanceByTerm(Map map);
}

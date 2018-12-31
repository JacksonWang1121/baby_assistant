package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyAttendance;
import org.sdibt.group.vo.PageVO;

/**
 * 
 * Title:BabyService
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:57
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IBabyAttendanceService {
	/**
	 * 查询该教师所在班级的所有学生
	 * @param userId
	 * @return
	 */
	public List<Baby> listBabies(int userId);
	/**
	 * 根据宝宝id和当前日期查询宝宝是否已经签到
	 * @param babyId
	 * @return
	 */
	public boolean isExistAttendance(String babyId);
	/**
	 * 宝宝签到
	 * @param babyId
	 * @return
	 */
	public boolean saveAttendance(String babyId);
	/**
	 * 班级考勤
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listClassAttendance(int userId);
	/**
	 * 条件查询班级考勤信息
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listClassAttendanceByTerm(Baby baby,BabyAttendance babyAttendance,int userId);
	public PageVO listClassAttendanceByTerm(Baby baby,BabyAttendance babyAttendance,int curPage, int pageSize);
	/**
	 * 班级出勤率统计图示
	 * @return
	 */
	Map countAttendanceRate(int userId);
	/**
	 * 宝宝考勤
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listBabyAttendance(int userId);
	//public PageVO listBabyAttendance(int curPage, int pageSize,int userId);
	/**
	 * 条件查询宝宝考勤信息
	 * @param userId
	 * @return
	 */
	//public List<BabyAttendance> listBabyAttendanceByTerm(String startSignDate,String endSignDate,int userId);
	public PageVO listBabyAttendanceByTerm(String startSignDate,String endSignDate,int userId,int curPage, int pageSize);
}

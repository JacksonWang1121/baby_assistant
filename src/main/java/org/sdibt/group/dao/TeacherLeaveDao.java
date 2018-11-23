package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.TeacherLeave;


/**
 * 
 * Title:TeacherLeaveDao
 * @author hanfangfang
 * date:2018年10月23日 上午10:39:50
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface TeacherLeaveDao {
	/**
	 * 教师请假条数
	 * @param termMap
	 * @return
	 */
	public int countTeacherLeave(Map termMap);
	/**
	 * 教师请假列表
	 * @param map
	 * @return
	 */
	public List<TeacherLeave> listLeaveInfoById(Map map);
	/**
	 * 提交请假申请
	 * @param map
	 * @return
	 */
	public int saveLeaveInfo(Map map);
	/**
	 * 教师请假申请
	 */
	public List<TeacherLeave> listLeaveApplication(Map teacherLeaveMap);
	/**
	 * 教师请假审核
	 */
	public int auditLeaveApplication(Map map);
}

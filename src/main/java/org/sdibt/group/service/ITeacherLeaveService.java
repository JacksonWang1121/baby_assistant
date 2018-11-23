package org.sdibt.group.service;

import java.util.List;

import org.sdibt.group.entity.TeacherLeave;
import org.sdibt.group.vo.PageVO;


/**
 * 
 * Title:ITeacherLeaveService
 * @author hanfangfang
 * date:2018年10月23日 上午10:37:31
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface ITeacherLeaveService {
	/**
	 * 教师请假列表
	 * @param userId
	 * @return
	 */
	public PageVO listLeaveInfoById(int curPage,int pageSize,Long userId,String startDate,String endDate);
	/**
	 * 提交请假申请
	 * @param teacherLeave
	 * @return
	 */
	public boolean saveLeaveInfo(TeacherLeave teacherLeave);
	/**
	 * 教师请假申请
	 * @return
	 */
	public List<TeacherLeave> listLeaveApplication(int kindergartenId);
	/**
	 * 教师请假审核
	 * @return
	 */
	public boolean auditLeaveApplication(int leaveId,String audit);
}

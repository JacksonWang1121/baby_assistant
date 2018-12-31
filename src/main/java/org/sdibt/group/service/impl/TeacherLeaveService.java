package org.sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.TeacherLeaveDao;
import org.sdibt.group.entity.TeacherLeave;
import org.sdibt.group.service.ITeacherLeaveService;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
/**
 * 
 * Title:TeacherLeaveService
 * @author hanfangfang
 * date:2018年10月23日 上午10:38:58
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class TeacherLeaveService implements ITeacherLeaveService {
	@Resource
	private TeacherLeaveDao teacherLeaveDao;

	public TeacherLeaveDao getTeacherLeaveDao() {
		return teacherLeaveDao;
	}
	public void setTeacherLeaveDao(TeacherLeaveDao teacherLeaveDao) {
		this.teacherLeaveDao = teacherLeaveDao;
	}
	/**
	 * 教师请假列表
	 */
	@Override
	public PageVO listLeaveInfoById(int curPage,int pageSize,int userId,String startDate,String endDate) {
		if(endDate==""){
			//得到当前日期
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//将Date类型转换成String类型   
			String currentDate = sdf.format(date);
			endDate=currentDate;
		}
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取宝宝所有考勤信息的数量
		Map<Object,Object> termMap = new HashMap<>();
		termMap.put("userId", userId);
		termMap.put("startDate", startDate);
		termMap.put("endDate", endDate);
		//获取教师请假的数量
		int count = this.teacherLeaveDao.countTeacherLeave(termMap);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<TeacherLeave> teacherLeave = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			teacherLeave = this.teacherLeaveDao.listLeaveInfoById(map);
		}
		//将数据存储到pv中
		pv.setDatas(teacherLeave);
		return pv;
	}
	/**
	 * 提交请假申请
	 */
	@Transactional
	@Override
	public boolean saveLeaveInfo(TeacherLeave teacherLeave) {
		//得到当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//将Date类型转换成String类型   
		String submitDate = sdf.format(date);  
		HashMap leaveMap = new HashMap<>();
		leaveMap.put("userId", teacherLeave.getUserId());
		leaveMap.put("realName", teacherLeave.getRealName());
		leaveMap.put("leaveTime", teacherLeave.getLeaveTime());
		leaveMap.put("leaveReason", teacherLeave.getLeaveReason());
		leaveMap.put("leaveStatus", "待审核");
		leaveMap.put("submitDate", submitDate);
		int count = this.teacherLeaveDao.saveLeaveInfo(leaveMap);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 教师请假申请
	 */
	@Override
	public List<TeacherLeave> listLeaveApplication(int kindergartenId) {
		Map teacherLeaveMap = new HashMap<>();
		teacherLeaveMap.put("kindergartenId", kindergartenId);
		teacherLeaveMap.put("leaveStatus", "待审核");
		return this.teacherLeaveDao.listLeaveApplication(teacherLeaveMap);
	}
	/**
	 * 教师请假审核
	 */
	@Transactional
	@Override
	public boolean auditLeaveApplication(int leaveId, String audit) {
		String leaveStatus=null;
		if("同意".equals(audit)){
			leaveStatus="通过";
		}else{
			leaveStatus="未通过";
		}
		HashMap auditMap = new HashMap<>();
		auditMap.put("leaveId", leaveId);
		auditMap.put("leaveStatus", leaveStatus);
		int count = this.teacherLeaveDao.auditLeaveApplication(auditMap);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
}

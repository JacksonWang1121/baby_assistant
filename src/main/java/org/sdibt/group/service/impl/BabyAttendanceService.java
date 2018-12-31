package org.sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.BabyAttendanceDao;
import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyAttendance;
import org.sdibt.group.service.IBabyAttendanceService;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * Title:BabyServiceImpl
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:53
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class BabyAttendanceService implements IBabyAttendanceService {
	@Resource
	private BabyAttendanceDao babyAttendanceDao;

	public BabyAttendanceDao getBabyAttendanceDao() {
		return babyAttendanceDao;
	}
	public void setBabyAttendanceDao(BabyAttendanceDao babyAttendanceDao) {
		this.babyAttendanceDao = babyAttendanceDao;
	}
	
	/**
	 * 查询该教师所在班级的所有学生
	 */
	@Override
	public List<Baby> listBabies(int userId) {
		return this.babyAttendanceDao.listBabies(userId);
	}
	/**
	 * 根据宝宝id和当前日期查询宝宝是否已经签到
	 */
	@Override
	public boolean isExistAttendance(String babyId) {
		//解析获取到的宝宝id
		String babyId1 = babyId.replaceAll("\"", "");
		String babyId2 = babyId1.replace("[", "");
		String babyIds = babyId2.replace("]", "");
		//得到当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//将Date类型转换成String类型   
	    String currentDate = sdf.format(date);       
		Map map = new HashMap<>();
		map.put("babyId", babyIds);
		map.put("currentDate", currentDate);
		//查询当前日期宝贝是否已签到
		List<BabyAttendance> attendance = this.babyAttendanceDao.isExistAttendance(map);
		if(attendance.size()==0){
			//若不存在，返回false
			return false;
		}else{
			//若存在返回true
			return true;
		}
	}
	/**
	 * 宝宝签到
	 * @param babyId
	 * @return
	 */
	@Transactional
	@Override
	public boolean saveAttendance(String babyId) {
		//得到当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//将Date类型转换成String类型   
		String currentDate = sdf.format(date); 
		//解析获取到的宝宝id
		String babyId1 = babyId.replaceAll("\"", "");
		String babyId2 = babyId1.replace("[", "");
		String bIds = babyId2.replace("]", "");
		ArrayList babyIds = new ArrayList<>();
		//若字符串中包含逗号
		if(bIds.contains(",")){
			//将解析后的字符串分割并添加到list中
			String[] strs = bIds.split(",");
			for (int i = 0; i < strs.length; i++) {
				babyIds.add(strs[i]);
			}
		}else{
			babyIds.add(bIds);
		}
		int count = 0;
		//遍历list集合
		for (int i = 0; i < babyIds.size(); i++) {
			HashMap map = new HashMap<>();
			map.put("currentDate", currentDate);
			map.put("babyId", babyIds.get(i));
			count = this.babyAttendanceDao.saveAttendance(map);
		}
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 班级考勤
	 */
	/*@Override
	public List<BabyAttendance> listClassAttendance(int userId) {
		return this.babyAttendanceDao.listClassAttendance(userId);
	}*/
	/**
	 * 条件查询班级考勤信息
	 */
	@Override
	public PageVO listClassAttendanceByTerm(Baby baby,BabyAttendance babyAttendance,int curPage, int pageSize){
		//获取查询条件
		String startDate = babyAttendance.getStartSignDate();
		String endDate = babyAttendance.getEndSignDate();
		String babyNo = baby.getBabyNo();
		String babyName = baby.getBabyName();
		int userId = baby.getUserId();
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
		termMap.put("babyNo", babyNo);
		termMap.put("babyName", babyName);
		termMap.put("startDate", startDate);
		termMap.put("endDate", endDate);
		int count = this.babyAttendanceDao.countClassAttendance(termMap);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<BabyAttendance> classAttendance = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			map.put("babyNo", babyNo);
			map.put("babyName", babyName);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			classAttendance = this.babyAttendanceDao.listClassAttendanceByTerm(map);
		}
		//将数据存储到pv中
		pv.setDatas(classAttendance);
		return pv;
	}
	/**
	 *班级出勤率统计图示
	 * @return
	 */
	@Override
	public Map countAttendanceRate(int userId){
		//得到当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//将Date类型转换成String类型   
		String currentDate = sdf.format(date);
		Map map = new HashMap<>();
		map.put("userId", userId);
		map.put("currentDate", currentDate);
		//查询今日出勤人数
		int attendanceSize = this.babyAttendanceDao.countAttendanceSize(map);
		//查询班级总人数
		int classSize = this.babyAttendanceDao.countClassSize(userId);
		int notAttendanceSize=classSize-attendanceSize;
		Map attendanceRate = new HashMap<>();
		attendanceRate.put("attendanceSize", attendanceSize);
		attendanceRate.put("notAttendanceSize", notAttendanceSize);
		return attendanceRate;
	}
	/**
	 * 宝宝考勤
	 */
	/*@Override
	public List<BabyAttendance> listBabyAttendance(int userId) {
		// TODO Auto-generated method stub
		return this.babyAttendanceDao.listBabyAttendance(userId);
	}*/
	/**
	 * 条件查询宝宝考勤信息
	 */
	@Override
	public PageVO listBabyAttendanceByTerm(String startSignDate,
			String endSignDate, int userId,int curPage, int pageSize) {
		if(endSignDate==""){
			//得到当前日期
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//将Date类型转换成String类型   
			String currentDate = sdf.format(date);
			endSignDate=currentDate;
		}
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取宝宝所有考勤信息的数量
		Map<Object,Object> termMap = new HashMap<>();
		termMap.put("userId", userId);
		termMap.put("startDate", startSignDate);
		termMap.put("endDate", endSignDate);
		int count = this.babyAttendanceDao.countBabyAttendance(termMap);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<BabyAttendance> babyAttendance = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			map.put("startDate", startSignDate);
			map.put("endDate", endSignDate);
			babyAttendance = this.babyAttendanceDao.listBabyAttendanceByTerm(map);
		}
		//将数据存储到pv中
		pv.setDatas(babyAttendance);
		return pv;
	}
}

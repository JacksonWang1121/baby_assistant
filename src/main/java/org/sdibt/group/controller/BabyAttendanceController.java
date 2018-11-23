package org.sdibt.group.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyAttendance;
import org.sdibt.group.service.IBabyAttendanceService;
import org.sdibt.group.utils.ExcelUtils;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * Title:BabyAttendanceController
 * @author hanfangfang
 * date:2018年8月31日 下午5:06:38
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class BabyAttendanceController {
	@Resource
	private IBabyAttendanceService babyAttendanceService;

	public IBabyAttendanceService getbabyAttendanceService() {
		return babyAttendanceService;
	}
	public void setbabyAttendanceService(IBabyAttendanceService babyAttendanceService) {
		this.babyAttendanceService = babyAttendanceService;
	}
	/**
	 * 根据当前登录用户id查询宝宝信息
	 * @param babyId
	 * @return
	 */
	@RequestMapping("/listBabies")
	public String isExistAttendance(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		List<Baby> babies = this.babyAttendanceService.listBabies(userId);
		map.put("babies", babies);
		return "babySign";
	}
	/**
	 * 根据宝宝id和当前日期查询宝宝是否已经签到
	 * @param babyId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/isExistAttendance")
	public boolean isExistAttendance(String babyId){
		boolean existReault = this.babyAttendanceService.isExistAttendance(babyId);
		return existReault;
	}
	/**
	 * 宝宝签到
	 * @param babyId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/babiesSign")
	public boolean saveAttendance(String babyId){
		boolean saveResult = this.babyAttendanceService.saveAttendance(babyId);
		return saveResult;
	}
	
	/**
	 * 根据当前登录用户id查询宝宝信息
	 * @param babyId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/listAllBabies")
	public List<Baby> listAllBabies(HttpSession session){
		Long userId=(Long) session.getAttribute("userId");
		List<Baby> babies = this.babyAttendanceService.listBabies(userId);
		return babies;
	}
	/**
	 * 班级考勤
	 */
	/*@RequestMapping("/listClassAttendance")
	public String listClassAttendance(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		List<BabyAttendance> attendances = this.babyAttendanceService.listClassAttendance(userId);
		map.put("attendances", attendances);
		return "class_attendance";
	}*/
	@RequestMapping("/listClassAttendance")
	public String listClassAttendance(HttpSession session,Map map,Baby baby,BabyAttendance babyAttendance){
		Long userId=(Long) session.getAttribute("userId");
		baby.setUserId(userId);
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.babyAttendanceService.listClassAttendanceByTerm(baby,babyAttendance,curPage, pageSize);
		//将movieHalls放入request作用域
		map.put("pv", pv);
		return "classAttendance";
	}
	/**
	 * 条件查询班级考勤信息
	 */
	@RequestMapping("/listClassAttendanceByTerm")
	public String listClassAttendanceByTerm(HttpSession session,Map map,int curPage, int pageSize,Baby baby,BabyAttendance babyAttendance){
		PageVO pageVO = new PageVO();
		//若curPage小于或等于0，则设置为1
		if (curPage<=0) {
			curPage = pageVO.getCurPage();
		}
		//若pageSize小于或等于0，则设置为10
		if (pageSize<=0) {
			pageSize = pageVO.getPageSize();
		}
		Map conditionsMap = new HashMap();
		conditionsMap.put("curPage", curPage);
		conditionsMap.put("pageSize", pageSize);
		conditionsMap.put("babyNo", baby.getBabyNo());
		conditionsMap.put("babyName", baby.getBabyName());
		conditionsMap.put("startSignDate", babyAttendance.getStartSignDate());
		conditionsMap.put("endSignDate", babyAttendance.getEndSignDate());
		Long userId=(Long) session.getAttribute("userId");
		baby.setUserId(userId);
		PageVO pv = this.babyAttendanceService.listClassAttendanceByTerm(baby,babyAttendance,curPage,pageSize);
		map.put("pv", pv);
		map.put("conditionsMap", conditionsMap);
		return "classAttendance";
	}
	/**
	 * 班级出勤率统计图示:依赖h5
	 */
	@ResponseBody
	@RequestMapping("/countAttendanceRate")
	public Map countAttendanceRate(HttpSession session){
		Long userId=(Long) session.getAttribute("userId");
		 //获取数据
		 Map attendanceRate = this.babyAttendanceService.countAttendanceRate(userId);
		 //造符合ECHARTS的数据
		 Map resultMap =new HashMap();
		 List labels=new ArrayList<String>();
		 List nums=new ArrayList<Integer>();
		 labels.add("出勤人数");
		 labels.add("缺勤人数");
		 nums.add(attendanceRate.get("attendanceSize"));
		 nums.add(attendanceRate.get("notAttendanceSize"));
		 resultMap.put("type", "出勤人数");
		 resultMap.put("type1", "缺勤人数");
		 resultMap.put("labels", labels);
		 resultMap.put("nums", nums);
		 return resultMap;
	}
	/**
	 * 宝宝考勤
	 */
	/*@RequestMapping("/listBabyAttendance")
	public String listBabyAttendance(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		List<BabyAttendance> attendances = this.babyAttendanceService.listBabyAttendance(userId);
		map.put("attendances", attendances);
		return "baby_attendance";
	}*/
	@RequestMapping("/listBabyAttendance")
	public String listBabyAttendance(HttpSession session,Map map,String startSignDate,String endSignDate){
		Long userId=(Long) session.getAttribute("userId");
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.babyAttendanceService.listBabyAttendanceByTerm(startSignDate,endSignDate,userId,curPage,pageSize);
		//将movieHalls放入request作用域
		map.put("pv", pv);
		return "listBabyAttendance";
	}
	/**
	 * 条件查询宝宝考勤信息
	 */
	/*@RequestMapping("/listBabyAttendanceByTerm")
	public String listBabyAttendanceByTerm(HttpSession session,Map map,String startSignDate,String endSignDate){
		Long userId=(Long) session.getAttribute("userId");
		List<BabyAttendance> attendances = this.babyAttendanceService.listBabyAttendanceByTerm(startSignDate,endSignDate,userId);
		map.put("attendances", attendances);
		return "baby_attendance";
	}*/
	@RequestMapping("/listBabyAttendanceByTerm")
	public String listBabyAttendanceByTerm(HttpSession session,Map map,int curPage, int pageSize,String startSignDate,String endSignDate){
		PageVO pageVO = new PageVO();
		//若curPage小于或等于0，则设置为1
		if (curPage<=0) {
			curPage = pageVO.getCurPage();
		}
		//若pageSize小于或等于0，则设置为10
		if (pageSize<=0) {
			pageSize = pageVO.getPageSize();
		}
		Map conditionsMap = new HashMap();
		conditionsMap.put("curPage", curPage);
		conditionsMap.put("pageSize", pageSize);
		conditionsMap.put("startSignDate", startSignDate);
		conditionsMap.put("endSignDate", endSignDate);
		Long userId=(Long) session.getAttribute("userId");
		PageVO pv = this.babyAttendanceService.listBabyAttendanceByTerm(startSignDate,endSignDate,userId,curPage,pageSize);
		map.put("pv", pv);
		map.put("conditionsMap", conditionsMap);
		return "listBabyAttendance";
	}
}

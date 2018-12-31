package org.sdibt.group.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.TeacherLeave;
import org.sdibt.group.service.ITeacherLeaveService;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * Title:TeacherLeaveController
 * @author hanfangfang
 * date:2018年10月23日 上午9:52:59
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class TeacherLeaveController {
	@Resource
	private ITeacherLeaveService teacherLeaveService;

	public ITeacherLeaveService getTeacherLeaveService() {
		return teacherLeaveService;
	}
	public void setTeacherLeaveService(ITeacherLeaveService teacherLeaveService) {
		this.teacherLeaveService = teacherLeaveService;
	}
	/**
	 * 教师查看请假列表
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping("/listLeaveInfoById")
	public String listLeaveInfoById(HttpSession session,Map map,String startDate,String endDate){
		int userId=(int) session.getAttribute("userId");
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.teacherLeaveService.listLeaveInfoById(curPage,pageSize,userId,startDate,endDate);
		map.put("pv", pv);
		return "listTeacherLeave";
	}
	/**
	 * 教师请假列表
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping("/listLeaveInfoByTerm")
	public String listLeaveInfoByTerm(HttpSession session,Map map,int curPage, int pageSize,String startDate,String endDate){
		//若curPage小于或等于0，则设置为1
		if (curPage<=0) {
			curPage = 1;
		}
		//若pageSize小于或等于0，则设置为10
		if (curPage<=0) {
			curPage = 10;
		}
		Map conditionsMap = new HashMap();
		conditionsMap.put("curPage", curPage);
		conditionsMap.put("pageSize", pageSize);
		conditionsMap.put("startDate", startDate);
		conditionsMap.put("endDate", endDate);
		int userId=(int) session.getAttribute("userId");
		PageVO pv = this.teacherLeaveService.listLeaveInfoById(curPage,pageSize,userId,startDate,endDate);
		map.put("pv", pv);
		map.put("conditionsMap", conditionsMap);		
		return "listTeacherLeave";
	}
	/**
	 * 提交请假申请
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/saveLeaveInfo")
	public String saveLeaveInfo(HttpSession session,Map map,TeacherLeave teacherLeave){
		int userId=(int) session.getAttribute("userId");
		teacherLeave.setUserId(userId);
		boolean saveReasult = this.teacherLeaveService.saveLeaveInfo(teacherLeave);
		if(saveReasult==false){
			return "false";
		}else{
			return "true";
		}
	}
	/**
	 * 教师请假申请查看
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/isExistLeaveApplication")
	public String isExistLeaveApplication(HttpSession session,Map map){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<TeacherLeave> listLeaveApplication = this.teacherLeaveService.listLeaveApplication(kindergartenId);
		if(listLeaveApplication.size()==0){
			return "false";
		}else{
			return "true";
		}
	}
	/**
	 * 教师请假申请列表
	 * @param session
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/listLeaveApplication")
	public List<TeacherLeave> listLeaveApplication(HttpSession session){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<TeacherLeave> listLeaveApplication = this.teacherLeaveService.listLeaveApplication(kindergartenId);
		return listLeaveApplication;
	}
	/**
	 * 教师请假审核
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/auditLeaveApplication")
	public String auditLeaveApplication(int leaveId,String audit){
		boolean auditResult = this.teacherLeaveService.auditLeaveApplication(leaveId,audit);
		System.out.println(leaveId+"---"+audit);
		if(auditResult==false){
			return "false";
		}else{
			return "true";
		}
	}
}

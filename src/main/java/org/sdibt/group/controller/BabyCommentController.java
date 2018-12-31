package org.sdibt.group.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.BabyAttendance;
import org.sdibt.group.entity.BabyGrow;
import org.sdibt.group.service.IBabyCommentService;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sun.org.apache.bcel.internal.generic.DADD;

/**
 * 
 * Title:BabyCommentController
 * @author hanfangfang
 * date:2018年9月3日 下午3:59:42
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class BabyCommentController {
	@Resource
	private IBabyCommentService babyCommentService;

	public IBabyCommentService getbabyCommentService() {
		return babyCommentService;
	}
	public void setbabyCommentService(IBabyCommentService babyCommentService) {
		this.babyCommentService = babyCommentService;
	}
	/**
	 * 查看宝宝点评
	 */
	/*@RequestMapping("/listBabyComment")
	public String listBabyGrow(HttpSession session,Map map){
		int userId=(int) session.getAttribute("userId");
		List<Map> comments = this.babyCommentService.listBabyComment(userId);
		map.put("comments", comments);
		return "comment_info";
	}*/
	@RequestMapping("/listBabyComment")
	public String listBabyAttendance(HttpSession session,Map map,String startDate,String endDate){
		int userId=(int) session.getAttribute("userId");
		PageVO pageVO = new PageVO();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.babyCommentService.listBabyCommentByTerm(startDate,endDate,userId,curPage,5);
		//将movieHalls放入request作用域
		map.put("pv", pv);
		return "listBabyComment";
	}
	/**
	 * 条件查询宝宝点评
	 */
	@RequestMapping("/listBabyCommentByTerm")
	public String listBabyCommentByTerm(HttpSession session,Map map,String startDate,String endDate,int curPage, int pageSize){
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
		conditionsMap.put("startDate", startDate);
		conditionsMap.put("endDate", endDate);
		int userId=(int) session.getAttribute("userId");
		PageVO pv = this.babyCommentService.listBabyCommentByTerm(startDate,endDate,userId,curPage,pageSize);
		map.put("pv", pv);
		map.put("conditionsMap", conditionsMap);
		return "listBabyComment";
	}
}

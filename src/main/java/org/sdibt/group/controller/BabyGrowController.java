package org.sdibt.group.controller;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.sdibt.group.entity.BabyGrow;
import org.sdibt.group.service.IBabyGrowService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:BabyGrowController
 * @author hanfangfang
 * date:2018年9月2日 下午5:59:52
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class BabyGrowController {
	@Resource
	private IBabyGrowService babygrowService;

	public IBabyGrowService getbabygrowService() {
		return babygrowService;
	}
	public void setbabygrowService(IBabyGrowService babygrowService) {
		this.babygrowService = babygrowService;
	}
	/**
	 * 查看宝宝成长记录
	 */
	@RequestMapping("/listBabyGrow")
	public String listBabyGrow(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		List<Map> grows = this.babygrowService.listBabyGrow(userId);
		if(grows.size()==0){
			//根据当前登录用户id查询宝宝信息
			Map babyInfo = this.babygrowService.getBabyInfo(userId);
			map.put("babyInfo", babyInfo);
		}else{
			map.put("grows", grows);
		}
		return "listBabyGrow";
	}
	
	/**
	 * 发布宝宝成长记录
	 */
	@ResponseBody
	@RequestMapping(value="/saveBabyGrow", method=RequestMethod.POST)
	public String saveBabyGrow(HttpSession session,BabyGrow babyGrow,@RequestParam(value = "files", required = false) MultipartFile[] files){
		Long userId=(Long) session.getAttribute("userId");
		boolean saveResult = this.babygrowService.saveBabyGrow(files,babyGrow,userId);
		if(saveResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	/**
	 * 删除宝宝成长记录
	 */
	@RequestMapping("/deleteBabyGrow")
	public String deleteBabyGrow(int growId){
		this.babygrowService.deleteBabyGrow(growId);
		return "redirect:/listBabyGrow";
	}
}

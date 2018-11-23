package org.sdibt.group.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.converter.StringToDateConverter;
import org.sdibt.group.entity.BabyDiet;
import org.sdibt.group.service.IBabyDietService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:BabyController
 * @author hanfangfang
 * date:2018年8月29日 下午5:02:01
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class BabyDietController {
	@Resource
	private IBabyDietService babyDietService;

	public IBabyDietService getbabyDietService() {
		return babyDietService;
	}
	public void setbabyDietService(IBabyDietService babyDietService) {
		this.babyDietService = babyDietService;
	}
	/**
	 * 查看今日食谱
	 */
	@RequestMapping("/getBabyDietByDate")
	public String getBabyDietByDate(HttpSession session,Map map){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<Map> diets = this.babyDietService.getBabyDietByDate(kindergartenId);
		if(diets.size()==0){
			map.put("diet",null);
		}else{
			map.put("diet", diets.get(0));
		}
		return "listBabyDiet";
	}
	/**
	 * 条件查询宝宝食谱
	 */
	@RequestMapping("/listBabyDietByTerm")
	public String listBabyDietByTerm(HttpSession session,Map map,String dietDate){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<Map> diets = this.babyDietService.listBabyDietByTerm(dietDate,kindergartenId);
		if(diets.size()==0){
			map.put("diet",null);
		}else{
			map.put("diet", diets.get(0));
		}
		return "listBabyDiet";
	}
	/**
	 * 判断选中的食谱是否在当前日期之前
	 */
	@ResponseBody
	@RequestMapping("/isBeforeCurrentDate")
	public String isBeforeCurrentDate(String dietDate){
		//获取当前时间的时间戳
		int currentTime=(int) (System.currentTimeMillis()/1000);
		//将选择的食谱日期转换为时间戳
		StringToDateConverter stringToDateConverter = new StringToDateConverter();
		//若所选日期时间戳大于当前日期，则返回false表示可以修改，否则返回true
		if(dietDate.length() != 0){
			Date dDate = stringToDateConverter.convert(dietDate);
			int dietTime=(int)(dDate.getTime()/1000);
			if(dietTime-currentTime>0){
				return "false";
			}else{
				return "true";
			}
		}else{
			return "null";
		}
	}
	/**
	 * 编辑宝宝食谱
	 */
	@RequestMapping("/toupdateBabyDiet")
	public String getBabyDietByDietDate(Map map,HttpSession session,String dietDate){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<Map> diets = this.babyDietService.listBabyDietByTerm(dietDate,kindergartenId);
		map.put("diet", diets.get(0));
		return "updateBabyDiet";
	}
	/**
	 * 修改宝宝食谱
	 */
	@ResponseBody
	@RequestMapping("/updateBabyDietById")
	public String updateBabyDietById(BabyDiet babyDiet,
			@RequestParam(value = "breakfastPicture", required = false) MultipartFile breakfastPicture,
			@RequestParam(value = "lunchPicture", required = false) MultipartFile lunchPicture,
			@RequestParam(value = "dinnerPicture", required = false) MultipartFile dinnerPicture
	){
		boolean updateResult = this.babyDietService.updateBabyDietById(babyDiet,breakfastPicture,lunchPicture,dinnerPicture);
		if(updateResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	/**
	 * 判断当前日期的食谱是否已存在
	 */
	@ResponseBody
	@RequestMapping("/isExistBabyDietOfThisDate")
	public boolean isExistBabyDietOfThisDate(HttpSession session,String dietDate){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<Map> diets = this.babyDietService.listBabyDietByTerm(dietDate,kindergartenId);
		if(diets.size()==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 发布宝宝食谱
	 */
	/*@RequestMapping("/saveBabyDiet")
	public String saveBabyDiet(BabyDiet babyDiet){
		boolean saveResult = this.babyDietService.saveBabyDiet(babyDiet);
		String dietDate = babyDiet.getDietDate();
		return "redirect:/listBabyDietByTerm?dietDate="+dietDate;
	}*/
	@ResponseBody
	@RequestMapping("/saveBabyDiet")
	public String saveBabyDiet(HttpSession session,BabyDiet babyDiet,
		@RequestParam(value = "breakfastPicture", required = false) MultipartFile breakfastPicture,
		@RequestParam(value = "lunchPicture", required = false) MultipartFile lunchPicture,
		@RequestParam(value = "dinnerPicture", required = false) MultipartFile dinnerPicture
	){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		babyDiet.setKindergartenId(kindergartenId);
		boolean saveResult = this.babyDietService.saveBabyDiet(babyDiet,breakfastPicture,lunchPicture,dinnerPicture);
		if(saveResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	
}

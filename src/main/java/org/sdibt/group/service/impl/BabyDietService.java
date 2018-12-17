package org.sdibt.group.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.BabyDietDao;
import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyAttendance;
import org.sdibt.group.entity.BabyDiet;
import org.sdibt.group.service.IBabyDietService;
import org.sdibt.group.utils.ImageFileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sun.org.apache.bcel.internal.generic.ARRAYLENGTH;
/**
 * 
 * Title:BabyServiceImpl
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:53
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class BabyDietService implements IBabyDietService {
	@Resource
	private BabyDietDao babyDietDao;

	public BabyDietDao getBabyDietDao() {
		return babyDietDao;
	}
	public void setBabyDietDao(BabyDietDao babyDietDao) {
		this.babyDietDao = babyDietDao;
	}
	/**
	 * 查看今日食谱
	 */
	@Override
	public List<Map> getBabyDietByDate(int kindergartenId) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//将Date类型转换成String类型   
	    String currentDate = sdf.format(date);  
	    Map dietMap = new HashMap<>();
	    dietMap.put("kindergartenId", kindergartenId);
	    dietMap.put("currentDate", currentDate);
	    List<Map> babyDietByDate = this.babyDietDao.getBabyDietByDate(dietMap);
	    for (Map babyDiet : babyDietByDate) {
	    	String breakfastImg = (String) babyDiet.get("breakfast_img");
	    	String lunchImg = (String) babyDiet.get("lunch_img");
	    	String dinnerImg = (String) babyDiet.get("dinner_img");
	    	if(breakfastImg.length()!=0){
	    		breakfastImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+breakfastImg;
	    		babyDiet.put("breakfast_img",breakfastImg);
	    	}else{
	    		babyDiet.put("breakfast_img","");
	    	}
	    	if(lunchImg.length()!=0){
	    		lunchImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+lunchImg;
	    		babyDiet.put("lunch_img",lunchImg);;
	    	}else{
	    		babyDiet.put("lunch_img","");
	    	}
	    	if(dinnerImg.length()!=0){
	    		dinnerImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+dinnerImg;
	    		babyDiet.put("dinner_img",dinnerImg);;
	    	}else{
	    		babyDiet.put("dinner_img","");
	    	}
		}
		return babyDietByDate;
	}
	/**
	 * 条件查询宝宝食谱
	 */
	@Override
	public List<Map> listBabyDietByTerm(String dietDate,int kindergartenId) {
		Map dietMap = new HashMap<>();
	    dietMap.put("kindergartenId", kindergartenId);
	    dietMap.put("dietDate", dietDate);
		List<Map> babyDietByTerm = this.babyDietDao.listBabyDietByTerm(dietMap);
		 for (Map babyDiet : babyDietByTerm) {
		    	String breakfastImg = (String) babyDiet.get("breakfast_img");
		    	String lunchImg = (String) babyDiet.get("lunch_img");
		    	String dinnerImg = (String) babyDiet.get("dinner_img");
		    	if(breakfastImg.length()!=0){
		    		breakfastImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+breakfastImg;
		    		babyDiet.put("breakfast_img",breakfastImg);
		    	}else{
		    		babyDiet.put("breakfast_img","");
		    	}
		    	if(lunchImg.length()!=0){
		    		lunchImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+lunchImg;
		    		babyDiet.put("lunch_img",lunchImg);;
		    	}else{
		    		babyDiet.put("lunch_img","");
		    	}
		    	if(dinnerImg.length()!=0){
		    		dinnerImg="http://192.168.43.242:8081/babyassistantfile/images/dietImgs/"+dinnerImg;
		    		babyDiet.put("dinner_img",dinnerImg);;
		    	}else{
		    		babyDiet.put("dinner_img","");
		    	}
			}
		return babyDietByTerm;
	}
	/**
	 * 修改宝宝食谱
	 */
	@Transactional
	@Override
	public boolean updateBabyDietById(BabyDiet babyDiet,MultipartFile breakfastPicture,MultipartFile lunchPicture,MultipartFile dinnerPicture) {
		String breakfastPath="";
		String lunchPath="";
		String dinnerPath="";
		//拿到图片的路径,并作出修改
		if(breakfastPicture.getOriginalFilename()!=""){
			//获取文件名
			String fileName=breakfastPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			breakfastPath = new Date().getTime() + fileName;
			//创建新的文件名
			File breakfastImg = new File(path + breakfastPath);
			//转存文件到指定路径
			try {
				breakfastPicture.transferTo(breakfastImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(lunchPicture.getOriginalFilename()!=""){
			String fileName=lunchPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			lunchPath = new Date().getTime() + fileName;
			//创建新的文件名
			File lunchImg = new File(path + lunchPath);
			//转存文件到指定路径
			try {
				lunchPicture.transferTo(lunchImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(dinnerPicture.getOriginalFilename()!=""){
			String fileName=dinnerPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			dinnerPath = new Date().getTime() + fileName;
			//创建新的文件名
			File dinnerImg = new File(path + dinnerPath);
			//转存文件到指定路径
			try {
				dinnerPicture.transferTo(dinnerImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Map map = new HashMap<>();
		map.put("dietId", babyDiet.getDietId());
		map.put("dietDate", babyDiet.getDietDate());
		map.put("breakfast", babyDiet.getBreakfast());
		map.put("breakfastImg", breakfastPath);
		map.put("lunch", babyDiet.getLunch());
		map.put("lunchImg", lunchPath);
		map.put("dinner", babyDiet.getDinner());
		map.put("dinnerImg", dinnerPath);
		int count = this.babyDietDao.updateBabyDietById(map);
		System.out.println(count);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 发布宝宝食谱
	 */
	@Transactional
	@Override
	public boolean saveBabyDiet(BabyDiet babyDiet,MultipartFile breakfastPicture,MultipartFile lunchPicture,MultipartFile dinnerPicture) {
		String breakfastPath="";
		String lunchPath="";
		String dinnerPath="";
		//拿到图片的路径,并作出修改
		if(breakfastPicture.getOriginalFilename()!=""){
			//获取文件名
			String fileName=breakfastPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			breakfastPath = new Date().getTime() + fileName;
			//创建新的文件名
			File breakfastImg = new File(path + breakfastPath);
			//转存文件到指定路径
			try {
				breakfastPicture.transferTo(breakfastImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(lunchPicture.getOriginalFilename()!=""){
			String fileName=lunchPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			lunchPath = new Date().getTime() + fileName;
			//创建新的文件名
			File lunchImg = new File(path + lunchPath);
			//转存文件到指定路径
			try {
				lunchPicture.transferTo(lunchImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(dinnerPicture.getOriginalFilename()!=""){
			String fileName=dinnerPicture.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/dietImgs/");
			//用上传时的时间.后缀名作为文件名，防止重名
			dinnerPath = new Date().getTime() + fileName;
			//创建新的文件名
			File dinnerImg = new File(path + dinnerPath);
			//转存文件到指定路径
			try {
				dinnerPicture.transferTo(dinnerImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Map map = new HashMap<>();
		map.put("kindergartenId", babyDiet.getKindergartenId());
		map.put("dietDate", babyDiet.getDietDate());
		map.put("breakfast", babyDiet.getBreakfast());
		map.put("breakfastImg", breakfastPath);
		map.put("lunch", babyDiet.getLunch());
		map.put("lunchImg", lunchPath);
		map.put("dinner", babyDiet.getDinner());
		map.put("dinnerImg", dinnerPath);
		int count = this.babyDietDao.saveBabyDiet(map);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/*@Override
	public boolean saveBabyDiet(BabyDiet babyDiet,MultipartFile breakfastPicture,MultipartFile lunchPicture,MultipartFile dinnerPicture) {
		//拿到图片的路径,并作出修改
		String breakfastImg = babyDiet.getBreakfastImg();
		String breakfastPath="images/"+breakfastImg.substring(breakfastImg.lastIndexOf("\\")+1);
		String lunchImg = babyDiet.getLunchImg();
		String lunchPath="images/"+lunchImg.substring(lunchImg.lastIndexOf("\\")+1);
		String dinnerImg = babyDiet.getDinnerImg();
		String dinnerPath="images/"+dinnerImg.substring(dinnerImg.lastIndexOf("\\")+1);
		Map map = new HashMap<>();
		map.put("dietDate", babyDiet.getDietDate());
		map.put("breakfast", babyDiet.getBreakfast());
		map.put("breakfastImg", breakfastPath);
		map.put("lunch", babyDiet.getLunch());
		map.put("lunchImg", lunchPath);
		map.put("dinner", babyDiet.getDinner());
		map.put("dinnerImg", dinnerPath);
		int count = this.babyDietDao.saveBabyDiet(map);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}*/
}

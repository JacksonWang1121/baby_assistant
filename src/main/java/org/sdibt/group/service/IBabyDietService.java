package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.BabyDiet;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:BabyService
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:57
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IBabyDietService {
	/**
	 * 查看今日食谱
	 * @return
	 */
	public List<Map> getBabyDietByDate(int kindergartenId);
	/**
	 * 条件查询宝宝食谱
	 * @param dietDate
	 * @return
	 */
	public List<Map> listBabyDietByTerm(String dietDate,int kindergartenId);
	/**
	 * 修改宝宝食谱
	 * @param babyDiet
	 * @return
	 */
	public boolean updateBabyDietById(BabyDiet babyDiet,MultipartFile breakfastPicture,MultipartFile lunchPicture,MultipartFile dinnerPicture);
	/**
	 * 发布宝宝食谱
	 * @param babyDiet
	 * @return
	 */
	public boolean saveBabyDiet(BabyDiet babyDiet,MultipartFile breakfastPicture,MultipartFile lunchPicture,MultipartFile dinnerPicture);
}

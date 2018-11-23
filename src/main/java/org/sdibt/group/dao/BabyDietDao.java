package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyDiet;

/**
 * 
 * Title:BabyDao
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:47
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface BabyDietDao {
	/**
	 * 查看今日食谱
	 * @return
	 */
	public List<Map> getBabyDietByDate(Map dietMap);
	/**
	 * 条件查询宝宝食谱
	 * @param dietDate
	 * @return
	 */
	public List<Map> listBabyDietByTerm(Map dietMap);
	/**
	 * 修改宝宝食谱
	 * @param babyDiet
	 * @return
	 */
	public int updateBabyDietById(Map map);
	/**
	 * 发布宝宝食谱
	 * @param babyDiet
	 * @return
	 */
	public int saveBabyDiet(Map map);
}

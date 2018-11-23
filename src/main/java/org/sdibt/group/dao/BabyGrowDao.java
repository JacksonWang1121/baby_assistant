package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyDiet;
import org.sdibt.group.entity.BabyGrow;

/**
 * 
 * Title:BabyGrowDao
 * @author hanfangfang
 * date:2018年9月2日 下午6:00:08
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface BabyGrowDao {
	/**
	 * 根据当前登录的用户ID查询宝宝信息
	 * @param userId
	 * @return
	 */
	public Map getBabyInfo(Long userId);
	/**
	 * 查看宝宝成长记录
	 * @return
	 */
	public List<Map> listBabyGrow(Long userId);
	/**
	 * 根据家长id查询对应的孩子id
	 * @param userId
	 * @return
	 */
	public int findBabyIdByUserId(Long userId);
	/**
	 * 发布宝宝食谱
	 * @param babyDiet
	 * @return
	 */
	public int saveBabyGrow(Map map);
	/**
	 * 根据id获取图片路径
	 * @param growId
	 * @return
	 */
	public Map getImgPath(int growId);
	/**
	 * 删除宝宝成长记录
	 * @param growId
	 * @return
	 */
	public void deleteBabyGrow(int growId);
}

package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyDiet;
import org.sdibt.group.entity.BabyGrow;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:IBabyGrowService
 * @author hanfangfang
 * date:2018年9月2日 下午6:00:03
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IBabyGrowService {
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
	 * 发布宝宝成长记录
	 * @param babyDiet
	 * @return
	 */
	public boolean saveBabyGrow(MultipartFile[] files,BabyGrow babyGrow,Long userId);
	/**
	 * 删除宝宝成长记录
	 * @param growId
	 * @return
	 */
	public void deleteBabyGrow(int growId);
}

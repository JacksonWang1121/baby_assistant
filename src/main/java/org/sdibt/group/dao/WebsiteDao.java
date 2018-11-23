package org.sdibt.group.dao;

import org.sdibt.group.entity.Website;

/**
 * 微官网数据操作接口层
 * @title WebsiteDao.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:22:07
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface WebsiteDao {
	
	/**
	 * 查询微官网
	 * @param schoolId
	 * @return
	 */
	public Website findWebsite(int schoolId);

}

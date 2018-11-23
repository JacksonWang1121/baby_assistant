package org.sdibt.group.dao;

import org.sdibt.group.entity.Kindergarten;

/**
 * 幼儿园数据操作接口层
 * @title WebsiteDao.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:22:07
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface KindergartenDao {
	
	/**
	 * 根据园长id查询幼儿园记录
	 * @param principalId
	 * @return
	 */
	public Kindergarten findKindergarten(int principalId);

	/**
	 * 根据幼儿园id查询幼儿园记录
	 * @param kindergartenId
	 * @return
	 */
	public Kindergarten findKindergartenById(int kindergartenId);

}

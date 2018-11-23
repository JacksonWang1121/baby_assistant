package org.sdibt.group.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.KindergartenDao;
import org.sdibt.group.dao.WebsiteDao;
import org.sdibt.group.entity.Kindergarten;
import org.sdibt.group.entity.Website;
import org.sdibt.group.service.IWebsiteService;
import org.springframework.stereotype.Service;

/**
 * 微官网业务逻辑层
 * @title WebsiteService.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:20:29
 * @package sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class WebsiteService implements IWebsiteService {
	
	@Resource
	private WebsiteDao websiteDao;
	@Resource
	private KindergartenDao kindergartenDao;

	public void setWebsiteDao(WebsiteDao websiteDao) {
		this.websiteDao = websiteDao;
	}

	public void setKindergartenDao(KindergartenDao kindergartenDao) {
		this.kindergartenDao = kindergartenDao;
	}

	/**
	 * 查询微官网
	 */
	@Override
	public Map findWebsite(int schoolId) {
		Website website = this.websiteDao.findWebsite(schoolId);
		Kindergarten kindergarten = this.kindergartenDao.findKindergartenById(schoolId);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("website", website);
		map.put("kindergarten", kindergarten);
		return map;
	}

}

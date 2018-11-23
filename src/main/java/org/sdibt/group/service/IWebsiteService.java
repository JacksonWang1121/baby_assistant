package org.sdibt.group.service;

import java.util.Map;

/**
 * 微官网业务逻辑接口层
 * @author JacksonWang
 *
 */
public interface IWebsiteService {

	/**
	 * 查询微官网
	 * @param schoolId
	 * @return
	 */
	public Map findWebsite(int schoolId);

}

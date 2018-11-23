package org.sdibt.group.service;

import org.sdibt.group.entity.Kindergarten;

/**
 * 幼儿园业务逻辑接口层
 * @title IKindergartenService.java
 * @author JacksonWang
 * @date 2018年9月27日 下午2:39:40
 * @package org.sdibt.group.service
 * @version 1.0
 *
 */
public interface IKindergartenService {

	/**
	 * 根据园长id查询幼儿园记录
	 * @param schoolId
	 * @return
	 */
	public Kindergarten findKindergarten(int principalId);

}

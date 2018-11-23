package org.sdibt.group.service.impl;

import javax.annotation.Resource;

import org.sdibt.group.dao.KindergartenDao;
import org.sdibt.group.entity.Kindergarten;
import org.sdibt.group.service.IKindergartenService;
import org.springframework.stereotype.Service;

/**
 * 幼儿园业务逻辑层
 * @title KindergartenService.java
 * @author JacksonWang
 * @date 2018年9月27日 下午2:38:15
 * @package org.sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class KindergartenService implements IKindergartenService {

	@Resource
	private KindergartenDao kindergartenDao;

	public void setKindergartenDao(KindergartenDao kindergartenDao) {
		this.kindergartenDao = kindergartenDao;
	}

	/**
	 * 根据园长id查询幼儿园记录
	 * @param schoolId
	 * @return
	 */
	@Override
	public Kindergarten findKindergarten(int principalId) {
		return this.kindergartenDao.findKindergarten(principalId);
	}

}

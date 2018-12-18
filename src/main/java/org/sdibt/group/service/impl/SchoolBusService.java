package org.sdibt.group.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.sdibt.group.dao.SchoolBusDao;
import org.sdibt.group.entity.SchoolBus;
import org.sdibt.group.service.ISchoolBusService;
import org.springframework.stereotype.Service;

@Service
public class SchoolBusService implements ISchoolBusService {

	@Resource
	private SchoolBusDao schoolBusDao;

	public void setSchoolBusDao(SchoolBusDao schoolBusDao) {
		this.schoolBusDao = schoolBusDao;
	}

	/**
	 * 根据幼儿园编号查询所有校车的记录
	 * @param schoolId
	 * @return
	 */
	@Override
	public List<SchoolBus> listSchoolBus(int schoolId) {
		return this.schoolBusDao.listSchoolBus(schoolId);
	}

}

package org.sdibt.group.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.SchoolBus;
import org.sdibt.group.service.ISchoolBusService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 校车业务逻辑层
 * @title WebsiteController.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:31:58
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/schoolBus")
public class SchoolBusController {
	
	@Resource
	private ISchoolBusService schoolBusService;

	public void setSchoolBusService(ISchoolBusService schoolBusService) {
		this.schoolBusService = schoolBusService;
	}

	/**
	 * 查询校车记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/listSchoolBus")
	@ResponseBody
	public List<SchoolBus> listSchoolBus(HttpSession session) {
		//获取幼儿园编号
		int schoolId = (int) session.getAttribute("kindergartenId");
		//查询校车记录
		List<SchoolBus> buses = this.schoolBusService.listSchoolBus(schoolId);
		if (buses != null) {
			//得到一个新的校车集合
			buses = this.schoolBusService.schoolBusPosition(buses);
		}
		return buses;
	}

}

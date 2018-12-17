package org.sdibt.group.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.entity.Website;
import org.sdibt.group.service.IWebsiteService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 微官网控制层
 * @title WebsiteController.java
 * @author JacksonWang
 * @date 2018年9月27日 下午2:47:37
 * @package org.sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/website")
public class WebsiteController {
	
	@Resource
	private IWebsiteService websiteService;
	
	public IWebsiteService getWebsiteService() {
		return websiteService;
	}

	public void setWebsiteService(IWebsiteService websiteService) {
		this.websiteService = websiteService;
	}

	/**
	 * 查询微官网
	 */
	@RequestMapping("/findWebsite")
	@ResponseBody
	public Map findWebsite(String schoolId) {
		System.out.println("WebsiteController::findWebsite-schoolId = "+schoolId);
		Map map = this.websiteService.findWebsite(Integer.parseInt(schoolId));
		return map;
	}

}

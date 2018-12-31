package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.vo.PageVO;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 * Title:IBabyCommentService
 * @author hanfangfang
 * date:2018年9月3日 下午4:00:59
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IBabyCommentService {
	/**
	 * 查看宝宝点评
	 * @return
	 */
	//public List<Map> listBabyComment(int userId);
	/**
	 * 条件查询宝宝点评
	 */
	public PageVO listBabyCommentByTerm(String startDate,String endDate,int userId,int curPage, int pageSize);
}

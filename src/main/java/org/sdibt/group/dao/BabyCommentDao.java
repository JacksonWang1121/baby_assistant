package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

/**
 * 
 * Title:BabyCommentDao
 * @author hanfangfang
 * date:2018年9月3日 下午4:00:09
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface BabyCommentDao {
	/**
	 * 查看宝宝点评共多少条
	 * @return
	 */
	//public List<Map> listBabyComment(Long userId);
	public int countBabyComment(Map termMap);
	/**
	 * 条件查询宝宝点评
	 */
	public List<Map> listBabyCommentByTerm(Map map);
}

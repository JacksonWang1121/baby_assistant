package org.sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.BabyCommentDao;
import org.sdibt.group.service.IBabyCommentService;
import org.sdibt.group.utils.FileUtil;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Service;
/**
 * 
 * Title:BabyCommentService
 * @author hanfangfang
 * date:2018年9月3日 下午4:02:39
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class BabyCommentService implements IBabyCommentService {
	@Resource
	private BabyCommentDao babyCommentDao;
	private String filePath=FileUtil.httpFilePath+"images/";
	public BabyCommentDao getBabyCommentDao() {
		return babyCommentDao;
	}
	public void setBabyCommentDao(BabyCommentDao babyCommentDao) {
		this.babyCommentDao = babyCommentDao;
	}
	/**
	 * 查看宝宝点评
	 */
	/*@Override
	public List<Map> listBabyComment(int userId) {
		// TODO Auto-generated method stub
		List<Map> babyComments = this.babyCommentDao.listBabyComment(userId);
		
		return babyComments;
	}*/
	/**
	 * 条件查询宝宝点评
	 */
	@Override
	public PageVO listBabyCommentByTerm(String startDate, String endDate,
			int userId,int curPage, int pageSize) {
		if(endDate==""){
			//得到当前日期
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//将Date类型转换成String类型   
			String currentDate = sdf.format(date);
			endDate=currentDate;
		}
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取宝宝所有考勤信息的数量
		Map<Object,Object> termMap = new HashMap<>();
		termMap.put("userId", userId);
		termMap.put("startDate", startDate);
		termMap.put("endDate", endDate);
		int count = this.babyCommentDao.countBabyComment(termMap);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<Map> babyComments = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			babyComments = this.babyCommentDao.listBabyCommentByTerm(map);
			for (Map babyComment : babyComments) {
				String userIcon = (String) babyComment.get("user_icon");
				if(userIcon.length()!=0){
					userIcon=filePath+"userIcons/"+userIcon;
					babyComment.put("user_icon",userIcon);
		    	}else{
		    		babyComment.put("user_icon","");
		    	}
			}
		}
		//将数据存储到pv中
		pv.setDatas(babyComments);
		return pv;
	}
}

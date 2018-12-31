package org.sdibt.group.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.sdibt.group.dao.BabyDao;
import org.sdibt.group.entity.Baby;
import org.sdibt.group.service.IBabyService;
import org.sdibt.group.utils.ImageFileUtils;
import org.sdibt.group.utils.FileUtil;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * Title:BabyService
 * @author hanfangfang
 * date:2018年9月2日 下午5:59:57
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class BabyService implements IBabyService {
	@Resource
	private BabyDao babyDao;
	private String filePath=FileUtil.httpFilePath+"images/";
	public BabyDao getBabyDao() {
		return babyDao;
	}
	public void setBabyDao(BabyDao babyDao) {
		this.babyDao = babyDao;
	}
	
	/**
	 * 宝宝分班：根据教师所在年级查询待分班的宝宝信息
	 */
	@Override
	public PageVO listBabyEnrollInfo(int curPage,int pageSize,int userId,int kindergartenId) {
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取未分班宝宝信息的数量
		Map<Object,Object> termMap = new HashMap<>();
		termMap.put("userId", userId);
		termMap.put("kindergartenId", kindergartenId);
		int count = this.babyDao.countBabyEnrollInfo(termMap);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<Map> babyEnroll = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			map.put("kindergartenId", kindergartenId);
			babyEnroll = this.babyDao.listBabyEnrollInfo(map);
		}
		//将数据存储到pv中
		pv.setDatas(babyEnroll);
		return pv;
	}
	/**
	 * 加入班级
	 */
	@Transactional
	@Override
	public void updateClassInfoToBaby(int babyId, int classId) {
		Map map = new HashMap<>();
		map.put("babyId", babyId);
		map.put("classId", classId);
		map.put("applyStatus", 1);
		this.babyDao.updateClassInfoToBaby(map);
	}
	/**
	 * 宝宝分班：根据教师所在年级查询已分班的宝宝信息
	 */
	@Override
	public PageVO listBabiesInClass(int curPage,int pageSize,int userId) {
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取已分班信息的数量
		int count = this.babyDao.countBabiesInClass(userId);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<Map> babiesInClass = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("userId", userId);
			babiesInClass = this.babyDao.listBabiesInClass(map);
		}
		if(babiesInClass!=null){
			for (Map baby : babiesInClass) {
				int status = (int) baby.get("pay_status");
				if(status==0){
					baby.put("pay_status", "待付款");
				}else{
					baby.put("pay_status", "已付款");
				}
			}
		}
		//将数据存储到pv中
		pv.setDatas(babiesInClass);
		return pv;
	}
	/**
	 * 移出班级
	 */
	@Transactional
	@Override
	public void updateClassInfoOfBaby(int babyId) {
		Map map = new HashMap<>();
		map.put("babyId", babyId);
		map.put("classId", 0);
		map.put("applyStatus", 0);
		this.babyDao.updateClassInfoOfBaby(map);
	}
	/**
	 * 报名列表：查询全园未分班的宝宝信息
	 */
	@Override
	public PageVO listWaitDivideBabyInfo(int curPage,int pageSize,int kindergartenId) {
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		// 获取全园未分班宝宝信息的数量
		int count = this.babyDao.countWaitDivideBabyInfo(kindergartenId);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<Map> waitDivideBabyInfo = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("kindergartenId", kindergartenId);
			waitDivideBabyInfo = this.babyDao.listWaitDivideBabyInfo(map);
		}
		//将数据存储到pv中
		pv.setDatas(waitDivideBabyInfo);
		return pv;
	}
	/**
	 * 报名列表：查询全园待付款的宝宝信息
	 * @return
	 */
	@Override
	public PageVO listWaitPayBabyInfo(int curPage,int pageSize,int kindergartenId) {
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		// 获取全园未分班宝宝信息的数量
		int count = this.babyDao.countWaitPayBabyInfo(kindergartenId);
		//获取总页数
		int total = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		//查询数据库
		List<Map> waitPayBabyInfo = null;
		Map<Object,Object> map = new HashMap<>();
		//若count为空，则忽略分页查询
		if (count > 0) {
			map.put("startPage", startPage);
			map.put("pageSize", pageSize);
			map.put("kindergartenId", kindergartenId);
			waitPayBabyInfo = this.babyDao.listWaitPayBabyInfo(map);
		}
		//将数据存储到pv中
		pv.setDatas(waitPayBabyInfo);
		return pv;
	}
	/**
	 * 查看宝宝资料
	 * @param userId
	 * @return
	 */
	public Map getBabyDataByParentId(int userId){
		Map babyData = this.babyDao.getBabyDataByParentId(userId);
		int classId = (int) babyData.get("class_id");
		//根据班级id查询班级名称
		String className=this.babyDao.getClassNameByClassId(classId);
		if(className!=null){
			babyData.put("class_name", className);
		}else{
			babyData.put("class_name", "待分班");
		}
		String babyIcon = (String) babyData.get("baby_icon");
		if(babyIcon.length()!=0){
			babyIcon=filePath+"babyIcons/"+babyIcon;
			babyData.put("baby_icon",babyIcon);
    	}else{
    		babyData.put("baby_icon","");
    	}
		return babyData;
	}
	/**
	 * 修改宝宝头像
	 */
	@Transactional
	@Override
	public boolean updateBabyIcon(int babyId,MultipartFile iconPath) {
		String babyIcon="";
		//拿到图片的路径,并作出修改
		if(iconPath.getOriginalFilename()!=""){
			//获取文件名
			String fileName=iconPath.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/babyIcons/");
			//用上传时的时间.后缀名作为文件名，防止重名
			babyIcon = new Date().getTime() + fileName;
			//创建新的文件名
			File babyImg = new File(path + babyIcon);
			//转存文件到指定路径
			try {
				iconPath.transferTo(babyImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Map map = new HashMap<>();
		map.put("babyId", babyId);
		map.put("babyIcon", babyIcon);
		int count = this.babyDao.updateBabyIcon(map);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 修改宝宝信息
	 */
	@Transactional
	@Override
	public boolean updateBabyData(Baby baby) {
		Map map = new HashMap<>();
		map.put("babyId", baby.getBabyId());
		map.put("babyName", baby.getBabyName());
		map.put("sex", baby.getSex());
		map.put("birthday", baby.getBirthday());
		map.put("relationship", baby.getRelationship());
		int count = this.babyDao.updateBabyData(map);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 修改宝宝付款状态
	 */
	@Override
	public void updatePayStatus(int userId) {
		Map map = new HashMap<>();
		map.put("userId", userId);
		map.put("payStatus",1);
		this.babyDao.updatePayStatus(map);
	}
	/**
	 * 检查宝宝是否已缴费
	 */
	@Override
	public boolean hasPayTuition(int userId) {
		int payStatus = this.babyDao.hasPayTuition(userId);
		if(payStatus==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 查询家长信息
	 * @param baby
	 */
	@Override
	public List<Map> listBabyInfoByClassId(int classId) {
		// TODO Auto-generated method stub
		System.out.println(classId);
		if(classId>=0){
		List<Map> parentInfo=this.babyDao.listBabyInfoByClassId(classId);
	
		return parentInfo;
		}else{
		return null;
		}
	}

	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	@Transactional
	@Override
	public void updateBaby(Baby baby) {
		this.babyDao.updateBaby(baby);
	}
	/**
	 * 根据幼儿园id查询该幼儿园所有在校学生的记录
	 * @param kindergartenId
	 * @return
	 */
	@Override
	public Map listByKindergartenId(int kindergartenId) {
		//获取学生记录
		List<Map> stuList = this.babyDao.listByKindergartenId(kindergartenId);
		//用来存储分班后的学生信息
		Map<String, List<Map>> stuMap = new HashMap<>();
		//初始化待分班的班级，并添加到班级集合中
		stuMap.put("待分班", new ArrayList<Map>());
		//遍历所有学生记录
		for (Map stu : stuList) {
			//获取该学生的头像
			String babyIcon = (String) stu.get("baby_icon");
			//若该学生存在头像，则补全学生的头像路径
			if (babyIcon != null) {
				stu.put("baby_icon", filePath+babyIcon);
			}
			//获取该学生的班级id
			int classId = (int) stu.get("class_id");
			//该学生所在的班级名称
			String clsName = "待分班";
			//班级list
			List<Map> cls = null;
			//若该学生未分班，则添加到待分班list中
			if (classId == 0) {
				//得到待分班的班级list
				cls = stuMap.get("待分班");
			} else {
				//得到该学生所在的班级名称
				clsName = (String) stu.get("grade_name") + (String) stu.get("class_name");
				//根据该学生所在的班级名称查找班级集合中是否存在该班级，
				cls = stuMap.get(clsName);
				//若匹配到该班级，则将该学生记录添加到该班级list中
				//否则先创建该班级,并添加到班级集合中，再将该学生记录添加到该班级list中
				if (cls == null) {
					cls = new ArrayList<Map>();
				}
			}
			//System.out.println("学生("+stu.get("baby_name")+")加入班级集合("+clsName+")");
			//将该学生记录添加到待分班list中
			cls.add(stu);
			//将新的班级list添加到班级集合中
			stuMap.put(clsName, cls);
		}
		return stuMap;
	}
}

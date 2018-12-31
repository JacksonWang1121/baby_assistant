package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Baby;
import org.sdibt.group.vo.PageVO;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:BabyService
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:57
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IBabyService {
	/**
	 * 宝宝分班：根据教师所在年级查询待分班的宝宝信息
	 * @param userId
	 * @return
	 */
	public PageVO listBabyEnrollInfo(int curPage,int pageSize,int userId,int kindergartenId);
	/**
	 * 加入班级
	 * @param babyId
	 * @param classId
	 */
	public void updateClassInfoToBaby(int babyId,int classId);
	/**
	 * 宝宝分班：根据教师所在年级查询已分班的宝宝信息
	 * @param userId
	 * @return
	 */
	public PageVO listBabiesInClass(int curPage,int pageSize,int userId);
	/**
	 * 移出班级
	 * @param babyId
	 */
	public void updateClassInfoOfBaby(int babyId);
	/**
	 * 报名列表：查询全园未分班的宝宝信息
	 * @return
	 */
	public PageVO listWaitDivideBabyInfo(int curPage,int pageSize,int kindergartenId);
	/**
	 * 报名列表：查询全园待付款的宝宝信息
	 * @return
	 */
	public PageVO listWaitPayBabyInfo(int curPage,int pageSize,int kindergartenId);
	/**
	 * 查看宝宝资料
	 * @param userId
	 * @return
	 */
	public Map getBabyDataByParentId(int userId);
	/**
	 * 修改宝宝头像
	 * @param babyId
	 * @param iconPath
	 */
	public boolean updateBabyIcon(int babyId,MultipartFile iconPath);
	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	public boolean updateBabyData(Baby baby);

	/**
	 * 检查宝宝是否已缴费
	 * @param userId
	 * @return
	 */
	public boolean hasPayTuition(int userId);
	/**
	 * 修改宝宝付款状态
	 * @param userId
	 */
	public void updatePayStatus(int userId); 
	/**
	 * 查询家长信息
	 * @param baby
	 */
	public List<Map> listBabyInfoByClassId(int classId);
	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	public void updateBaby(Baby baby);
	/**
	 * 根据幼儿园id查询该幼儿园所有在校学生的记录
	 * @param kindergartenId
	 * @return
	 */
	public Map listByKindergartenId(int kindergartenId);
}

package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Baby;


/**
 * 
 * Title:BabyDao
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:47
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface BabyDao {
	/**
	 * 宝宝分班：查询待分班的宝宝信息共多少条
	 * @param termMap
	 * @return
	 */
	public int countBabyEnrollInfo(Map termMap);
	/**
	 * 宝宝分班：查询待分班的宝宝信息
	 * @param userId
	 * @return
	 */
	public List<Map> listBabyEnrollInfo(Map map);
	/**
	 * 加入班级
	 * @param map
	 */
	public void updateClassInfoToBaby(Map map);
	/**
	 * 获取已分班信息的数量
	 * @return
	 */
	public int countBabiesInClass(Long userId);
	/**
	 * 宝宝分班：根据教师所在班级查询已分班的宝宝信息
	 * @param userId
	 * @return
	 */
	public List<Map> listBabiesInClass(Map map);
	/**
	 * 移出班级
	 * @param map
	 */
	public void updateClassInfoOfBaby(Map map);
	/**
	 * 获取全园未分班宝宝信息的数量
	 * @param kindergartenId
	 * @return
	 */
	public int countWaitDivideBabyInfo(int kindergartenId);
	/**
	 * 报名列表：查询全园未分班的宝宝信息
	 * @return
	 */
	public List<Map> listWaitDivideBabyInfo(Map map);
	/**
	 * 获取全园待付款宝宝信息的数量
	 * @param kindergartenId
	 * @return
	 */
	public int countWaitPayBabyInfo(int kindergartenId);
	/**
	 * 报名列表：查询全园待付款的宝宝信息
	 * @return
	 */
	public List<Map> listWaitPayBabyInfo(Map map);
	/**
	 * 根据班级id查询班级名称
	 * @param classId
	 * @return
	 */
	public String getClassNameByClassId(int classId);
	/**
	 * 查看宝宝资料
	 * @return
	 */
	public Map getBabyDataByParentId(Long userId);
	/**
	 * 修改宝宝头像
	 */
	public int updateBabyIcon(Map map);
	/**
	 * 修改宝宝信息
	 */
	public int updateBabyData(Map map);
	/**
	 * 检查宝宝是否已缴费
	 * @param userId
	 * @return
	 */
	public int hasPayTuition(Long userId);
	/**
	 * 修改宝宝付款状态
	 */
	public void updatePayStatus(Map map); 
	/**
	 * 查询家长信息
	 * @param baby
	 */
	public List<Map> listBabyInfoByClassId(int classId);
	/**
	 * 查询该班级所有家长信息
	 * @param baby
	 */
	public List<Integer> listParentIdByClassId(int classId);
}

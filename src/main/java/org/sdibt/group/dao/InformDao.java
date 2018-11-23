package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.sdibt.group.entity.Inform;


public interface InformDao {
	/**
     * 通过班级Id查看班级通知信息
     */
	List<Map> listInformByClassId(Map map);
	/**
     * 根据通知Id查询通知内容
     */
	Inform queryInformByInformId(int informId);
	/**
     * 根据通知Id删除通知内容
     */
	int deleteInformByInformId(int informId);
	/**
     * 保存班级通知
     */
	int saveInform(Inform inform);
	/**
     * 保存通知时间查询通知ID
     */
	int listInformIdByInformDate(String informDate);

}

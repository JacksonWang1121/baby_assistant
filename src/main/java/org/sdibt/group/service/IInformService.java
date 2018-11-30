package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Inform;

public interface IInformService {
	/**
     * 通过班级Id查看班级通知信息
     */
	List<Map> listInformByClassId(int classId, int parentId);
	/**
     * 保存班级通知
     */
	boolean saveInform(Inform inform, int classId);
	/**
     * 根据通知Id查询通知内容
     */
	Inform queryInformByInformId(int informId, int parentId);
	/**
     * 根据通知Id删除通知内容
     */
	boolean deleteInformByInformId(int informId);




}

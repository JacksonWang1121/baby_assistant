package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.sdibt.group.entity.LookState;

public interface LookStateDao {
	/**
	  * 根据通知Id,用户ID查看用户的查看状态
	  */
	String queryLookState(@Param(value="informId")int informId, @Param(value="parentId")int parentId);
	 /**
	  * 根据通知Id,用户ID更新通知状态为1即为已查看
	  */
	  public void updateLookState(@Param(value="informId")int informId, @Param(value="parentId")int parentId);
	  /**
	  * 根据通知Id删除该通知的所有查看状态
	  */
	int deleteLookStateByInformId(int informId);
	 /**
	  * // 保存班级通知查看状态
	  */
	int saveLookState(LookState lookstates);

}

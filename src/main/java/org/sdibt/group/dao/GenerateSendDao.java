package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.GenerateSend;

/**
 * 代接送数据访问层接口
 * @title GenerateSendDao.java
 * @author JacksonWang
 * @date 2018年11月26日 下午2:17:06
 * @package org.sdibt.group.dao
 * @version 1.0
 *
 */
public interface GenerateSendDao {

	/**
	 * 查询代接送信息：教师、园长
	 * @param conditions
	 * @return
	 */
	public List<GenerateSend> listGenerateSendForTeacher(Map conditions);

	/**
	 * 查询代接送信息：家长
	 * @param conditions
	 * @return
	 */
	public List<GenerateSend> listGenerateSendForParent(Map conditions);

	/**
	 * 添加代接送信息
	 * @param generateSend
	 */
	public void saveGenerateSend(GenerateSend generateSend);

	/**
	 * 修改代接送信息
	 * @param generateSend
	 */
	public void updateGenerateSend(GenerateSend generateSend);

}

package org.sdibt.group.service;

import java.util.List;
import org.sdibt.group.entity.GenerateSend;

/**
 * 代接送业务逻辑接口
 * @title IGenerateSendService.java
 * @author JacksonWang
 * @date 2018年11月26日 下午2:33:05
 * @package org.sdibt.group.service
 * @version 1.0
 *
 */
public interface IGenerateSendService {

	/**
	 * 查询代接送信息：教师、园长
	 * @param conditions
	 * @return
	 */
	public List<GenerateSend> listGenerateSendForTeacher(int teacherId, String auditState);

	/**
	 * 查询代接送信息：家长
	 * @param conditions
	 * @return
	 */
	public List<GenerateSend> listGenerateSendForParent(int parentId, String auditState);

	/**
	 * 添加代接送信息
	 * @param generateSend
	 */
	public boolean saveGenerateSend(GenerateSend generateSend);

	/**
	 * 修改代接送信息
	 * @param generateSend
	 */
	public boolean updateGenerateSend(GenerateSend generateSend);

}

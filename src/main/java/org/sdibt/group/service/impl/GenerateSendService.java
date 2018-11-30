package org.sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.GenerateSendDao;
import org.sdibt.group.entity.GenerateSend;
import org.sdibt.group.service.IGenerateSendService;
import org.sdibt.group.utils.FileUtil;
import org.springframework.stereotype.Service;

/**
 * 代接送业务逻辑层
 * @title GenerateSendService.java
 * @author JacksonWang
 * @date 2018年11月26日 下午2:35:01
 * @package org.sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class GenerateSendService implements IGenerateSendService {

	@Resource
	private GenerateSendDao generateSendDao;
	//文件访问http地址
	private String filePath = FileUtil.httpFilePath + "images/generateSend/";

	public void setGenerateSendDao(GenerateSendDao generateSendDao) {
		this.generateSendDao = generateSendDao;
	}

	/**
	 * 查询代接送信息：教师、园长
	 * @param conditions
	 * @return
	 */
	@Override
	public List<GenerateSend> listGenerateSendForTeacher(int teacherId, String auditState) {
		Map conditions = new HashMap();
		conditions.put("teacherId", teacherId);
		conditions.put("auditState", auditState);
		List<GenerateSend> list = this.generateSendDao.listGenerateSendForTeacher(conditions);
		if (list != null) {
			//将图片路径补全
			for (GenerateSend send : list) {
				if (send.getPersonPicture() != null) {
					send.setPersonPicture(filePath+send.getPersonPicture());
				}
			}
		}
		return list;
	}

	/**
	 * 查询代接送信息：家长
	 * @param conditions
	 * @return
	 */
	@Override
	public List<GenerateSend> listGenerateSendForParent(int parentId, String auditState) {
		Map conditions = new HashMap();
		conditions.put("parentId", parentId);
		conditions.put("auditState", auditState);
		List<GenerateSend> list = this.generateSendDao.listGenerateSendForParent(conditions);
		if (list != null) {
			//将图片路径补全
			for (GenerateSend send : list) {
				if (send.getPersonPicture() != null) {
					send.setPersonPicture(filePath+send.getPersonPicture());
				}
			}
		}
		return list;
	}

	/**
	 * 添加代接送信息
	 * @param generateSend
	 */
	@Override
	public void saveGenerateSend(GenerateSend generateSend) {
		//日期格式化
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//获取格式化后的日期
		String date = df.format(new Date());
		//设置发送时间
		generateSend.setGenerateTime(date);
		//设置初始审核状态为0，即待审核
		generateSend.setAuditState(0);
		this.generateSendDao.saveGenerateSend(generateSend);
	}

	/**
	 * 修改代接送信息
	 * @param generateSend
	 */
	@Override
	public void updateGenerateSend(GenerateSend generateSend) {
		this.generateSendDao.updateGenerateSend(generateSend);
	}

}

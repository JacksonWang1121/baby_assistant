package org.sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.HomeworkDao;
import org.sdibt.group.entity.Homework;
import org.sdibt.group.service.IHomeworkService;
import org.springframework.stereotype.Service;

@Service
public class HomeworkService implements IHomeworkService {

	@Resource
	private HomeworkDao homeworkdao;

	public HomeworkDao getHomeworkdao() {
		return homeworkdao;
	}

	public void setHomeworkdao(HomeworkDao homeworkdao) {
		this.homeworkdao = homeworkdao;
	}
	/**
     * 通过班级Id查看班级作业信息
     */
	@Override
	public List<Map> listHomeworkByClassId(int classId) {
		// TODO Auto-generated method stub
		List<Map> homeworks = null;
		if (classId > 0) {
			homeworks = this.homeworkdao.listHomeworkByClassId(classId);
			for (Map homework : homeworks) {
				homework.put("user_icon","http://localhost:8080/babyassistantfile/images/userIcons/"+ homework.get("user_icon"));
			}

			return homeworks;
		} else {
			return homeworks;
		}
	}
	/**
     * 添加班级作业
     */
	@Override
	public Boolean saveHomework(Homework homework) {
		// TODO Auto-generated method stub
		
		int  saveResult=this.homeworkdao.saveHomework(homework);
		if(saveResult==0){
			System.out.println(saveResult);
			return  false;	
		}else{
        return true;
		}
	}
	/**
     * 通过作业Id删除班级作业
     */
	@Override
	public Boolean deleteHomeworkByHomeworkId(int homeworkId) {
		// TODO Auto-generated method stub
		Boolean  deleteResult=false;
		if(homeworkId>0){
			int n=this.homeworkdao.deleteHomeworkByHomeworkId(homeworkId);
			if(n==0){
				return  false;
			}else{
				return true;
			}
		}else{
			return deleteResult;	
		}
	}

}

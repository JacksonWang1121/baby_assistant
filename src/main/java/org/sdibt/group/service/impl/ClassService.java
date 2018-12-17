package org.sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.ClassDao;
import org.sdibt.group.entity.Class;
import org.sdibt.group.service.IClassService;
import org.springframework.stereotype.Service;

/**
 * 
 * Title:BabyService
 * @author hanfangfang
 * date:2018年9月2日 下午5:59:57
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class ClassService implements IClassService {
	@Resource
	private ClassDao classDao;

	public ClassDao getClassDao() {
		return classDao;
	}
	public void setClassDao(ClassDao classDao) {
		this.classDao = classDao;
	}
	/**
	 * 报名列表：查询全园已分班的班级信息
	 */
	@Override
	public List<Map> listClassInfo(int kindergartenId) {
		return this.classDao.listClassInfo(kindergartenId);
	}
	/**
	 * 报名列表：查询已分班的学生信息
	 */
	@Override
	public List<Map> listBabiesByClassId(int classId) {
		return this.classDao.listBabiesByClassId(classId);
	}
	/**
	 * 各班人数统计图示
	 */
	@Override
	public List<Map> countBabiesInClass() {
		//查询出所有班级和年级
		List<Map> classes = this.classDao.countClass();
		for (Map classInfo : classes) {
			String gradeName=(String) classInfo.get("grade_name");
			String className=(String) classInfo.get("class_name");
			String name=gradeName+className;
			classInfo.put("name", name);
			int classId=(int) classInfo.get("class_id");
			//查询每个班级下的学生人数
			int classSize= this.classDao.countBabiesInClass(classId);
			classInfo.put("classSize", classSize);
		}
		return classes;
	}

	@Override
	public List<org.sdibt.group.entity.Class> listClass() {
		// TODO Auto-generated method stub
		List<org.sdibt.group.entity.Class>  class1=this.classDao.listClass();
		return class1;
	}

	@Override
	public Boolean addclass(Class class1) {
		// TODO Auto-generated method stub
		Boolean result=this.classDao.addclass(class1);
		return result;
	}


	/**
	 * 根据教师id查询班级记录
	 * @param teacherId
	 * @return
	 */
	@Override
	public org.sdibt.group.entity.Class findClass(int teacherId) {
		return this.classDao.findClass(teacherId);
	}

	/**
	 * 根据教师id查询班级记录
	 * @param teacherId
	 * @return
	 */
	@Override
	public org.sdibt.group.entity.Class findClassById(int classId) {
		return this.classDao.findClassById(classId);
	}
	
}

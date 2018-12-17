package org.sdibt.group.service;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Class;


/**
 * 
 * Title:IClassService
 * @author hanfangfang
 * date:2018年9月18日 上午10:22:21
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IClassService {
	/**
	 * 报名列表：查询全园已分班的班级信息
	 * @param kindergartenId
	 * @return
	 */
	public List<Map> listClassInfo(int kindergartenId);
	/**
	 * 报名列表：查询已分班的学生信息
	 * @param classId
	 * @return
	 */
	public List<Map> listBabiesByClassId(int classId);
	/**
	 * 各班人数统计图示
	 */
	public List<Map> countBabiesInClass();

	List<org.sdibt.group.entity.Class> listClass();


	Boolean addclass(Class class1);


	/**
	 * 根据教师id查询班级记录
	 * @param teacherId
	 * @return
	 */
	public org.sdibt.group.entity.Class findClass(int teacherId);

	
}

package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.sdibt.group.entity.Class;



/**
 * 
 * Title:ClassDao
 * @author hanfangfang
 * date:2018年9月18日 上午10:24:04
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface ClassDao {

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
	 * 查询出所有班级和年级
	 */
	public List<Map> countClass();
	/**
	 * 查询每个班级下的学生人数
	 */
	public int countBabiesInClass(int classId);

	public List<org.sdibt.group.entity.Class> listClass();

	/**
	 * 根据教师id查询班级记录
	 * @param teacherId
	 * @return
	 */
	public org.sdibt.group.entity.Class findClass(int teacherId);

	Boolean addclass(Class class1);
	
}

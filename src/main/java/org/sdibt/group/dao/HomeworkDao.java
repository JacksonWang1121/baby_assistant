package org.sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.sdibt.group.entity.Homework;

public interface HomeworkDao {
	/**
     * 通过班级Id查看班级作业信息
     */
   public List<Map> listHomeworkByClassId(int classId);
   /**
    * 添加班级作业
    */
   public int saveHomework(Homework homework);
   /**
    * 通过作业Id删除班级作业
    */
   public int deleteHomeworkByHomeworkId(int homeworkId);
}

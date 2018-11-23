package org.sdibt.group.entity;

import java.io.Serializable;

public class Homework implements Serializable {
	// 作业主键Id
		private int homeworkId;
		// 老师主键Id
		private int teacherId;
		// 班级主键Id
		private int classId;
		// 作业内容
		private String homeworkContent;
		// 发布作业的时间
		private String homeworkDate;
		public int getHomeworkId() {
			return homeworkId;
		}
		public void setHomeworkId(int homeworkId) {
			this.homeworkId = homeworkId;
		}
		public int getTeacherId() {
			return teacherId;
		}
		public void setTeacherId(int teacherId) {
			this.teacherId = teacherId;
		}
		public int getClassId() {
			return classId;
		}
		public void setClassId(int classId) {
			this.classId = classId;
		}
		public String getHomeworkContent() {
			return homeworkContent;
		}
		public void setHomeworkContent(String homeworkContent) {
			this.homeworkContent = homeworkContent;
		}
		public String getHomeworkDate() {
			return homeworkDate;
		}
		public void setHomeworkDate(String homeworkDate) {
			this.homeworkDate = homeworkDate;
		}
		
}

package org.sdibt.group.entity;

import java.io.Serializable;

public class Inform implements Serializable {
	// 通知主键Id
	private int informId;
	// 老师主键Id
	private int teacherId;
	// 班级主键Id
	private int classId;
	// 通知标题
	private String informTitle;
	// 通知内容
	private String informContent;
	// 发布通知的时间
	private String informDate;


	public int getInformId() {
		return informId;
	}

	public void setInformId(int informId) {
		this.informId = informId;
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

	public String getInformTitle() {
		return informTitle;
	}

	public void setInformTitle(String informTitle) {
		this.informTitle = informTitle;
	}

	public String getInformContent() {
		return informContent;
	}

	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}

	public String getInformDate() {
		return informDate;
	}

	public void setInformDate(String informDate) {
		this.informDate = informDate;
	}

	

}

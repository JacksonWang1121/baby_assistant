package org.sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:BabyComment
 * @author hanfangfang
 * date:2018年9月3日 下午3:56:09
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class BabyComment implements Serializable{
	//宝宝点评id
	private int commentId;
	//宝宝id
	private int babyId;
	//教师id
	private int teacherId;
	//班级id
	private int classId;
	//点评内容
	private String commentContent;
	//点评日期
	private String publishDate;
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getBabyId() {
		return babyId;
	}
	public void setBabyId(int babyId) {
		this.babyId = babyId;
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
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
}

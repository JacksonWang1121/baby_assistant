package org.sdibt.group.entity;

/**
 * 代接送实体类
 * @title GenerateSend.java
 * @author JacksonWang
 * @date 2018年11月26日 上午10:43:03
 * @package org.sdibt.group.entity
 * @version 1.0
 *
 */
public class GenerateSend {

	//主键
	private int id;
	//教师id
	private int teacherId;
	//代接人照片
	private String personPicture;
	//描述
	private String description;
	//家长id
	private int parentId;
	//宝宝id
	private int babyId;
	//宝宝姓名
	private String babyName;
	//代接送时间
	private String generateTime;
	//确认状态
	private int auditState;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(int teacherId) {
		this.teacherId = teacherId;
	}
	public String getPersonPicture() {
		return personPicture;
	}
	public void setPersonPicture(String personPicture) {
		this.personPicture = personPicture;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getBabyId() {
		return babyId;
	}
	public void setBabyId(int babyId) {
		this.babyId = babyId;
	}
	public String getBabyName() {
		return babyName;
	}
	public void setBabyName(String babyName) {
		this.babyName = babyName;
	}
	public String getGenerateTime() {
		return generateTime;
	}
	public void setGenerateTime(String generateTime) {
		this.generateTime = generateTime;
	}
	public int getAuditState() {
		return auditState;
	}
	public void setAuditState(int auditState) {
		this.auditState = auditState;
	}

}

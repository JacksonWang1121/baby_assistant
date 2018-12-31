package org.sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:TeacherLeave
 * @author hanfangfang
 * date:2018年10月23日 上午10:51:57
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class TeacherLeave implements Serializable {
    private int leaveId;
    private int userId;
    //用户姓名
    private String realName;
    //请假原因
    private String leaveReason;
    //请假时间
    private String leaveTime;
    //请假日期
    private String submitDate;
    //请假状态
    private String leaveStatus;
	public int getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getLeaveReason() {
		return leaveReason;
	}
	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}
	public String getLeaveTime() {
		return leaveTime;
	}
	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}
	public String getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}
	public String getLeaveStatus() {
		return leaveStatus;
	}
	public void setLeaveStatus(String leaveStatus) {
		this.leaveStatus = leaveStatus;
	}
}

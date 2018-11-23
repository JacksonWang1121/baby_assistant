package org.sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:Baby
 * @author hanfangfang
 * date:2018年8月29日 下午4:55:49
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class BabyAttendance implements Serializable{
	//宝宝考勤id
	private int attendanceId;
	//宝宝主键id
	private int babyId;
	//宝宝考勤时间
	private String startSignDate;
	private String endSignDate;
	
	public int getBabyId() {
		return babyId;
	}
	public void setBabyId(int babyId) {
		this.babyId = babyId;
	}
	public int getAttendanceId() {
		return attendanceId;
	}
	public void setAttendanceId(int attendanceId) {
		this.attendanceId = attendanceId;
	}
	public String getStartSignDate() {
		return startSignDate;
	}
	public void setStartSignDate(String startSignDate) {
		this.startSignDate = startSignDate;
	}
	public String getEndSignDate() {
		return endSignDate;
	}
	public void setEndSignDate(String endSignDate) {
		this.endSignDate = endSignDate;
	}
	
}

package org.sdibt.group.entity;

import java.io.Serializable;

/**
 * 周计划实体类
 * @title WeeklyPlan.java
 * @author JacksonWang
 * @date 2018年11月18日 上午10:38:40
 * @package org.sdibt.group.entity
 * @version 1.0
 *
 */
public class WeeklyPlan implements Serializable {

	//主键
	private int id;
	//班级id
	private int classId;
	//周时间
	private String weekDate;
	//周一上午
	private String mondayMorning;
	//周一下午
	private String mondayAfternoon;
	//周二上午
	private String tuesdayMorning;
	//周二下午
	private String tuesdayAfternoon;
	//周三上午
	private String wednesdayMorning;
	//周三下午
	private String wednesdayAfternoon;
	//周四上午
	private String thursdayMorning;
	//周四下午
	private String thursdayAfternoon;
	//周五上午
	private String fridayMorning;
	//周五下午
	private String fridayAfternoon;
	//周计划图片
	private String weekPicture;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public String getWeekDate() {
		return weekDate;
	}
	public void setWeekDate(String weekDate) {
		this.weekDate = weekDate;
	}
	public String getMondayMorning() {
		return mondayMorning;
	}
	public void setMondayMorning(String mondayMorning) {
		this.mondayMorning = mondayMorning;
	}
	public String getMondayAfternoon() {
		return mondayAfternoon;
	}
	public void setMondayAfternoon(String mondayAfternoon) {
		this.mondayAfternoon = mondayAfternoon;
	}
	public String getTuesdayMorning() {
		return tuesdayMorning;
	}
	public void setTuesdayMorning(String tuesdayMorning) {
		this.tuesdayMorning = tuesdayMorning;
	}
	public String getTuesdayAfternoon() {
		return tuesdayAfternoon;
	}
	public void setTuesdayAfternoon(String tuesdayAfternoon) {
		this.tuesdayAfternoon = tuesdayAfternoon;
	}
	public String getWednesdayMorning() {
		return wednesdayMorning;
	}
	public void setWednesdayMorning(String wednesdayMorning) {
		this.wednesdayMorning = wednesdayMorning;
	}
	public String getWednesdayAfternoon() {
		return wednesdayAfternoon;
	}
	public void setWednesdayAfternoon(String wednesdayAfternoon) {
		this.wednesdayAfternoon = wednesdayAfternoon;
	}
	public String getThursdayMorning() {
		return thursdayMorning;
	}
	public void setThursdayMorning(String thursdayMorning) {
		this.thursdayMorning = thursdayMorning;
	}
	public String getThursdayAfternoon() {
		return thursdayAfternoon;
	}
	public void setThursdayAfternoon(String thursdayAfternoon) {
		this.thursdayAfternoon = thursdayAfternoon;
	}
	public String getFridayMorning() {
		return fridayMorning;
	}
	public void setFridayMorning(String fridayMorning) {
		this.fridayMorning = fridayMorning;
	}
	public String getFridayAfternoon() {
		return fridayAfternoon;
	}
	public void setFridayAfternoon(String fridayAfternoon) {
		this.fridayAfternoon = fridayAfternoon;
	}
	public String getWeekPicture() {
		return weekPicture;
	}
	public void setWeekPicture(String weekPicture) {
		this.weekPicture = weekPicture;
	}

}

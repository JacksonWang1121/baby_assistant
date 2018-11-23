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
public class BabyDiet implements Serializable{
	//宝宝食谱id
	private int dietId;
	//学校id
	private int kindergartenId;
	//食谱应用时间
	private String dietDate;
	//早饭名称
	private String breakfast;
	//午饭名称
	private String lunch;
	//晚饭名称
	private String dinner;
	//早饭图片
	private String breakfastImg;
	//午饭图片
	private String lunchImg;
	//晚饭图片
	private String dinnerImg;
	public int getDietId() {
		return dietId;
	}
	public void setDietId(int dietId) {
		this.dietId = dietId;
	}
	public int getKindergartenId() {
		return kindergartenId;
	}
	public void setKindergartenId(int kindergartenId) {
		this.kindergartenId = kindergartenId;
	}
	public String getBreakfast() {
		return breakfast;
	}
	public void setBreakfast(String breakfast) {
		this.breakfast = breakfast;
	}
	public String getLunch() {
		return lunch;
	}
	public void setLunch(String lunch) {
		this.lunch = lunch;
	}
	public String getDinner() {
		return dinner;
	}
	public void setDinner(String dinner) {
		this.dinner = dinner;
	}
	public String getBreakfastImg() {
		return breakfastImg;
	}
	public void setBreakfastImg(String breakfastImg) {
		this.breakfastImg = breakfastImg;
	}
	public String getLunchImg() {
		return lunchImg;
	}
	public void setLunchImg(String lunchImg) {
		this.lunchImg = lunchImg;
	}
	public String getDinnerImg() {
		return dinnerImg;
	}
	public void setDinnerImg(String dinnerImg) {
		this.dinnerImg = dinnerImg;
	}
	public String getDietDate() {
		return dietDate;
	}
	public void setDietDate(String dietDate) {
		this.dietDate = dietDate;
	}
}

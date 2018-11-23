package org.sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:BabyGrow
 * @author hanfangfang
 * date:2018年9月2日 下午5:59:43
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class BabyGrow implements Serializable{
	//宝宝成长id
	private int growId;
	//宝宝id
	private int babyId;
	//成长记录内容
	private String growContent;
	//成长记录图片
	private String growImg;
	//成长记录发布日期
	private String publishDate;
	public int getGrowId() {
		return growId;
	}
	public void setGrowId(int growId) {
		this.growId = growId;
	}
	public int getBabyId() {
		return babyId;
	}
	public void setBabyId(int babyId) {
		this.babyId = babyId;
	}
	public String getGrowContent() {
		return growContent;
	}
	public void setGrowContent(String growContent) {
		this.growContent = growContent;
	}
	public String getGrowImg() {
		return growImg;
	}
	public void setGrowImg(String growImg) {
		this.growImg = growImg;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
}

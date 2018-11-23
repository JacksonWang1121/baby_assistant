package org.sdibt.group.entity;

import java.io.Serializable;

public class PhotoAlbum implements Serializable {
	// 图片主键Id
			private int photoId;
	// 老师主键Id
		private int teacherId;
		// 班级主键Id
		private int classId;
//		图片地址
		private String photoAddress;
//		发布图片时间
		private String photoDate;
	
		public int getPhotoId() {
			return photoId;
		}
		public void setPhotoId(int photoId) {
			this.photoId = photoId;
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
		public String getPhotoAddress() {
			return photoAddress;
		}
		public void setPhotoAddress(String photoAddress) {
			this.photoAddress = photoAddress;
		}
		public String getPhotoDate() {
			return photoDate;
		}
		public void setPhotoDate(String photoDate) {
			this.photoDate = photoDate;
		}
	
		
		
		
		
		
		
		
		
}

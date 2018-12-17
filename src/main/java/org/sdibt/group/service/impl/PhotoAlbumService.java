package org.sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.dao.PhotoAlbumDao;
import org.sdibt.group.entity.PhotoAlbum;
import org.sdibt.group.service.IPhotoAlbumService;
import org.springframework.stereotype.Service;
@Service
public class PhotoAlbumService implements IPhotoAlbumService {
	@Resource
 private  PhotoAlbumDao photoalbumdao;
	public PhotoAlbumDao getPhotoalbumdao() {
		return photoalbumdao;
	}
	public void setPhotoalbumdao(PhotoAlbumDao photoalbumdao) {
		this.photoalbumdao = photoalbumdao;
	}
	@Override
	public List<PhotoAlbum> listPhotoAlbumByClasId(int classId) {
		// TODO Auto-generated method stub
		List<PhotoAlbum> photoAlbum=this.photoalbumdao.listPhotoAlbumByClasId(classId);
		return photoAlbum;
	}
	@Override
	public boolean savePhotoAlbum(PhotoAlbum photoAlbum) {
		// TODO Auto-generated method stub
		HttpSession session = null;
		int teacherId=10;
		SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd");
		String photoDate = tempDate.format(new Date());
		int classId=1;
		photoAlbum.setClassId(classId);
		photoAlbum.setPhotoDate(photoDate);
		photoAlbum.setTeacherId(teacherId);
		int i=this.photoalbumdao.savePhotoAlbum(photoAlbum);
		if(i==1){
			return true;
		}else{
			return false;
		}
		
	}

}

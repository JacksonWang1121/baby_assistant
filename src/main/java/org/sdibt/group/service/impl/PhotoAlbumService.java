package org.sdibt.group.service.impl;

import java.util.List;

import javax.annotation.Resource;

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

}

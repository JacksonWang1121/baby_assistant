package org.sdibt.group.dao;

import java.util.List;

import org.sdibt.group.entity.PhotoAlbum;

public interface PhotoAlbumDao {

	List<PhotoAlbum> listPhotoAlbumByClasId(int classId);

	int savePhotoAlbum(PhotoAlbum photoAlbum);

}

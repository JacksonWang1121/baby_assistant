package org.sdibt.group.service;

import java.util.List;

import org.sdibt.group.entity.PhotoAlbum;

public interface IPhotoAlbumService {

	List<PhotoAlbum> listPhotoAlbumByClasId(int classId);

}

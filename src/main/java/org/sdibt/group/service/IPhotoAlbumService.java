package org.sdibt.group.service;

import java.util.List;

import org.sdibt.group.entity.PhotoAlbum;
import org.springframework.web.multipart.MultipartFile;

public interface IPhotoAlbumService {

	List<PhotoAlbum> listPhotoAlbumByClasId(int classId);

	boolean savePhotoAlbum(PhotoAlbum photoAlbum, MultipartFile file);

}

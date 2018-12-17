package org.sdibt.group.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.entity.PhotoAlbum;
import org.sdibt.group.service.IPhotoAlbumService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PhotoAlbumController {
	@Resource
	private IPhotoAlbumService photoalbumservice;

	public IPhotoAlbumService getPhotoalbumservice() {
		return photoalbumservice;
	}

	public void setPhotoalbumservice(IPhotoAlbumService photoalbumservice) {
		this.photoalbumservice = photoalbumservice;
	}

	@RequestMapping("/listPhotoAlbumByClasId")
	public String listPhotoAlbumByClasId(Map map) {
		int classId = 1;
		List<PhotoAlbum> photos = this.photoalbumservice
				.listPhotoAlbumByClasId(classId);
		/*
		 * for(PhotoAlbum photo: photos){
		 * System.out.println(photo.getClassId());
		 * System.out.println(photo.getPhotoDate()); }
		 */
		List<PhotoAlbum> photoes = new ArrayList<PhotoAlbum>();
		for (PhotoAlbum photos1 : photos) {
			String photoAddress = photos1.getPhotoAddress();
			int k = 2;
			char[] str;
			str = photoAddress.toCharArray();
			char str1[] = new char[3];
			for (int i = str.length - 1; i > 0; i--) {

				str1[k] = str[i];

				k--;
				if (k < 0) {
					break;
				}
			}
			String phot = String.valueOf(str1);
			if (phot.equals("jpg") || phot.equals("gif") || phot.equals("png")
					||phot.equals("bmp") || phot.equals("jpeg")) {
				photoes.add(photos1);
				
			}


		}
		map.put("photos", photoes);

		return "photoAlbum";
	}

	@RequestMapping("savePhotoAlbum")
	public String savePhotoAlbum(PhotoAlbum photoAlbum) {
		SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd");
		String photoDate = tempDate.format(new Date());
		System.out.println(photoDate);
		return "photoAlbum";
	}

}

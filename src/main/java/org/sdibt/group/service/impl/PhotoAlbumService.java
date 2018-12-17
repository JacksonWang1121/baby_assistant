package org.sdibt.group.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.dao.PhotoAlbumDao;
import org.sdibt.group.entity.PhotoAlbum;
import org.sdibt.group.service.IPhotoAlbumService;
import org.sdibt.group.utils.ImageFileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
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
	public boolean savePhotoAlbum(PhotoAlbum photoAlbum,MultipartFile file) {
		// TODO Auto-generated method stub

		//拿到图片的路径,并作出修改
		if(file.getOriginalFilename()!=""){
			//获取文件名
			String fileName=file.getOriginalFilename();
			
			
			System.out.println(fileName);
			//设置文件保存路径
			String path="http://localhost:8080/babyassistantfile/images/userIcons/";
			//用上传时的时间.后缀名作为文件名，防止重名
		    String	newName = new Date().getTime() + fileName;
			//创建新的文件名

          String  path2=path+newName;
          
 			File file1 = new File("d:\\xxx\\yyy");
System.out.println(file1);
			
			
			photoAlbum.setPhotoAddress(newName);
			System.out.println(newName);
			System.out.println(path2);
		
			//转存文件到指定路径
			try {
				file.transferTo(file1);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch blockr
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		
		
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

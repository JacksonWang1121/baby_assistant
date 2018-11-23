package org.sdibt.group.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.sdibt.group.dao.BabyDietDao;
import org.sdibt.group.dao.BabyGrowDao;
import org.sdibt.group.entity.Baby;
import org.sdibt.group.entity.BabyDiet;
import org.sdibt.group.entity.BabyGrow;
import org.sdibt.group.service.IBabyGrowService;
import org.sdibt.group.utils.ImageFileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sun.org.apache.bcel.internal.generic.ARRAYLENGTH;
/**
 * 
 * Title:BabyServiceImpl
 * @author hanfangfang
 * date:2018年8月29日 下午5:01:53
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service
public class BabyGrowService implements IBabyGrowService {
	@Resource
	private BabyGrowDao babyGrowDao;

	public BabyGrowDao getBabyGrowDao() {
		return babyGrowDao;
	}
	public void setBabyGrowDao(BabyGrowDao babyGrowDao) {
		this.babyGrowDao = babyGrowDao;
	}
	
	/**
	 * 根据当前登录的用户ID查询宝宝信息
	 */
	@Override
	public Map getBabyInfo(Long userId) {
		Map babyInfo = this.babyGrowDao.getBabyInfo(userId);
		String babyIcon = (String) babyInfo.get("baby_icon");
		if(babyIcon.length()!=0){
			babyIcon="http://192.168.43.242:8081/babyassistantfile/images/babyIcons/"+babyIcon;
			babyInfo.put("baby_icon",babyIcon);
    	}else{
    		babyInfo.put("baby_icon","");
    	}
		return babyInfo;
	}

	/**
	 * 查看宝宝成长记录
	 */
	@Override
	public List<Map> listBabyGrow(Long userId) {
		// TODO Auto-generated method stub
		 List<Map> babyGrows = this.babyGrowDao.listBabyGrow(userId);
		//解析图片路径
		//ArrayList list = new ArrayList<>();
		for (Map babyGrow : babyGrows) {
			String pathStr = (String) babyGrow.get("grow_img");
			String babyIcon = (String) babyGrow.get("baby_icon");
			if(pathStr.length()!=0||babyIcon.length()!=0){
				babyIcon="http://192.168.43.242:8081/babyassistantfile/images/babyIcons/"+babyIcon;
				String[] paths = pathStr.substring(pathStr.indexOf(",") + 1).split(",");
				if(paths != null){
					for (int i = 0; i < paths.length; i++) {
						paths[i]="http://192.168.43.242:8081/babyassistantfile/images/growImgs/"+paths[i];
						System.out.println(paths[i]+"----");
					}
				}
				babyGrow.put("baby_icon",babyIcon);
				babyGrow.put("grow_img",paths);
			}else{
				babyGrow.put("baby_icon","");
				babyGrow.put("grow_img","");
			}
		}
		return babyGrows;
	}
	/**
	 * 发布宝宝成长记录
	 */
	@Transactional
	@Override
	public boolean saveBabyGrow(MultipartFile[] files,BabyGrow babyGrow,Long userId) {
		String imgPath="";
		String filePath="";
		//获取文件上传时的文件后缀名
		for (int i = 0; i < files.length; i++) {
			if(files[i].getOriginalFilename()!=""){
				//获取文件名
				String fileName=files[i].getOriginalFilename();
				//设置文件保存路径
				String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/growImgs/");
				//用上传时的时间.后缀名作为文件名，防止重名
				imgPath += ","+new Date().getTime() + fileName;
				//创建新的文件名
				filePath = new Date().getTime() + fileName;
				File growImg = new File(path+filePath);
				//转存文件到指定路径
				try {
					files[i].transferTo(growImg);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		//得到当前日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//将Date类型转换成String类型   
		String currentDate = sdf.format(date);
		//根据家长id查询对应的孩子id
		int babyId=this.babyGrowDao.findBabyIdByUserId(userId);
		Map map = new HashMap<>();
		map.put("babyId", babyId);
		map.put("growContent", babyGrow.getGrowContent());
		map.put("growImg", imgPath);
		map.put("publishDate", currentDate);
		int count = this.babyGrowDao.saveBabyGrow(map);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 删除宝宝成长记录
	 */
	@Override
	public void deleteBabyGrow(int growId) {
		//根据id获取图片路径
		Map image = this.babyGrowDao.getImgPath(growId);
		String pathStr = (String) image.get("grow_img");
		if(pathStr.length()!=0){
			String[] paths = pathStr.substring(pathStr.indexOf(",") + 1).split(",");
			if(paths != null){
				for (int i = 0; i < paths.length; i++) {
					paths[i]="http:/192.168.43.242:8081/babyassistantfile/images/growImgs/"+paths[i];
					//删除文件夹中的图片
					File file = new File(paths[i]);
					file.delete();
				}
			}
		}
		//删除数据库中的数据
		this.babyGrowDao.deleteBabyGrow(growId);
	}
}

package org.sdibt.group.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.sdibt.group.dao.UserDao;
import org.sdibt.group.dao.UserRolesDao;
import org.sdibt.group.entity.Permission;
import org.sdibt.group.entity.User;
import org.sdibt.group.service.IUserService;
import org.sdibt.group.utils.FileUtil;
import org.sdibt.group.utils.ImageFileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * Title:UserServiceImpl
 * @author hanfangfang
 * date:2018年8月28日 上午11:16:36
 * package:org.sdibt.group.service.impl
 * version 1.0
 */
@Service(value="userService") 
public class UserService implements IUserService{

	@Resource
	private UserDao userDao;
	@Resource
	private  UserRolesDao  userRolesDao;
	//文件http访问的路径
	private String filePath = FileUtil.httpFilePath + "images/userIcons/";

	public void setUserRolesDao(UserRolesDao userRolesDao) {
		this.userRolesDao = userRolesDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

   /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    public User findByUsername(String username) {
    	User user = userDao.findByUsername(username);
    	if (user != null) {
			if (user.getUserIcon() != null) {
				user.setUserIcon(filePath + user.getUserIcon());
			}
		}
        return user;
    }

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    public Set<String> findRoles(String username) {
        return userDao.findRoles(username);
    }

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username) {
        return userDao.findPermissions(username);
    }

    /**
	 * 根据用户名查询该用户的角色记录
	 * @param username
	 * @return
	 */
    @Override
	public Map findRoleByUsername(String username) {
		return this.userDao.findRoleByUsername(username);
	}

	@Override
	public Set<Permission> findPermissionsObject(String username) {
		// TODO Auto-generated method stub
		return userDao.findPermissionsObject(username);
	}
	/**
	 * 查看个人资料
	 */
	@Override
	public Map getPersonalData(Long userId) {
		Map personalData = userDao.getPersonalData(userId);
		String userIcon = (String) personalData.get("user_icon");
		if(userIcon.length()!=0){
			userIcon="http://192.168.43.242:8081/babyassistantfile/images/userIcons/"+userIcon;
			personalData.put("user_icon",userIcon);
    	}else{
    		personalData.put("user_icon","");
    	}
		return personalData;
	}
	/**
	 * 修改用户头像
	 */
	@Transactional
	@Override
	public boolean updateUserIcon(Long userId,MultipartFile iconPath) {
		String userIcon="";
		//拿到图片的路径,并作出修改
		if(iconPath.getOriginalFilename()!=""){
			//获取文件名
			String fileName=iconPath.getOriginalFilename();
			//设置文件保存路径
			String path = ImageFileUtils.getPath(this.getClass(),"babyassistantfile/images/userIcons/");
			//用上传时的时间.后缀名作为文件名，防止重名
			userIcon = new Date().getTime() + fileName;
			//创建新的文件名
			File userImg = new File(path + userIcon);
			//转存文件到指定路径
			try {
				iconPath.transferTo(userImg);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Map map = new HashMap<>();
		map.put("userId", userId);
		map.put("userIcon", userIcon);
		int count = this.userDao.updateUserIcon(map);
		if(count==0){
			return false;
		}else{
			return true;
		}

	}
	/**
	 * 修改用户信息
	 */
	@Transactional
	@Override
	public boolean updateUserInfo(Long userId, User user) {
		String nickName = user.getNickName();
		String personalitySignature = user.getPersonalitySignature();
		String address = user.getAddress();
		Map map = new HashMap<>();
		map.put("userId", userId);
		map.put("nickName", nickName);
		map.put("personalitySignature", personalitySignature);
		map.put("address", address);
		int count = this.userDao.updateUserInfo(map);
		if(count==0){
			return false;
		}else{
			return true;
		}

	}

	/**
     * 修改用户信息
     * @return
     */
	@Transactional
	@Override
    public void updateUser(User user) {
    	this.userDao.updateUser(user);
    }

	/**
	 * 是否存在用户手机号
	 */

	@Override
	public Map queryUserInfoByUserId(int userId) {
		// TODO Auto-generated method stub
		if(userId>=0){
	Map user=this.userDao.queryUserInfoByUserId(userId);
	user.put("user_icon","http://localhost:8080/babyassistantfile/images/userIcons/"+ user.get("user_icon"));
	return user;
		}else{
			return null;
		}
	
	}
	

}

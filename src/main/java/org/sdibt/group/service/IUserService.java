package org.sdibt.group.service;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Permission;
import org.sdibt.group.entity.User;
import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * Title:UserService
 * @author hanfangfang
 * date:2018年8月28日 上午11:04:20
 * package:org.sdibt.group.service
 * version 1.0
 */
public interface IUserService {

	/**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    public User findByUsername(String username);

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    public Set<String> findRoles(String username);

    /**
	 * 根据用户名查询该用户的角色记录
	 * @param username
	 * @return
	 */
	public Map findRoleByUsername(String username);

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username);
    public Set<Permission> findPermissionsObject(String username);
    /**
     * 查看个人资料
     */
    public Map getPersonalData(int userId);
    /**
     * 修改用户头像
     * @param userId
     * @param iconPath
     */
    public boolean updateUserIcon(int userId,MultipartFile iconPath);
    /**
     * 修改用户信息
     * @param userId
     * @param user
     * @return
     */
    public boolean updateUserInfo(int userId,User user);

    /**
     * 修改用户信息
     * @return
     */
    public void updateUser(User user);

	public Map queryUserInfoByUserId(int userId);
}

package org.sdibt.group.dao;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.sdibt.group.entity.Permission;
import org.sdibt.group.entity.User;

/**
 * 
 * Title:UserDao
 * @author hanfangfang
 * date:2018年8月28日 上午11:15:36
 * package:org.sdibt.group.dao
 * version 1.0
 */
public interface UserDao {
	/**
	 * 根据用户名查询用户信息
	 * @param username  用户名
	 * @return
	 */
	public User findByUsername(String username);
	
	/**
	 * 根据用户名查询该用户的角色
	 * @param username  用户名
	 * @return
	 */
	Set<String> findRoles(String username);
	
	/**
	 * 根据用户名查询该用户的权利
	 * @param username  用户名
	 * @return
	 */
	Set<String> findPermissions(String username);
	
	/**
	 * 根据用户名查询该用户的权利对象
	 * @param username  用户名
	 * @return
	 */
	Set<Permission> findPermissionsObject(String username);
	/**
     * 查看个人资料
     */
    public Map getPersonalData(Long userId);
    /**
     * 修改用户头像
     */
    public int updateUserIcon(Map map);
    /**
     * 修改用户信息
     * @return
     */
    public int updateUserInfo(Map map);
    /**
     * 判断手机号是否存在
    * @return
     */
	public User isExistUsername(String username);

	  /**
     * 通过手机号查询用户Id
     */
	public int queryUserIdByUsername(String username);
	  /**
     * 通过用户Id查询用户信息
     */
	public Map queryUserInfoByUserId(int userId);

}

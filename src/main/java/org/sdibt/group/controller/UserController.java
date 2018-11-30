package org.sdibt.group.controller;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.sdibt.group.entity.Class;
import org.sdibt.group.entity.Kindergarten;
import org.sdibt.group.entity.Permission;
import org.sdibt.group.entity.User;
import org.sdibt.group.service.IBabyService;
import org.sdibt.group.service.IClassService;
import org.sdibt.group.service.IKindergartenService;
import org.sdibt.group.service.ITeacherLeaveService;
import org.sdibt.group.service.IUserService;
import org.sdibt.group.utils.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * Title:UserController
 * @author hanfangfang
 * date:2018年8月28日 上午11:15:00
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class UserController {

	@Resource 
	private IUserService userService;
	@Resource
	private IKindergartenService kindergartenService;
	@Resource
	private IBabyService babyService;
	@Resource
	private IClassService classService;
	@Resource
	private ITeacherLeaveService teacherLeaveService;

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	public void setKindergartenService(IKindergartenService kindergartenService) {
		this.kindergartenService = kindergartenService;
	}

	public void setBabyService(IBabyService babyService) {
		this.babyService = babyService;
	}

	public void setClassService(IClassService classService) {
		this.classService = classService;
	}
	public ITeacherLeaveService getTeacherLeaveService() {
		return teacherLeaveService;
	}
	public void setTeacherLeaveService(ITeacherLeaveService teacherLeaveService) {
		this.teacherLeaveService = teacherLeaveService;
	}
	/**
	 * 登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/doLogin")  
	public String doLogin(HttpSession session, String username,String password,String rememberMe){ 
		System.out.println("登录用户："+username);
		try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password); 
			if((rememberMe!=null) && ("true".equals(rememberMe))) {
				token.setRememberMe(true);
			}
			Subject currentUser = SecurityUtils.getSubject();
			currentUser.login(token);  //该方法会直接进入userrealm的getauteninfo进行用户名密码验证
			
			//根据用户名获取用户记录
			User user = userService.findByUsername(username);
			//获取用户id
			int userId = Integer.parseInt(user.getId()+"");
			System.out.println("UserController::doLogin-userId = "+userId);
			//将用户信息存放到session作用域中
			session.setAttribute("user", user);

			//获取用户绑定的角色
			Map role = this.userService.findRoleByUsername(username);
			System.out.println("UserController::doLogin-role = "+role.get("description"));
			//将用户的角色信息存放到session作用域中
			session.setAttribute("role", role);
			
			//若用户为园长，则从幼儿园表中查询kindergartenId
			if ("principal".equals(role.get("role"))) {
				//根据园长id查询幼儿园信息
				Kindergarten kindergarten = this.kindergartenService.findKindergarten(userId);
				//将幼儿园id存放到session作用域中
				session.setAttribute("kindergartenId", kindergarten.getId());
			}
			
			//若用户为教师，则从班级表中查询classId和kindergartenId
			else if("teacher".equals(role.get("role"))) {
				//此处注意关键字Class和class
				//根据教师id获取班级记录
				org.sdibt.group.entity.Class cls = this.classService.findClass(userId);
				//将班级记录存放到session作用域中
				session.setAttribute("classInfo", cls);
				session.setAttribute("kindergartenId", cls.getKindergartenId());
			}
			
			//若用户为家长，则从宝宝信息表中查询babyId，classId和kindergartenId
			else if ("parent".equals(role.get("role"))) {
				Map baby = this.babyService.getBabyDataByParentId(user.getId());
				session.setAttribute("babyId", baby.get("baby_id"));
				session.setAttribute("classId", baby.get("class_id"));
				session.setAttribute("kindergartenId", baby.get("kindergarten_id"));
				int classId = (int) baby.get("class_id");
				Class cls = null;
				//学生已分班
				if (!"0".equals(String.valueOf(classId))) {
					cls = this.classService.findClassById(classId);
				}
				session.setAttribute("classInfo", cls);
				//若家长为首次登录，则显示完善个人资料界面
				if (user.getFirstLoginStatus() == 0) {
					return "saveParentInfo";
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
			//登录失败
			return "redirect:/login.jsp?msg=loginFailed";
		}
        return "redirect:/main";
    }

	/**
	 * 退出登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/doLogout")
	public String doLogout(HttpSession session){
		//让session失效
		session.invalidate();
		System.out.println("用户退出系统");
		return "redirect:/login.jsp";
	}

	/**
	 * 查询所有权限
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")
	public String main(HttpServletRequest request){
		//获取session
		HttpSession session = request.getSession();
		//从session作用域中获取username
		String username = (String) session.getAttribute("username");
		//根据username查询用户权限
		Set<Permission> allPermissions = userService.findPermissionsObject(username);
		//得到一个新的权限集合容器
		Set<Permission> permissions = null;
		if (allPermissions != null) {
			//创建权限集合
			permissions = new HashSet<Permission>();
			//遍历allPermissions权限集合
			for (Permission perm : allPermissions) {
				//System.out.println(perm.getParentId()+"-"+perm.getDescription());
				//若当前权限是二级及以下等级的权限，则不显示到主页面上
				if (perm.getParentId() == 0) {
					//System.out.println(perm.getDescription());
					//即将一级权限添加到permissions集合中
					permissions.add(perm);
				}
			}
			System.out.println("UserController::getPermissions-permissions.size = "+permissions.size());
		}
		//将权限存放到request作用域中
		request.setAttribute("permissions", permissions);
		System.out.println("查询用户<"+username+">的权限");
		return "main";
	}

	/**
	 * 查询当前用户
	 * @param session
	 * @return
	 */
	@RequestMapping("/findUser")
	@ResponseBody
	public User findUser(HttpSession session){
		String username = (String) session.getAttribute("username");
		return this.userService.findByUsername(username); 
	}

	/**
	 * 完善家长信息
	 * @param request
	 * @param user
	 * @param headPortrait
	 * @return
	 */
	@RequestMapping("/saveParent")
	@ResponseBody
	public String saveParent(HttpServletRequest request, User user, MultipartFile headPortrait) {
		//获取session
		HttpSession session = request.getSession();
		//从sessio作用域中获取user
		User userInfo = (User) session.getAttribute("user");
		user.setId(userInfo.getId());
		//上传文件
		if (headPortrait != null) {
			String fileName = FileUtil.uploadFile(request, headPortrait, "images/userIcons");
			user.setUserIcon(fileName);
		}
		this.userService.updateUser(user);
		return "true";
	}

	/**
	 * 查看个人主页
	 */
	@RequestMapping("/getPersonalHomePage")
	public String getPersonalHomePage(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		Map user = this.userService.getPersonalData(userId);
		map.put("user", user);
		return "userHomepage";
	}
	/**
	 * 查看个人资料
	 */
	@RequestMapping("/getPersonalData")
	public String getPersonalData(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		Map user = this.userService.getPersonalData(userId);
		map.put("user", user);
		String role = (String) user.get("role");
		if(role.equals("teacher")||role.equals("principal")){
			return "teacherData";
		}else{
			return "parentData";
		}
	}
	/**
	 * 修改用户头像
	 */
	@ResponseBody
	@RequestMapping("/updateUserIcon")
	public String updateUserIcon(HttpSession session,
		@RequestParam(value = "iconPath", required = false) MultipartFile iconPath){
		Long userId=(Long) session.getAttribute("userId");
		boolean updateResult = this.userService.updateUserIcon(userId,iconPath);
		if(updateResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	/**
	 * 修改用户信息
	 */
	@ResponseBody
	@RequestMapping("/updateUserInfo")
	public String updateUserInfo(HttpSession session,User user){
		Long userId=(Long) session.getAttribute("userId");
		boolean updateResult = this.userService.updateUserInfo(userId,user);
		if(updateResult==true){
			return "true";
		}else{
			return "false";
		}
	}

	@RequestMapping("/queryUserInfoByUserId")
	public String queryUserInfoByUserId(int userId,Map map){
		System.out.println(userId);
		Map user=this.userService.queryUserInfoByUserId(userId);
		map.put("user", user);
		System.out.println(user);
		return "userDetail";
	}
}

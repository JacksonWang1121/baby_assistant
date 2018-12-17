package org.sdibt.group.controller;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.sdibt.group.entity.Kindergarten;
import org.sdibt.group.entity.Permission;
import org.sdibt.group.entity.TeacherLeave;
import org.sdibt.group.entity.User;
import org.sdibt.group.service.IBabyService;
import org.sdibt.group.service.IClassService;
import org.sdibt.group.service.IKindergartenService;
import org.sdibt.group.service.ITeacherLeaveService;
import org.sdibt.group.service.IUserService;
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
			session.setAttribute("userId", user.getId());
			//获取用户绑定的角色
			Set<String> roles = userService.findRoles(username);
			//获取roles集合中的第一个(k,v)对的value值
			String role = roles.iterator().next();
			System.out.println("UserController::doLogin-role = "+role);
			//将用户的角色信息存放到session作用域中
			session.setAttribute("role", role);
			
			//若用户为园长，则从幼儿园表中查询kindergartenId
			if ("principal".equals(role)) {
				//根据园长id查询幼儿园信息
				Kindergarten kindergarten = this.kindergartenService.findKindergarten(userId);
				//将幼儿园id存放到session作用域中
				session.setAttribute("kindergartenId", kindergarten.getId());
			}
			
			//若用户为教师，则从班级表中查询classId和kindergartenId
			else if("teacher".equals(role)) {
				//此处注意关键字Class和class
				//根据教师id获取班级记录
				org.sdibt.group.entity.Class classInfo = this.classService.findClass(userId);
				//将班级记录存放到session作用域中
				session.setAttribute("class", classInfo);
				session.setAttribute("kindergartenId", classInfo.getKindergartenId());
			}
			
			//若用户为家长，则从宝宝信息表中查询babyId，classId和kindergartenId
			else if ("parent".equals(role)) {
				Map baby = this.babyService.getBabyDataByParentId(user.getId());
				session.setAttribute("babyId", baby.get("id"));
				session.setAttribute("classId", baby.get("class_id"));
				session.setAttribute("kindergartenId", baby.get("kindergarten_id"));
				//若家长为首次登录，则显示完善个人资料界面
				if (user.getFirstLoginStatus() == 0) {
					return "saveBabyInfo";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			//登录失败
			return "redirect:/login.jsp";
		}
        return "redirect:/main";
    }
	/**
	 * 查询所有权限
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")
	public String main(HttpSession session,HttpServletRequest request){



		User user = (User) session.getAttribute("user");
		Set<Permission> permissions = userService.findPermissionsObject(user.getUsername());

		request.setAttribute("lst", permissions);
		return "main";
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
	
	/**
	 * 退出登录
	 * @param session
	 * @return
	 */
	@RequestMapping("/logout")
	public String doLogout(HttpSession session){
		//移除session
		session.invalidate();
		return "login";
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

package org.sdibt.group.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.GenerateSend;
import org.sdibt.group.entity.User;
import org.sdibt.group.service.IGenerateSendService;
import org.sdibt.group.utils.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 代接送业务流程层
 * @title GenerateSendController.java
 * @author JacksonWang
 * @date 2018年11月26日 下午2:48:11
 * @package org.sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/generateSend")
public class GenerateSendController {

	@Resource
	private IGenerateSendService generateSendService;
	//文件访问http地址
	private String filePath = FileUtil.httpFilePath + "images/generateSend/";

	public void setGenerateSendService(IGenerateSendService generateSendService) {
		this.generateSendService = generateSendService;
	}

	/**
	 * 查询待确认的代接送信息
	 * @return
	 */
	@RequestMapping("/listGenerateSendPending")
	public String listGenerateSendPending(HttpServletRequest request) {
		//获取session
		HttpSession session = request.getSession();
		//获取当前登录用户的user信息
		User user = (User) session.getAttribute("user");
		int userId = Integer.parseInt(String.valueOf(user.getId()));
		//获取用户角色信息
		Map role = (Map) session.getAttribute("role");
		List<GenerateSend> list = null;
		//若该用户为家长，则执行家长的方法
		if ("parent".equals(role.get("role"))) {
			list = this.generateSendService.listGenerateSendForParent(userId, "pending");
			System.out.println("list.size = "+list.size());
		} else {
			list = this.generateSendService.listGenerateSendForTeacher(userId, "pending");
		}
		request.setAttribute("sendList", list);
		return "listGenerateSendPending";
	}

	/**
	 * 查询已确认的代接送信息
	 * @return
	 */
	@RequestMapping("/listGenerateSendConfirmed")
	public String listGenerateSendConfirmed(HttpServletRequest request) {
		//获取session
		HttpSession session = request.getSession();
		//获取当前登录用户的user信息
		User user = (User) session.getAttribute("user");
		int userId = Integer.parseInt(String.valueOf(user.getId()));
		//获取用户角色信息
		Map role = (Map) session.getAttribute("role");
		List<GenerateSend> list = null;
		//若该用户为家长，则执行家长的方法
		if ("parent".equals(role.get("role"))) {
			list = this.generateSendService.listGenerateSendForParent(userId, "confirmed");
		} else {
			list = this.generateSendService.listGenerateSendForTeacher(userId, "confirmed");
		}
		request.setAttribute("sendList", list);
		return "listGenerateSendConfirmed";
	}

	/**
	 * 拍照
	 * @param personPhoto
	 * @return
	 */
	@RequestMapping("/takePicture")
	@ResponseBody
	public String takePicture(HttpServletRequest request, MultipartFile personPhoto) {
		if (personPhoto != null) {
			String fileName = FileUtil.uploadFile(request, personPhoto, "images/generateSend");
			return filePath+fileName;
		}
		return null;
	}

	/**
	 * 删除照片
	 * @param personPhoto
	 * @return
	 */
	@RequestMapping("/deletePersonPicture")
	public void takePicture(String personPhoto) {
		if (personPhoto != null) {
			String fileName = personPhoto.substring(personPhoto.lastIndexOf("/"));
			FileUtil.deleteFile(fileName, "images/generateSend/");
		}
	}

	/**
	 * 添加代接送信息
	 * @return
	 */
	@RequestMapping("/saveGenerateSend")
	@ResponseBody
	public String saveGenerateSend(HttpServletRequest request, GenerateSend generateSend) {
		//获取session
		HttpSession session = request.getSession();
		//获取当前登录用户的user信息,教师或园长
		User user = (User) session.getAttribute("user");
		int userId = Integer.parseInt(String.valueOf(user.getId()));
		generateSend.setTeacherId(userId);
		String picture = generateSend.getPersonPicture();
		if (picture != null) {
			String photo = picture.substring(picture.indexOf("babyassistant")+18);
			System.out.println("GenerateSendController::saveGenerateSend-photo = "+photo);
			generateSend.setPersonPicture(photo);
		}
		this.generateSendService.saveGenerateSend(generateSend);
		return "true";
	}

	/**
	 * 重发通知
	 * @return
	 */
	@RequestMapping("/saveGenerateSendAgain")
	public String saveGenerateSendAgain(GenerateSend generateSend) {
		//日期格式化
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//获取格式化后的日期
		String date = df.format(new Date());
		//重新设置发送时间
		generateSend.setGenerateTime(date);
		//设置审核状态为0，即未审核
		generateSend.setAuditState(0);
		this.generateSendService.updateGenerateSend(generateSend);
		return "listGenerateSendPending";
	}

	/**
	 * 审核代接送信息
	 * @return
	 */
	@RequestMapping("/auditGenerateSend")
	public String auditGenerateSend(GenerateSend generateSend) {
		this.generateSendService.updateGenerateSend(generateSend);
		return "listGenerateSend";
	}

}

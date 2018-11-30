package org.sdibt.group.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Inform;
import org.sdibt.group.service.IInformService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class InformController {
	@Resource
	private IInformService informservice;

	public IInformService getInformservice() {
		return informservice;
	}

	public void setInformservice(IInformService informservice) {
		this.informservice = informservice;
	}

	/**
     * 通过班级Id查看班级通知信息
     */
	@RequestMapping("/listInformByClassId")
	public String listInformByClassId(Map map) {
		int classId = 1;
		int parentId=10;
		List<Map> informs = this.informservice.listInformByClassId(classId,parentId);
		map.put("informs", informs);
		return "inform";
	}
	
	/**
     * 保存班级通知
     */
	@ResponseBody
	@RequestMapping("/saveInform")
	public  String saveInform(HttpSession session,Inform inform,Map map){
        int classId=1;
        
        
        int teacherId=(int) session.getAttribute("userId");

		
		
		inform.setTeacherId(teacherId);
		SimpleDateFormat  simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String informDate=simpleDateFormat.format(new Date());
		inform.setInformDate(informDate);
		inform.setTeacherId(teacherId);
		inform.setClassId(classId);
	      boolean  result=this.informservice.saveInform(inform,classId);
		return "true";
	}
	
	/**
     * 根据通知Id查询通知内容
     */
	@RequestMapping("/queryInformByInformId")
	public String queryInformByInformId(int informId,Map map){
		int parentId=1;
		Inform  inform=this.informservice.queryInformByInformId(informId,parentId);
		map.put("inform", inform);
		return  "informDetail";
	}
	
	
	/**
     * 根据通知Id删除通知内容
     */
	@RequestMapping("/deleteInformByInformId")
	@ResponseBody
	public boolean deleteInformByInformId(int informId){
	    
		boolean   result=this.informservice.deleteInformByInformId(informId);
		
		return  result;
	}
	
}

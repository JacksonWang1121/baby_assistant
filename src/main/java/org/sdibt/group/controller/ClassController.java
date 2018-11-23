package org.sdibt.group.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.sdibt.group.entity.Class;
import org.sdibt.group.service.IClassService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * 
 * Title:ClassController
 * @author hanfangfang
 * date:2018年9月18日 上午10:20:46
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class ClassController {
	@Resource
	private IClassService classService;
	public IClassService getClassService() {
		return classService;
	}
	public void setClassService(IClassService classService) {
		this.classService = classService;
	}
	/**
	 * 报名列表：查询全园已分班的班级信息
	 * @param map
	 * @return
	 */
	@RequestMapping("/listClassInfo")
	public String listClassInfo(HttpSession session,Map map){
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		List<Map> classInfos = this.classService.listClassInfo(kindergartenId);
		map.put("classInfos", classInfos);
		return "hasDivide";
	}
	/**
	 * 报名列表：查询已分班的学生信息
	 * @param map
	 * @return
	 */
	@RequestMapping("/listBabiesByClassId")
	public String listBabiesByClassId(int classId,Map map){
		List<Map> babyInfos = this.classService.listBabiesByClassId(classId);
		map.put("babyInfos", babyInfos);
		return "listBabies";
	}
	/**
	 * 各班人数统计图示:依赖h5
	 */
	@ResponseBody
	@RequestMapping("/countBabiesInClass")
	public Map getProductsChart(){
		 //获取数据
		 List<Map> classesChart = this.classService.countBabiesInClass();
		 //造符合ECHARTS的数据
		 Map resultMap =new HashMap();
		 List labels=new ArrayList<String>();
		 List nums=new ArrayList<Integer>();
		 for (Map classes : classesChart) {
			 labels.add(classes.get("name"));
			 nums.add(classes.get("classSize"));
		 }
		 resultMap.put("type", "班级人数");
		 resultMap.put("labels", labels);
		 resultMap.put("nums", nums);
		 return resultMap;
	}

	@RequestMapping("/listClassesInfo")
	public String listClass(Map map,HttpServletRequest request){
		
		List<Class>  class1=this.classService.listClass();
	/*	for(Class class2 : class1){
			System.out.println(class2.class_name);
		}*/
		map.put("class1", class1);
		//request.setAttribute("class1",class1);
	
		return "class_list";
	}


}

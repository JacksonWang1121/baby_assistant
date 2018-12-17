package org.sdibt.group.service.impl;

import java.util.*;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.sdibt.group.dao.BabyDao;
import org.sdibt.group.dao.HomeworkDao;
import org.sdibt.group.dao.InformDao;
import org.sdibt.group.dao.LookStateDao;
import org.sdibt.group.entity.Homework;
import org.sdibt.group.entity.Inform;
import org.sdibt.group.entity.LookState;
import org.sdibt.group.service.IInformService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class InformService implements IInformService {
	@Resource
	private InformDao informdao;
	@Resource
	private LookStateDao lookstatedao;
	@Resource
	private  BabyDao  babyDao;
	public BabyDao getBabyDao() {
		return babyDao;
	}
	public void setBabyDao(BabyDao babyDao) {
		this.babyDao = babyDao;
	}
	public InformDao getInformdao() {
		return informdao;
	}
	public void setInformdao(InformDao informdao) {
		this.informdao = informdao;
	}
	public LookStateDao getLookstatedao() {
		return lookstatedao;
	}
	public void setLookstatedao(LookStateDao lookstatedao) {
		this.lookstatedao = lookstatedao;
	}
	/**
     * 通过班级Id查看班级通知信息
     */
	@Override
	@Transactional
	public List<Map> listInformByClassId(int classId, int parentId) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("classId", classId);
		map.put("parentId", parentId);
		List<Map> informs = this.informdao.listInformByClassId(map);
		for (Map inform : informs) {
			String i = (String) inform.get("look_state");
		    //给查看状态赋值
			if ("1".equals(i)) {
				inform.put("look_state", "已查看");
			} else if ("0".equals(i)) {
				inform.put("look_state", "未查看");
			}

		}

		return informs;
	}
	/**
     * 根据通知Id查询通知内容
     */
	@Override
	public Inform queryInformByInformId(int informId, int parentId) {
		// TODO Auto-generated method stub
		//根据通知Id,用户ID查看用户的查看状态
        String  lookStates=this.lookstatedao.queryLookState(informId,parentId);
       
	   if("0".equals(lookStates)){
			
			 
		     //如果查看通知状态为0即为未查看，根据通知Id,用户ID更新通知状态为1即为已查看
			this.lookstatedao.updateLookState(informId,parentId);
		}
       //根据通知Id查询通知内容
		Inform inform = this.informdao.queryInformByInformId(informId);
		return inform;
	}
	
	/**
     * 根据通知Id删除通知内容
     */
	@Override
	public Boolean deleteInformByInformId(int informId) {
		// TODO Auto-generated method stub
		//根据通知Id删除通知内容
		 int i=this.informdao.deleteInformByInformId(informId);
		 //根据通知Id删除该通知的所有查看状态
		 if(i==1){
				i=this.lookstatedao.deleteLookStateByInformId(informId);
				if(i==0){
					return  false;	
				}else{
					return true;
				}
				
		 }else{
				return  false;	
		 }

		
	}
	/**
     * 保存班级通知
     */
	@Override
	public boolean saveInform(Inform inform, int classId) {
		// TODO Auto-generated method stub

		if (inform != null) {
			String informDate = inform.getInformDate();
			String lookstate = "0";
			int n = 0;
			// 保存班级通知
			int i = this.informdao.saveInform(inform);
			if (i == 1) {
				// 根据通知时间查询通知Id
				int informId = this.informdao
						.listInformIdByInformDate(informDate);
				// 根据班级Id查询该班级所有家长Id
				List<Integer> parentIds = this.babyDao
						.listParentIdByClassId(classId);

				for (int k = 0; k < parentIds.size(); k++) {
					LookState lookstates = new LookState();
					int parentId = parentIds.get(k);
					lookstates.setInformId(informId);
					lookstates.setParentId(parentId);
					lookstates.setLookState(lookstate);
					// 保存班级通知查看状态
					int p = this.lookstatedao.saveLookState(lookstates);
					n += p;
				}
				if (n == 0) {
					return false;
				} else {
					return true;
				}
			} else {
				return false;
			}

		} else {
			return false;
		}

	}

}

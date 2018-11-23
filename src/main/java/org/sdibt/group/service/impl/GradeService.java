package org.sdibt.group.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.sdibt.group.dao.GradeDao;
import org.sdibt.group.entity.Grade;
import org.sdibt.group.service.IGradeService;
import org.springframework.stereotype.Service;
@Service
public class GradeService implements IGradeService {
	@Resource
private  GradeDao gradedao;
	public GradeDao getGradedao() {
		return gradedao;
	}
	public void setGradedao(GradeDao gradedao) {
		this.gradedao = gradedao;
	}
	@Override
	public List<Grade> listGrade() {
		// TODO Auto-generated method stub
		List<Grade>  grade=this.gradedao.listGrade();
		
		
		return grade;
	}

}

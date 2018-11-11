package com.jhta.netflix.grade.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.grade.dao.GradeDao;
import com.jhta.netflix.grade.vo.GradeVo;

@Service
public class GradeService {
	@Autowired
	private GradeDao dao;
	
	public int insert(GradeVo vo) {
		return dao.insert(vo);
	}
	
	public List<GradeVo> list(){
		return dao.list();
	}
	
	public GradeVo selectone(int num) {
		return dao.selectone(num);
	}
	
	public int update(GradeVo vo) {
		return dao.update(vo);
	}
	
	public int delete(int num) {
		return dao.delete(num);
	}
}

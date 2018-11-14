package com.jhta.netflix.interasts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.interasts.dao.InterastsDao;
import com.jhta.netflix.interasts.vo.InterastsVo;

@Service
public class InterastsService {
	@Autowired
	private InterastsDao dao;
	
	public int insert(InterastsVo vo) {
		return dao.insert(vo);
	}
	public int update(InterastsVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<InterastsVo> list(){
		return dao.list();
	}
	public InterastsVo find(HashMap<String, Object> map) {
		return dao.find(map);
	}
	public int count(int num) {
		return dao.count(num);
	}
}

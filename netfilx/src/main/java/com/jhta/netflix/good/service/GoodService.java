package com.jhta.netflix.good.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.good.dao.GoodDao;
import com.jhta.netflix.good.vo.GoodVo;

@Service
public class GoodService {
	@Autowired
	private GoodDao dao;
	
	public int insert(GoodVo vo) {
		return dao.insert(vo);
	}
	public int update(GoodVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public int relDelete(int num) {
		return dao.relDelete(num);
	}
	public List<GoodVo> list(){
		return dao.list();
	}
	public GoodVo find(HashMap<String, Object> map) {
		return dao.find(map);
	}
	public int count(int num) {
		return dao.count(num);
	}
}

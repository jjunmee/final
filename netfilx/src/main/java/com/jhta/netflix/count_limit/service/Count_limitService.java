package com.jhta.netflix.count_limit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.count_limit.dao.Count_limitDao;
import com.jhta.netflix.count_limit.vo.Count_limitVo;

@Service
public class Count_limitService {
	@Autowired
	private Count_limitDao dao;
	
	public int insert(Count_limitVo vo) {
		return dao.insert(vo);
	}
	public int update(Count_limitVo vo) {
		return dao.update(vo);
	}
	public Count_limitVo find(int num) {
		return dao.find(num);
	}
	public String getLimitNum(int num) {
		return dao.getLimitNum(num);
	}
}

package com.jhta.netflix.rates.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.rates.dao.RatesDao;
import com.jhta.netflix.rates.vo.RatesVo;

@Service
public class RatesService {
	@Autowired
	private RatesDao dao;
	
	public int insert(RatesVo vo) {
		return dao.insert(vo);
	}
	public int update(RatesVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<RatesVo> list(){
		return dao.list();
	}
	public RatesVo find(int num) {
		return dao.find(num);
	}
}

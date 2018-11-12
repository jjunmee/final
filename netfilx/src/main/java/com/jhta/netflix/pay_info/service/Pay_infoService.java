package com.jhta.netflix.pay_info.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.pay_info.dao.Pay_infoDao;
import com.jhta.netflix.pay_info.vo.Pay_infoVo;

@Service
public class Pay_infoService {
	@Autowired
	private Pay_infoDao dao;
	
	public int insert(Pay_infoVo vo) {
		return dao.insert(vo);
	}
	
	public List<Pay_infoVo> list(){
		return dao.list();
	}
	
	public Pay_infoVo selectone(int num) {
		return dao.selectone(num);
	}
	
	public int delete(int num) {
		return dao.delete(num);
	}
}

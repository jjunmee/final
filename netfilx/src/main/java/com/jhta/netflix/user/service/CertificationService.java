package com.jhta.netflix.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.user.dao.CertificationDao;
import com.jhta.netflix.user.dao.CertificationDaoImpl;
import com.jhta.netflix.user.vo.CertificationVo;

@Service
public class CertificationService {
	@Autowired
	private CertificationDaoImpl dao;
	
	public int maxNo() {
		return dao.maxNo();
	}
	public String getInfo(int no) {
		return dao.getInfo(no);
	}
	public int insert(CertificationVo vo) {
		return dao.insert(vo);
	}
	public void cerTest() {
		dao.cerTest();
	}
}

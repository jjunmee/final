package com.jhta.netflix.staff.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.staff.dao.StaffDao;
import com.jhta.netflix.staff.vo.StaffVo;

@Service
public class StaffService {
	@Autowired
	private StaffDao dao;
	public int insert(StaffVo vo) {
		return dao.insert(vo);
	}
	public int update(StaffVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<StaffVo> list(HashMap<String, Object> map){
		return dao.list(map);
	}
	public int listCount(HashMap<String, Object> map) {
		return dao.listCount(map);
	}
}

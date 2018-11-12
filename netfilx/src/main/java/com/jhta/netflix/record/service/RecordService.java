package com.jhta.netflix.record.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.record.dao.RecordDao;
import com.jhta.netflix.record.vo.RecordVo;

@Service
public class RecordService {
	@Autowired
	private RecordDao dao;
	
	public int insert(RecordVo vo) {
		return dao.insert(vo);
	}
	public int update(RecordVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<RecordVo> list(){
		return dao.list();
	}
	public RecordVo find(RecordVo vo) {
		return dao.find(vo);
	}
}

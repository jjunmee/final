package com.jhta.netflix.qna.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.qna.dao.QnaDao;
import com.jhta.netflix.qna.vo.QnaVo;

@Service
public class QnaService {
	@Autowired
	private QnaDao dao;
	
	public int insert(QnaVo vo) {
		return dao.insert(vo);
	}
	public List<QnaVo> list(HashMap<String, Object> map){
		return dao.list(map);
	}
	public int listCount(HashMap<String, Object> map) {
		return dao.listCount(map);
	}
	public QnaVo detail(int num) {
		return dao.detail(num);
	}
	public int update(QnaVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public int maxnum() {
		return dao.maxnum();
	}
}

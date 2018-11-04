package com.jhta.netflix.qna.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.qna.dao.QnaDao;
import com.jhta.netflix.qna.vo.QnaVo;
import com.jhta.netflix.qna_user.vo.Qna_userVo;

@Service
public class QnaService {
	@Autowired
	private QnaDao dao;
	
	public int insert(QnaVo vo) {
		return dao.insert(vo);
	}
	public List<Qna_userVo> list(HashMap<String, Object> map){
		return dao.list(map);
	}
	public int listCount(HashMap<String, Object> map) {
		return dao.listCount(map);
	}
	public Qna_userVo detail(int num) {
		return dao.detail(num);
	}
	public Qna_userVo a_detail(int num) {
		return dao.a_detail(num);
	}
	public int update(QnaVo vo) {
		return dao.update(vo);
	}
	public int update(HashMap<String, Object> map) {
		return dao.update(map);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public int a_delete(int num) {
		return dao.a_delete(num);
	}
	public int maxnum() {
		return dao.maxnum();
	}
}

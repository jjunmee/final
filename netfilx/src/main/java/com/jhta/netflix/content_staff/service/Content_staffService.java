package com.jhta.netflix.content_staff.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.content_staff.dao.Content_staffDao;
import com.jhta.netflix.content_staff.vo.Content_staffVo;

@Service
public class Content_staffService {
	@Autowired
	private Content_staffDao dao;
	
	public int insert(Content_staffVo vo) {
		return dao.insert(vo);
	}
	public int update(Content_staffVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<Content_staffVo> list(){
		return dao.list();
	}
	public Content_staffVo find(int num) {
		return dao.find(num);
	}
}

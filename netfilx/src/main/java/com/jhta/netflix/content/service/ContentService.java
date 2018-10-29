package com.jhta.netflix.content.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.content.dao.ContentDao;
import com.jhta.netflix.content.vo.ContentVo;

@Service
public class ContentService {
	@Autowired
	private ContentDao dao;
	
	public int insert(ContentVo vo) {
		return dao.insert(vo);
	}
	public int update(ContentVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<ContentVo> list(){
		return dao.list();
	}
	public ContentVo find(int num) {
		return dao.find(num);
	}
	public int count() {
		return dao.count();
	}
}

package com.jhta.netflix.content_comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.content_comment.dao.Content_commentDao;
import com.jhta.netflix.content_comment.vo.Content_commentVo;

@Service
public class Content_commentService {
	@Autowired
	private Content_commentDao dao;
	
	public int insert(Content_commentVo vo) {
		return dao.insert(vo);
	}
	public int update(Content_commentVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<Content_commentVo> list(int num){
		return dao.list(num);
	}
	public Content_commentVo find(int num) {
		return dao.find(num);
	}
}

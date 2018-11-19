package com.jhta.netflix.content_comment.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.content_comment.dao.Content_commentDao;
import com.jhta.netflix.content_comment.vo.Comment_bookmarkVo;
import com.jhta.netflix.content_comment.vo.Content_commentVo;
import com.jhta.netflix.content_comment.vo.Mypage_commentVo;

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
	public List<Comment_bookmarkVo> list(HashMap<String, Object> map){
		return dao.list(map);
	}
	public Content_commentVo find(int num) {
		return dao.find(num);
	}
	public int count(int num) {
		return dao.count(num);
	}
	public int getMax() {
		return dao.getMax();
	}
	public List<Content_commentVo> subList(int num){
		return dao.subList(num);
	}
	public List<Mypage_commentVo> userCoList(HashMap<String, Object> map){
		return dao.userCoList(map);
	}
	public int userCoCount(HashMap<String, Object> map) {
		return dao.userCoCount(map);
	}
}

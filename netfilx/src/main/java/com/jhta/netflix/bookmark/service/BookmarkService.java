package com.jhta.netflix.bookmark.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.bookmark.dao.BookmarkDao;
import com.jhta.netflix.bookmark.vo.BookmarkVo;

@Service
public class BookmarkService{
	@Autowired
	private BookmarkDao dao;
	
	public int insert(BookmarkVo vo) {
		return dao.insert(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public BookmarkVo timeSelec(int num) {
		return dao.timeSelec(num);
	}
}

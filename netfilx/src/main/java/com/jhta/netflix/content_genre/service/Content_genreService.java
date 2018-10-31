package com.jhta.netflix.content_genre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.content_genre.dao.Content_genreDao;
import com.jhta.netflix.content_genre.vo.Content_genreVo;

@Service
public class Content_genreService {
	@Autowired
	private Content_genreDao dao;
	
	public int insert(Content_genreVo vo) {
		return dao.insert(vo);
	}
	public int update(Content_genreVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public int genredelete(int num) {
		return dao.genredelete(num);
	}
	public List<Content_genreVo> list(int num){
		return dao.list(num);
	}
	public Content_genreVo find(int num) {
		return dao.find(num);
	}
	public int getCategory(int num) {
		return dao.getCategory(num);
	}
}

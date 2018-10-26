package com.jhta.netflix.genre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.genre.dao.GenreDao;
import com.jhta.netflix.genre.vo.GenreVo;

@Service
public class GenreService {
	@Autowired
	private GenreDao dao;
	
	public int insert(GenreVo vo) {
		return dao.insert(vo);
	}
	public int update(GenreVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<GenreVo> list(int num){
		return dao.list(num);
	}
}
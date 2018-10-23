package com.jhta.netflix.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.category.dao.CategoryDao;
import com.jhta.netflix.category.vo.CategoryVo;

@Service
public class CategoryService {
	@Autowired
	private CategoryDao dao;
	
	public int insert(CategoryVo vo){
		return dao.insert(vo);
	}
	public List<CategoryVo> list(int category_num){
		return dao.list(category_num);
	}
	public int update(int category_num) {
		return dao.update(category_num);
	}
	public int delete(int category_num) {
		return dao.delete(category_num);
	}
}

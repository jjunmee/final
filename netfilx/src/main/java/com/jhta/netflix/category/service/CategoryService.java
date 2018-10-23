package com.jhta.netflix.category.service;

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
}

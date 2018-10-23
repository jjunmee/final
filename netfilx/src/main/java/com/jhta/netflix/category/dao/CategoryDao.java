package com.jhta.netflix.category.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.category.vo.CategoryVo;

@Repository
public class CategoryDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.CategoryMapper";
	
	public int insert(CategoryVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert",vo);
	}
	
}

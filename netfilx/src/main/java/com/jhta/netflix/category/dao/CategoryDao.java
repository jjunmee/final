package com.jhta.netflix.category.dao;

import java.util.List;

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
	public int delete(int category_num) {
		return sqlSession.delete(NAMESPACE + ".delete",category_num);
	}
	public int update(CategoryVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	public List<CategoryVo> list(){
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	public CategoryVo selectname(int category_num) {
		return sqlSession.selectOne(NAMESPACE + ".selectname",category_num);
	}
}

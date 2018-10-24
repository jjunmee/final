package com.jhta.netflix.content.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.content.vo.ContentVo;

@Repository
public class ContentDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.ContentMapper";
	
	public int insert(ContentVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	public int update(ContentVo vo) {
		return sqlSession.update(NAMESPACE + ".update", vo);
	}
	
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete", num);
	}
	
	public List<ContentVo> list(){
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	
	public ContentVo find(int num) {
		return sqlSession.selectOne(NAMESPACE + ".find", num);
	}
}

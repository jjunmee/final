package com.jhta.netflix.content.dao;

import java.util.HashMap;
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
	
	public List<ContentVo> list(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".list", map);
	}
	
	public ContentVo find(int num) {
		return sqlSession.selectOne(NAMESPACE + ".find", num);
	}
	public int count() {
		return sqlSession.selectOne(NAMESPACE + ".count");
	}
	public int listCount(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".listCount",map);
	}
	public int maxNum() {
		return sqlSession.selectOne(NAMESPACE + ".maxNum");
	}
	public int deleteSeries(int num) {
		return sqlSession.update(NAMESPACE+".deleteSeries", num);
	}
}

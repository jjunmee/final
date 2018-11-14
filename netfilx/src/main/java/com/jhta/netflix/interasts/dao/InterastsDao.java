package com.jhta.netflix.interasts.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.interasts.vo.InterastsVo;

@Repository
public class InterastsDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.InterastsMapper";
	
	public int insert(InterastsVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(InterastsVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public List<InterastsVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public InterastsVo find(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE+".find", map);
	}
	public int count(int num) {
		return sqlSession.selectOne(NAMESPACE+".count", num);
	}
}

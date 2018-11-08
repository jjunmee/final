package com.jhta.netflix.good.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.good.vo.GoodVo;

@Repository
public class GoodDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.GoodMapper";
	
	public int insert(GoodVo vo) {
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}
	public int update(GoodVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public List<GoodVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public GoodVo find(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE+".find", map);
	}
	public int count(int num) {
		return sqlSession.selectOne(NAMESPACE+".count", num);
	}
}

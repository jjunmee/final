package com.jhta.netflix.count_limit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.count_limit.vo.Count_limitVo;

@Repository
public class Count_limitDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.Count_limitMapper";
	
	public int insert(Count_limitVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(Count_limitVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public Count_limitVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
	public String getLimitNum(int num) {
		return sqlSession.selectOne(NAMESPACE+".getLimitNum", num);
	}
}

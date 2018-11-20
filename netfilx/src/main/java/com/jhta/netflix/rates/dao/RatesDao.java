package com.jhta.netflix.rates.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.rates.vo.RatesAvgVo;
import com.jhta.netflix.rates.vo.RatesVo;

@Repository
public class RatesDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.RatesMapper";
	
	public int insert(RatesVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(RatesVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public int relDelete(int num) {
		return sqlSession.delete(NAMESPACE+".relDelete", num);
	}
	public List<RatesVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public RatesVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
	public RatesVo findRecord(RatesVo vo) {
		return sqlSession.selectOne(NAMESPACE+".findRecord", vo);
	}
	public RatesAvgVo getAvg(int num) {
		return sqlSession.selectOne(NAMESPACE+".getAvg", num);
	}
}

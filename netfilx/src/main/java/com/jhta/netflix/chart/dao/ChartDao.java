package com.jhta.netflix.chart.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.chart.vo.GnameCountVo;

@Repository
public class ChartDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.ChartMapper";
	
	//이번달 순이익
	public int thisMonthTotal() {
		return sqlSession.selectOne(NAMESPACE + ".thisMonthTotal");
	}
	
	//지난달 순이익
	public int nextMonthTotal(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".nextMonthTotal",map);
	}
	
	//이번달 멤버십 결제 총액
	public int mPayThisMonthSum() {
		return sqlSession.selectOne(NAMESPACE + ".mPayThisMonthSum");
	}
	
	//지난달 멤버십 결제 총액
	public int mPayNextMonthSum(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".mPayNextMonthSum", map);
	}
	
	//이번달 포인트 충전
	public int pointThisMonthPay() {
		return sqlSession.selectOne(NAMESPACE + ".pointThisMonthPay");
	}
	
	//지난달 포인트 충전
	public int pointNextMonthPay(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".pointNextMonthPay", map);
	}
	
	//이번달 포인트로 멤버십 결제
	public int pointMemThisMonthSum() {
		return sqlSession.selectOne(NAMESPACE + ".pointMemThisMonthSum");
	}
	
	//지난달 포인트로 멤버십 결제
	public int pointMemNextMonthSum(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".pointMemNextMonthSum", map);
	}
	
	public List<GnameCountVo> gradeThisNameCount(){
		return sqlSession.selectList(NAMESPACE + ".gradeThisNameCount");
	}
	
	public List<GnameCountVo> gradeNextNameCount(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".gradeNextNameCount", map);
	}
	
}

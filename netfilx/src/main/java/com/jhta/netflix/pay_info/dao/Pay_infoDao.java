package com.jhta.netflix.pay_info.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.pay_info.vo.Pay_gradeVo;
import com.jhta.netflix.pay_info.vo.Pay_infoVo;

@Repository
public class Pay_infoDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.Pay_infoMapper";
	
	public int insert(Pay_infoVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	public List<Pay_infoVo> list(){
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	
	public List<Pay_gradeVo> userselect(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".userselect",map);
	}
	
	public int listCount(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".listCount",map);
	}
	
	public Pay_infoVo selectone(int num) {
		return sqlSession.selectOne(NAMESPACE + ".selectone", num);
	}
	
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete",num);
	}
	
	public int userGradeUp(HashMap<String, Object> map) {
		return sqlSession.update(NAMESPACE + ".userGradeUp", map);
	}
}

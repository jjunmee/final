package com.jhta.netflix.pay_info.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public Pay_infoVo selectone(int num) {
		return sqlSession.selectOne(NAMESPACE + ".selectone", num);
	}
	
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete",num);
	}
}

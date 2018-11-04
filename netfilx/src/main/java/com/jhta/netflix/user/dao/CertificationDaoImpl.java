package com.jhta.netflix.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.user.vo.CertificationVo;

@Repository
public class CertificationDaoImpl implements CertificationDao{
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.CertificationMapper";
	@Override
	public int maxNo() {
		return sqlSession.selectOne(NAMESPACE+".maxno");
	}
	@Override
	public String getInfo(int no) {
		return sqlSession.selectOne(NAMESPACE+".getInfo",no);
	}
	@Override
	public int insert(CertificationVo vo) {
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}
	
}

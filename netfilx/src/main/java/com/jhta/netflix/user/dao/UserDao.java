package com.jhta.netflix.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.user.vo.UserVo;

@Repository
public class UserDao {
	@Autowired private SqlSession sqlSession;
	private final static String NAMESPACE="mapper.UserMapper";	
	
	public int login(UserVo vo) {
		return sqlSession.selectOne(NAMESPACE+".login",vo);
	}

}

package com.jhta.netflix.profile.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.profile.vo.ProfileVo;

@Repository
public class ProfileDaoImpl implements ProfileDao{
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.ProfileMapper";
	@Override
	public int insert(ProfileVo vo) {
		// TODO Auto-generated method stub
		return 0;
	}
}

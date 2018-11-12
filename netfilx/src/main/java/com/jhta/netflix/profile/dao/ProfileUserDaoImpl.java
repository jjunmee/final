package com.jhta.netflix.profile.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.profile.vo.ProfileUserListVo;

@Repository
public class ProfileUserDaoImpl implements ProfileUserDao{
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.ProfileUserMapper";
	@Override
	public List<ProfileUserListVo> userProfileList(String id) {
		return sqlSession.selectList(NAMESPACE+".userProfileList", id);
	}
	@Override
	public int userProfileInsert(HashMap<String, Object> map) {
		return sqlSession.insert(NAMESPACE+".userProfileInsert", map);
	}
}

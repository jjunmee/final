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
	@Override
	public ProfileUserListVo userProfileInfo(HashMap<String, Object>map) {
		return sqlSession.selectOne(NAMESPACE+".getInfo", map);
	}
	@Override
	public List<ProfileUserListVo> userProfileList(HashMap<String, Object> map) {
		return sqlSession.selectList(NAMESPACE+".profileList", map);
	}
	@Override
	public ProfileUserListVo profileInfo(int profile_num) {
		return sqlSession.selectOne(NAMESPACE+".profileInfo", profile_num);
	}
	
}

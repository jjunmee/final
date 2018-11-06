package com.jhta.netflix.profile.dao;

import java.util.List;

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
	public int groupInsert(ProfileVo vo) {
		return sqlSession.insert(NAMESPACE+".groupInsert",vo);
	}
	@Override
	public int groupDel(int no) {
		return sqlSession.delete(NAMESPACE+".groupDel",no);
	}
	@Override
	public List<ProfileVo> groupList() {
		return sqlSession.selectList(NAMESPACE+".groupList");
	}
	@Override
	public int proImgInsert(ProfileVo vo) {
		return sqlSession.insert(NAMESPACE+".proImgInsert",vo);
	}
	@Override
	public int proImgDel(int no) {
		return sqlSession.delete(NAMESPACE+".proImgDel",no);
	}
	@Override
	public List<ProfileVo> proImgList(int no) {
		return sqlSession.selectList(NAMESPACE+".proImgList", no);
	}
}

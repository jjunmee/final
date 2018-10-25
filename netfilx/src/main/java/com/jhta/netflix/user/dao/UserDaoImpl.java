package com.jhta.netflix.user.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.UserMapper";
	@Override
	public int delete(int users_num) {
		return sqlSession.delete(NAMESPACE + ".delete",users_num);
	}
	@Override
	public int update(UserVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	@Override
	public List<UserVo> info(int users_num){
		return sqlSession.selectOne(NAMESPACE + ".info",users_num);
	}
	@Override
	public int login(UserVo vo) {
		return sqlSession.selectOne(NAMESPACE + ".login",vo);
	}
	@Override
	public int defaultJoin(UserVo vo) {
		return sqlSession.insert(NAMESPACE + ".defaultJoin",vo);
	}
	public int id_check(String id) {
		return sqlSession.selectOne(NAMESPACE + ".id_check",id);
	}
}

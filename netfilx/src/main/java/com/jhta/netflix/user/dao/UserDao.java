package com.jhta.netflix.user.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.user.vo.UserVo;

@Repository
public class UserDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.UserMapper";
	
	public int delete(int users_num) {
		return sqlSession.delete(NAMESPACE + ".delete",users_num);
	}
	public int update(UserVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	public List<UserVo> info(int users_num){
		return sqlSession.selectOne(NAMESPACE + ".info",users_num);
	}
}

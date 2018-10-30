package com.jhta.netflix.content_staff.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.content_staff.vo.Content_staffVo;
import com.jhta.netflix.staff.vo.StaffVo;

@Repository
public class Content_staffDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.Content_staffMapper";
	
	public int insert(Content_staffVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(Content_staffVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public List<Content_staffVo> list(int num){
		return sqlSession.selectList(NAMESPACE+".list", num);
	}
	public Content_staffVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
	public List<StaffVo> staffList(int num) {
		return sqlSession.selectList(NAMESPACE+".staffList", num);
	}
	
}

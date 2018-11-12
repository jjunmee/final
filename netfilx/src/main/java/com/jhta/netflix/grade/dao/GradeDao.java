package com.jhta.netflix.grade.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.grade.vo.GradeVo;

@Repository
public class GradeDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.GradeMapper";
	
	public int insert(GradeVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	public List<GradeVo> list(){
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	
	public GradeVo selectone(int num) {
		return sqlSession.selectOne(NAMESPACE + ".selectone", num);
	}
	
	public int update(GradeVo vo) {
		return sqlSession.update(NAMESPACE + ".update", vo);
	}
	
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete", num);
	}
}

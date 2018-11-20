package com.jhta.netflix.record.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.record.vo.RecordVo;

@Repository
public class RecordDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.RecordMapper";
	
	public int insert(RecordVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(RecordVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public int relDelete(int num) {
		return sqlSession.delete(NAMESPACE+".relDelete", num);
	}
	public List<RecordVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public RecordVo find(RecordVo vo) {
		return sqlSession.selectOne(NAMESPACE+".find", vo);
	}
}

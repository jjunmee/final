package com.jhta.netflix.interasts.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.interasts.vo.InterastsContentVo;
import com.jhta.netflix.interasts.vo.InterastsVo;

@Repository
public class InterastsDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.InterastsMapper";
	
	public int insert(InterastsVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(InterastsVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public int relDelete(int num) {
		return sqlSession.delete(NAMESPACE+".relDelete", num);
	}
	public List<InterastsVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public InterastsVo find(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE+".find", map);
	}
	public int count(int num) {
		return sqlSession.selectOne(NAMESPACE+".count", num);
	}
	public int interastsCount(int num) {
		return sqlSession.selectOne(NAMESPACE + ".interastsCount", num);
	}
	public List<InterastsContentVo> interastslist(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".interastslist", map);
	}
}

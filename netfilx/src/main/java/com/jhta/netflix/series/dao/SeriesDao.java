package com.jhta.netflix.series.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.series.vo.SeriesVo;

@Repository
public class SeriesDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.SeriesMapper";
	
	public int insert(SeriesVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	public int update(SeriesVo vo) {
		return sqlSession.update(NAMESPACE + ".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete", num);
	}
	public List<SeriesVo> list(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".list", map);
	}
	public SeriesVo find(int num) {
		return sqlSession.selectOne(NAMESPACE + ".find", num);
	}
	public int count(String keyword) {
		return sqlSession.selectOne(NAMESPACE+".count", keyword);
	}
}

package com.jhta.netflix.series.dao;

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
	public List<SeriesVo> list(String name){
		return sqlSession.selectList(NAMESPACE + ".list", name);
	}
	public SeriesVo find(int num) {
		return sqlSession.selectOne(NAMESPACE + ".find", num);
	}
}

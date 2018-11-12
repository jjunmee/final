package com.jhta.netflix.point_info.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.point_info.vo.User_pointVo;

@Repository
public class Point_infoDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.Point_infoMapper";
	
	public int insert(Point_infoVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	public List<Point_infoVo> list(){
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	
	public Point_infoVo selectone(int num) {
		return sqlSession.selectOne(NAMESPACE + ".selectone", num);
	}
	
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete", num);
	}
	
	public List<User_pointVo> userpoint(int num) {
		return sqlSession.selectList(NAMESPACE + ".userpoint",num);
	}
	
	public int listCount(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".listCount",map);
	}
}

package com.jhta.netflix.staff.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.staff.vo.StaffVo;

@Repository
public class StaffDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.StaffMapper";
	
	public int insert(StaffVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(StaffVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete",num);
	}
	public List<StaffVo> list(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE+".list", map);
	}
	public int listCount(String keyword) {
		int n = sqlSession.selectOne(NAMESPACE+".listCount", keyword);
		System.out.println(n);
		return n;
	}
}

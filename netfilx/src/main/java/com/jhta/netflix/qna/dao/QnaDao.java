package com.jhta.netflix.qna.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.qna.vo.QnaVo;
import com.jhta.netflix.qna_user.vo.Qna_userVo;

@Repository
public class QnaDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.QnaMapper";
	
	public int insert(QnaVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	public List<Qna_userVo> list(HashMap<String, Object> map) {
		return sqlSession.selectList(NAMESPACE + ".list",map);
	}
	public int listCount(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".listCount",map);
	}
	public Qna_userVo detail(int num) {
		return sqlSession.selectOne(NAMESPACE + ".detail",num);
	}
	public Qna_userVo a_detail(int num) {
		return sqlSession.selectOne(NAMESPACE + ".a_detail",num);
	}
	public int update(QnaVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	public int update(HashMap<String, Object> map) {
		return sqlSession.update(NAMESPACE + ".s_update",map);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete",num);
	}
	public int a_delete(int num) {
		return sqlSession.delete(NAMESPACE + ".a_delete",num);
	}
	public int maxnum() {
		return sqlSession.selectOne(NAMESPACE + ".maxnum");
	}
}

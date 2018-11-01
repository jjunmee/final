package com.jhta.netflix.qna.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.qna.vo.QnaVo;

@Repository
public class QnaDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE="mapper.QnaMapper";
	
	public int insert(QnaVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	public List<QnaVo> list() {
		return sqlSession.selectList(NAMESPACE + ".list");
	}
	public QnaVo detail(int num) {
		return sqlSession.selectOne(NAMESPACE + ".detail",num);
	}
	public int update(QnaVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete",num);
	}
	public int maxnum() {
		return sqlSession.selectOne(NAMESPACE + ".maxnum");
	}
}

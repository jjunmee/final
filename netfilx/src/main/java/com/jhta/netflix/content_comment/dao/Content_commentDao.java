package com.jhta.netflix.content_comment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.content_comment.vo.Content_commentVo;

@Repository
public class Content_commentDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.Content_commentMapper";
	
	public int insert(Content_commentVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int update(Content_commentVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public List<Content_commentVo> list(int num){
		return sqlSession.selectList(NAMESPACE+".list", num);
	}
	public Content_commentVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
}

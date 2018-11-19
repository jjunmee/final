package com.jhta.netflix.content_comment.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.content_comment.vo.Comment_bookmarkVo;
import com.jhta.netflix.content_comment.vo.Content_commentVo;
import com.jhta.netflix.content_comment.vo.Mypage_commentVo;

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
	public List<Comment_bookmarkVo> list(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE+".list", map);
	}
	public Content_commentVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
	public int count(int num) {
		return sqlSession.selectOne(NAMESPACE+".count", num);
	}
	public int getMax() {
		return sqlSession.selectOne(NAMESPACE+".getMax");
	}
	public List<Content_commentVo> subList(int num){
		return sqlSession.selectList(NAMESPACE+".subList", num);
	}
	public List<Mypage_commentVo> userCoList(HashMap<String, Object> map){
		return sqlSession.selectList(NAMESPACE + ".userCoList", map);
	}
	public int userCoCount(HashMap<String, Object> map) {
		return sqlSession.selectOne(NAMESPACE + ".userCoCount", map);
	}
}

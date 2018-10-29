package com.jhta.netflix.content_genre.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.content_genre.vo.Content_genreVo;

@Repository
public class Content_genreDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.Content_genreMapper";
	
	public int insert(Content_genreVo vo) {
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}
	public int update(Content_genreVo vo) {
		return sqlSession.update(NAMESPACE+".update", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public List<Content_genreVo> list(){
		return sqlSession.selectList(NAMESPACE+".list");
	}
	public Content_genreVo find(int num) {
		return sqlSession.selectOne(NAMESPACE+".find", num);
	}
}

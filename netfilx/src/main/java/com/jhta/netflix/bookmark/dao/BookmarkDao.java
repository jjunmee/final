package com.jhta.netflix.bookmark.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.bookmark.vo.BookmarkVo;

@Repository
public class BookmarkDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.BookmarkMapper";
	
	public int insert(BookmarkVo vo) {
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE+".delete", num);
	}
	public int relDelete(int num) {
		return sqlSession.delete(NAMESPACE+".relDelete", num);
	}
	public BookmarkVo timeSelec(int num) {
		return sqlSession.selectOne(NAMESPACE + ".timeSelec",num);
	}
}

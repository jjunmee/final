package com.jhta.netflix.genre.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.genre.vo.GenreVo;

@Repository
public class GenreDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="mapper.GenreMapper";
	
	public int insert(GenreVo vo) {
		return sqlSession.insert(NAMESPACE + ".insert",vo);
	}
	public int update(GenreVo vo) {
		return sqlSession.update(NAMESPACE + ".update",vo);
	}
	public int delete(int num) {
		return sqlSession.delete(NAMESPACE + ".delete", num);
	}
	public List<GenreVo> list(int num){
		return sqlSession.selectList(NAMESPACE + ".list",num);
	}
	public List<GenreVo> list(){
		return sqlSession.selectList(NAMESPACE + ".clist");
	}

}

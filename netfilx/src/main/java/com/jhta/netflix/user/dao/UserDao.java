package com.jhta.netflix.user.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.user.vo.UserVo;


public interface UserDao {
	public int delete(int users_num);
	public int update(UserVo vo);
	public List<UserVo> info(int users_num);
	public int login(UserVo vo);
	public int defaultJoin(UserVo vo);
	public int id_check(String id);
}
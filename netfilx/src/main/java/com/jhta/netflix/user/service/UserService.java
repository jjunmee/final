package com.jhta.netflix.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.user.dao.UserDao;
import com.jhta.netflix.user.vo.UserVo;

@Service
public class UserService {
	@Autowired
	private UserDao dao;
	
	public int update(UserVo vo) {
		return dao.update(vo);
	}
	public int delete(int users_num) {
		return dao.delete(users_num);
	}
	public List<UserVo> info(int users_num){
		return dao.info(users_num);
	}
}

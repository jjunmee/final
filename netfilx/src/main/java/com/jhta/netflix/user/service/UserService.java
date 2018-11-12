package com.jhta.netflix.user.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.user.dao.UserDaoImpl;
import com.jhta.netflix.user.vo.UserVo;

@Service
public class UserService {
	@Autowired
	private UserDaoImpl dao;
	
	public int update(UserVo vo) {
		return dao.update(vo);
	}
	public int delete(int users_num) {
		return dao.delete(users_num);
	}
	public UserVo login(String id){
		return dao.login(id);
	}
	
	public int defaultJoin(UserVo vo) {
		return dao.defaultJoin(vo);
	}
	public int id_check(String id) {
		return dao.id_check(id);
	}
	public int pointUpdate(HashMap<String, Object> map) {
		return dao.pointUpdate(map);
	}
	public UserVo userInfo(String id){
		return dao.userInfo(id);
	}
}
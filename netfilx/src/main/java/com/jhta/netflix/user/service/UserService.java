package com.jhta.netflix.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.user.dao.UserDao;
import com.jhta.netflix.user.vo.UserVo;

@Service
public class UserService {
	@Autowired
	private UserDao dao;
	
	public int login(UserVo vo) {
		return dao.login(vo);
	}
}

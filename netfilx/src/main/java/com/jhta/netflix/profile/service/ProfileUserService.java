package com.jhta.netflix.profile.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.profile.dao.ProfileUserDaoImpl;
import com.jhta.netflix.profile.vo.ProfileUserListVo;

@Service
public class ProfileUserService {
	@Autowired private ProfileUserDaoImpl dao;
	
	public List<ProfileUserListVo> userProfileList(String id) {
		return dao.userProfileList(id);
	}
	public int userProfileInsert(HashMap<String, Object> map) {
		return dao.userProfileInsert(map);
	}
	public ProfileUserListVo userProfileInfo(int no) {
		return dao.userProfileInfo(no);
	}
}

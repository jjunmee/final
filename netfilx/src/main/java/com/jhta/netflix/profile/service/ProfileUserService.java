package com.jhta.netflix.profile.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.profile.dao.ProfileUserDaoImpl;
import com.jhta.netflix.profile.vo.ProfileUserListVo;
import com.jhta.netflix.profile.vo.ProfileUserVo;

@Service
public class ProfileUserService {
	@Autowired private ProfileUserDaoImpl dao;
	
	public List<ProfileUserListVo> userProfileList(String id) {
		return dao.userProfileList(id);
	}
	public int userProfileInsert(HashMap<String, Object> map) {
		return dao.userProfileInsert(map);
	}
	public ProfileUserListVo userProfileInfo(HashMap<String,Object>map) {
		return dao.userProfileInfo(map);
	}
	public ProfileUserListVo profileInfo(int profile_num) {
		return dao.profileInfo(profile_num);
	}
	public List<ProfileUserListVo> userProfileList(HashMap<String, Object> map) {
		return dao.userProfileList(map);
	}
	public int userProfileManagersDelete(int profile_num) {
		return dao.userProfileManagersDelete(profile_num);
	}
	public int userProfileManagersUpdate(ProfileUserVo vo) {
		return dao.userProfileManagersUpdate(vo);
	}
}

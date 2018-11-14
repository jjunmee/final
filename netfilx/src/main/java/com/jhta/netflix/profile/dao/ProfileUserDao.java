package com.jhta.netflix.profile.dao;

import java.util.HashMap;
import java.util.List;

import com.jhta.netflix.profile.vo.ProfileUserListVo;

public interface ProfileUserDao {
	public List<ProfileUserListVo> userProfileList(String id);
	public int userProfileInsert (HashMap<String, Object> map);
	public ProfileUserListVo userProfileInfo(int no);
	public List<ProfileUserListVo> userProfileList(HashMap<String, Object> map);
}

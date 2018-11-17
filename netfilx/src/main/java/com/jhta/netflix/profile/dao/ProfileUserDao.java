package com.jhta.netflix.profile.dao;

import java.util.HashMap;
import java.util.List;

import com.jhta.netflix.profile.vo.ProfileUserListVo;
import com.jhta.netflix.profile.vo.ProfileUserVo;

public interface ProfileUserDao {
	public List<ProfileUserListVo> userProfileList(String id);
	public int userProfileInsert (HashMap<String, Object> map);
	public ProfileUserListVo userProfileInfo(HashMap<String, Object> map);
	public ProfileUserListVo profileInfo(int profile_num);
	public List<ProfileUserListVo> userProfileList(HashMap<String, Object> map);
	public int userProfileManagersDelete(int profile_num);
	public int userProfileManagersUpdate(ProfileUserVo vo);
}

package com.jhta.netflix.user.dao;

import java.util.HashMap;
import java.util.List;

import com.jhta.netflix.user.vo.Admin_userVo;
import com.jhta.netflix.user.vo.UserVo;


public interface UserDao {
	public int delete(int users_num);
	public int update(UserVo vo);
	public UserVo login(String id);
	public int defaultJoin(UserVo vo);
	public int id_check(String id);
	public int pointUpdate(HashMap<String, Object> map);
	public UserVo userInfo(String id);
	public List<Admin_userVo> userlist(HashMap<String, Object> map);
	public int userCount(HashMap<String, Object> map);
	public int userStsUp(HashMap<String, Object> map);
}
package com.jhta.netflix.profile.dao;

import java.util.List;

import com.jhta.netflix.profile.vo.ProfileVo;

public interface ProfileDao {
	//profile group
	public int groupInsert(ProfileVo vo);
	public int groupDel(int no);
	public List<ProfileVo> groupList();
	
	//profile img
	public int proImgInsert(ProfileVo vo);
	public int proImgDel(int no);
	public List<ProfileVo> proImgList(int no);
}

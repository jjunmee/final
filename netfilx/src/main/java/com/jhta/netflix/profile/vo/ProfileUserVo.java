package com.jhta.netflix.profile.vo;

import java.sql.Date;

public class ProfileUserVo {
	private int profile_num;
	private String nickname;
	private int users_num;
	private int pimg_num;
	private int profile_age;
	private String profile_pwd;
	private boolean profile_first;
	private Date profile_regdate;
	public ProfileUserVo() {
	}
	public ProfileUserVo(int profile_num, String nickname, int users_num, int pimg_num, int profile_age,
			String profile_pwd, boolean profile_first, Date profile_regdate) {
		this.profile_num = profile_num;
		this.nickname = nickname;
		this.users_num = users_num;
		this.pimg_num = pimg_num;
		this.profile_age = profile_age;
		this.profile_pwd = profile_pwd;
		this.profile_first = profile_first;
		this.profile_regdate = profile_regdate;
	}
	public int getProfile_num() {
		return profile_num;
	}
	public void setProfile_num(int profile_num) {
		this.profile_num = profile_num;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getUsers_num() {
		return users_num;
	}
	public void setUsers_num(int users_num) {
		this.users_num = users_num;
	}
	public int getPimg_num() {
		return pimg_num;
	}
	public void setPimg_num(int pimg_num) {
		this.pimg_num = pimg_num;
	}
	public int getProfile_age() {
		return profile_age;
	}
	public void setProfile_age(int profile_age) {
		this.profile_age = profile_age;
	}
	public String getProfile_pwd() {
		return profile_pwd;
	}
	public void setProfile_pwd(String profile_pwd) {
		this.profile_pwd = profile_pwd;
	}
	public boolean isProfile_first() {
		return profile_first;
	}
	public void setProfile_first(boolean profile_first) {
		this.profile_first = profile_first;
	}
	public Date getProfile_regdate() {
		return profile_regdate;
	}
	public void setProfile_regdate(Date profile_regdate) {
		this.profile_regdate = profile_regdate;
	}
	
	
}

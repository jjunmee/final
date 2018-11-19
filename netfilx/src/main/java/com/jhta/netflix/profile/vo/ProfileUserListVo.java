package com.jhta.netflix.profile.vo;

import java.util.Date;

public class ProfileUserListVo {
	private int users_num;
	private int profile_num;
	private String nickname;
	private int pimg_num;
	private int proifle_age;
	private int sts;
	private boolean profile_first;
	private String pimg_src;
	private Date profile_regdate;
	
	public ProfileUserListVo() {}

	public ProfileUserListVo(int users_num, int profile_num,int pimg_num, String nickname, int proifle_age, int sts,
			boolean profile_first, String pimg_src) {
		super();
		this.users_num = users_num;
		this.profile_num = profile_num;
		this.setPimg_num(pimg_num);
		this.nickname = nickname;
		this.proifle_age = proifle_age;
		this.sts = sts;
		this.profile_first = profile_first;
		this.pimg_src = pimg_src;
	}

	public int getUsers_num() {
		return users_num;
	}

	public void setUsers_num(int users_num) {
		this.users_num = users_num;
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

	public int getProifle_age() {
		return proifle_age;
	}

	public void setProifle_age(int proifle_age) {
		this.proifle_age = proifle_age;
	}

	public int getSts() {
		return sts;
	}

	public void setSts(int sts) {
		this.sts = sts;
	}

	public boolean isProfile_first() {
		return profile_first;
	}

	public void setProfile_first(boolean profile_first) {
		this.profile_first = profile_first;
	}

	public String getPimg_src() {
		return pimg_src;
	}

	public void setPimg_src(String pimg_src) {
		this.pimg_src = pimg_src;
	}

	public Date getProfile_regdate() {
		return profile_regdate;
	}

	public void setProfile_regdate(Date profile_regdate) {
		this.profile_regdate = profile_regdate;
	}

	public int getPimg_num() {
		return pimg_num;
	}

	public void setPimg_num(int pimg_num) {
		this.pimg_num = pimg_num;
	}
	
	
	
}

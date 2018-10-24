package com.jhta.netflix.user.vo;

import java.util.Date;

public class UserVo {
	private int users_num;
	private String id;
	private String pwd;
	private Date birth;
	private int point;
	private int user_sts;
	public UserVo() {}

	public UserVo(int users_num, String id, String pwd, Date birth, int point, int user_sts) {
		this.users_num = users_num;
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.point = point;
		this.setUser_sts(user_sts);
	}

	public int getUsers_num() {
		return users_num;
	}

	public void setUsers_num(int users_num) {
		this.users_num = users_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getUser_sts() {
		return user_sts;
	}

	public void setUser_sts(int user_sts) {
		this.user_sts = user_sts;
	}
}

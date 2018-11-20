package com.jhta.netflix.user.vo;

import java.util.Date;

public class Admin_userVo {
    private int users_num;
    private String id;
    private String pwd;
    private Date birth;
    private int point;
    private int sts;
    private String pwd2;
    private int grade_num;
    private String grade_name;
    private String grade_price;
    
    public Admin_userVo() {}

	public Admin_userVo(int users_num, String id, String pwd, Date birth, int point, int sts, String pwd2,
			int grade_num, String grade_name, String grade_price) {
		super();
		this.users_num = users_num;
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.point = point;
		this.sts = sts;
		this.pwd2 = pwd2;
		this.grade_num = grade_num;
		this.grade_name = grade_name;
		this.grade_price = grade_price;
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

	public int getSts() {
		return sts;
	}

	public void setSts(int sts) {
		this.sts = sts;
	}

	public String getPwd2() {
		return pwd2;
	}

	public void setPwd2(String pwd2) {
		this.pwd2 = pwd2;
	}

	public int getGrade_num() {
		return grade_num;
	}

	public void setGrade_num(int grade_num) {
		this.grade_num = grade_num;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}

	public String getGrade_price() {
		return grade_price;
	}

	public void setGrade_price(String grade_price) {
		this.grade_price = grade_price;
	}
    
}

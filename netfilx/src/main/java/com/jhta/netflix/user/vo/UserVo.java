package com.jhta.netflix.user.vo;

import java.util.Date;

public class UserVo {
	// 유저번호 
    private int users_num;
    // 아이디 
    private String id;

    // 비밀번호 
    private String pwd;

    // 주민등록번호 
    private Date birth;

    // 포인트 
    private int point;
    //상태
    private int sts;
    //solt
    private String pwd2;
    public UserVo() {}

    public UserVo(int users_num, String id, String pwd, Date birth, int point,int sts,String pwd2) {
		this.users_num = users_num;
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.point = point;
		this.sts = sts;
		this.pwd2 = pwd2;
	}

	public int getUsersNum() {
        return users_num;
    }

    public void setUsersNum(int users_num) {
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

}

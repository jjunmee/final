package com.jhta.netflix.user.vo;

public class UserVo {
	// 유저번호 
    private Integer users_num;

    // 아이디 
    private String id;

    // 비밀번호 
    private String pwd;

    // 주민등록번호 
    private Integer birth;

    // 포인트 
    private Integer point;
    
    public UserVo() {}

    public UserVo(Integer users_num, String id, String pwd, Integer birth, Integer point) {
		super();
		this.users_num = users_num;
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.point = point;
	}

	public Integer getUsersNum() {
        return users_num;
    }

    public void setUsersNum(Integer users_num) {
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

    public Integer getBirth() {
        return birth;
    }

    public void setBirth(Integer birth) {
        this.birth = birth;
    }

    public Integer getPoint() {
        return point;
    }

    public void setPoint(Integer point) {
        this.point = point;
    }

}

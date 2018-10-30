package com.jhta.netflix.user.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginVo {
	@NotEmpty(message="아이디를 입력하세요")
	private String id;
	@NotEmpty(message="비밀번호를 입력하세요")
	private String pwd;
	
	public LoginVo() {}
	public LoginVo(String id,String pwd) {
		this.id=id;
		this.pwd=pwd;
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
	
}

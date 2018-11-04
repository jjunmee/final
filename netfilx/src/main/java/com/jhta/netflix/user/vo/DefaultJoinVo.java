package com.jhta.netflix.user.vo;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class DefaultJoinVo {
	@NotEmpty(message="아이디를 입력하세요")
	private String id;
	@NotEmpty(message="비밀번호를 입력하세요")
	@Length(min=8,max=32,message="8자 이상 대소문자,숫자,특수문자가 포함 되어야 합니다.")
	private String pwd;
	@NotEmpty(message="생년월일을 입력하세요")
	private String birth;
	@NotEmpty(message="비밀번호 확인을 입력하세요")
	private String pwd2;
	@NotEmpty(message="인증번호를 입력하세요")
	private String passCheck;
	private String email_boolean;
	public DefaultJoinVo() {}
	public DefaultJoinVo(String id, String pwd, String birth, String pwd2,String passCheck,String email_boolean) {
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.pwd2 = pwd2;
		this.passCheck=passCheck;
		this.email_boolean = email_boolean;
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
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getPwd2() {
		return pwd2;
	}
	public void setPwd2(String pwd2) {
		this.pwd2 = pwd2;
	}
	public String getPassCheck() {
		return passCheck;
	}
	public void setPassCheck(String passCheck) {
		this.passCheck = passCheck;
	}
	public String getEmail_boolean() {
		return email_boolean;
	}
	public void setEmail_boolean(String email_boolean) {
		this.email_boolean = email_boolean;
	}
	
}

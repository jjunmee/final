package com.jhta.netflix.user.vo;

import java.util.Date;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class DefaultJoinVo {
	@NotEmpty(message="아이디를 입력하세요")
	private String id;
	@NotEmpty(message="비밀번호를 입력하세요")
	@Length(min=8,max=32,message="8자 이상 대소문자")
	private String pwd;
	@NotEmpty(message="생년월일을 입력하세요")
	
	private Date birth;
	private String pwd2;
	public DefaultJoinVo() {}
	public DefaultJoinVo(String id, String pwd, Date birth, String pwd2) {
		this.id = id;
		this.pwd = pwd;
		this.birth = birth;
		this.pwd2 = pwd2;
	}
}

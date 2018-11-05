package com.jhta.netflix.user.vo;

public class CertificationVo {
	private int no;
	private String pass;
	public CertificationVo(int no, String pass) {
		this.no = no;
		this.pass = pass;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
}

package com.jhta.netflix.good.vo;

public class GoodVo {
	private int good_num;
	private int comment_num;
	private int profile_num;
	public GoodVo() {
	}
	public GoodVo(int good_num, int comment_num, int profile_num) {
		this.good_num = good_num;
		this.comment_num = comment_num;
		this.profile_num = profile_num;
	}
	public int getGood_num() {
		return good_num;
	}
	public void setGood_num(int good_num) {
		this.good_num = good_num;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getProfile_num() {
		return profile_num;
	}
	public void setProfile_num(int profile_num) {
		this.profile_num = profile_num;
	}
	
}

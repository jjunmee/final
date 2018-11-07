package com.jhta.netflix.interasts.vo;

public class InterastsVo {
	private int interasts_num;
	private int profile_num;
	private int content_num;
	public InterastsVo() {
	}
	public InterastsVo(int interasts_num, int profile_num, int content_num) {
		this.interasts_num = interasts_num;
		this.profile_num = profile_num;
		this.content_num = content_num;
	}
	public int getInterasts_num() {
		return interasts_num;
	}
	public void setInterasts_num(int interasts_num) {
		this.interasts_num = interasts_num;
	}
	public int getProfile_num() {
		return profile_num;
	}
	public void setProfile_num(int profile_num) {
		this.profile_num = profile_num;
	}
	public int getContent_num() {
		return content_num;
	}
	public void setContent_num(int content_num) {
		this.content_num = content_num;
	}
	
}

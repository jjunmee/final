package com.jhta.netflix.interasts.vo;

public class InterastsContentVo {
	private int interasts_num;
	private int profile_num;
	private int content_num;
	private String content_name;
	private String content_post2;
	
	public InterastsContentVo() {}

	public InterastsContentVo(int interasts_num, int profile_num, int content_num, String content_name,
			String content_post2) {
		super();
		this.interasts_num = interasts_num;
		this.profile_num = profile_num;
		this.content_num = content_num;
		this.content_name = content_name;
		this.content_post2 = content_post2;
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

	public String getContent_name() {
		return content_name;
	}

	public void setContent_name(String content_name) {
		this.content_name = content_name;
	}

	public String getContent_post2() {
		return content_post2;
	}

	public void setContent_post2(String content_post2) {
		this.content_post2 = content_post2;
	}
}

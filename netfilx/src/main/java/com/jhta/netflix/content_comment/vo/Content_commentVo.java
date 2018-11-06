package com.jhta.netflix.content_comment.vo;

public class Content_commentVo {
	private int comment_num;
	private String comment;
	private int c_lev;
	private int c_step;
	private int content_num;
	private int profile_num;
	private boolean comment_open;
	private boolean bookmark;
	
	public Content_commentVo() {
	}
	public Content_commentVo(int comment_num, String comment, int c_lev, int c_step, int content_num, int profile_num,
			boolean comment_open, boolean bookmark) {
		this.comment_num = comment_num;
		this.comment = comment;
		this.c_lev = c_lev;
		this.c_step = c_step;
		this.content_num = content_num;
		this.profile_num = profile_num;
		this.comment_open = comment_open;
		this.bookmark = bookmark;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getC_lev() {
		return c_lev;
	}
	public void setC_lev(int c_lev) {
		this.c_lev = c_lev;
	}
	public int getC_step() {
		return c_step;
	}
	public void setC_step(int c_step) {
		this.c_step = c_step;
	}
	public int getContent_num() {
		return content_num;
	}
	public void setContent_num(int content_num) {
		this.content_num = content_num;
	}
	public int getProfile_num() {
		return profile_num;
	}
	public void setProfile_num(int profile_num) {
		this.profile_num = profile_num;
	}
	public boolean isComment_open() {
		return comment_open;
	}
	public void setComment_open(boolean comment_open) {
		this.comment_open = comment_open;
	}
	public boolean isBookmark() {
		return bookmark;
	}
	public void setBookmark(boolean bookmark) {
		this.bookmark = bookmark;
	}
}

package com.jhta.netflix.bookmark.vo;

public class BookmarkVo {
	private int bookmark_num;
	private int comment_num;
	private int bookmark_time;
	public BookmarkVo() {
	}
	public BookmarkVo(int bookmark_num, int comment_num, int bookmark_time) {
		this.bookmark_num = bookmark_num;
		this.comment_num = comment_num;
		this.bookmark_time = bookmark_time;
	}
	public int getBookmark_num() {
		return bookmark_num;
	}
	public void setBookmark_num(int bookmark_num) {
		this.bookmark_num = bookmark_num;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getBookmark_time() {
		return bookmark_time;
	}
	public void setBookmark_time(int bookmark_time) {
		this.bookmark_time = bookmark_time;
	}
	
}

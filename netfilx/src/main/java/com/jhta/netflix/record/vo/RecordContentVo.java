package com.jhta.netflix.record.vo;

public class RecordContentVo {
	private int record_num;
	private int next_watch;
	private int total_time;
	private int profile_num;
	private int content_num;
	private String content_name;
	
	public RecordContentVo() {}
	public RecordContentVo(int record_num, int next_watch, int total_time, int profile_num, int content_num,
			String content_name) {
		super();
		this.record_num = record_num;
		this.next_watch = next_watch;
		this.total_time = total_time;
		this.profile_num = profile_num;
		this.content_num = content_num;
		this.content_name = content_name;
	}
	public int getRecord_num() {
		return record_num;
	}
	public void setRecord_num(int record_num) {
		this.record_num = record_num;
	}
	public int getNext_watch() {
		return next_watch;
	}
	public void setNext_watch(int next_watch) {
		this.next_watch = next_watch;
	}
	public int getTotal_time() {
		return total_time;
	}
	public void setTotal_time(int total_time) {
		this.total_time = total_time;
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
	
	
}

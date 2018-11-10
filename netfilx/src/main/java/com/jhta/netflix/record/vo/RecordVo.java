package com.jhta.netflix.record.vo;

import java.sql.Time;

public class RecordVo {
	private int record_num;
	private Time next_watch;
	private Time total_time;
	private int profile_num;
	private int content_num;
	public RecordVo() {
	}
	public RecordVo(int record_num, Time next_watch, Time total_time, int profile_num, int content_num) {
		this.record_num = record_num;
		this.next_watch = next_watch;
		this.total_time = total_time;
		this.profile_num = profile_num;
		this.content_num = content_num;
	}
	public int getRecord_num() {
		return record_num;
	}
	public void setRecord_num(int record_num) {
		this.record_num = record_num;
	}
	public Time getNext_watch() {
		return next_watch;
	}
	public void setNext_watch(Time next_watch) {
		this.next_watch = next_watch;
	}
	public Time getTotal_time() {
		return total_time;
	}
	public void setTotal_time(Time total_time) {
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
	
}

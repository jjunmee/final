package com.jhta.netflix.alarm.vo;

import java.util.Date;

public class Alarm {
	private int alarm_num;
	private String alarm_content;
	private Date alarm_date;
	private int content_num;
	private int au_num;
	private int alarm_state;
	private int profile_num;
	
	public Alarm() {}
	//전체 생성자
	public Alarm(int alarm_num, String alarm_content, Date alarm_date,int content_num, int au_num, int alarm_state, int profile_num) {
		super();
		this.alarm_num = alarm_num;
		this.alarm_content = alarm_content;
		this.alarm_date = alarm_date;
		this.setContent_num(content_num);
		this.au_num = au_num;
		this.alarm_state = alarm_state;
		this.profile_num = profile_num;
	}
	//알람
	public Alarm(int alarm_num, String alarm_content, Date alarm_date,int content_num) {
		this.alarm_num = alarm_num;
		this.alarm_content = alarm_content;
		this.alarm_date = alarm_date;
		this.content_num = content_num;
	}
	
	//유저알람
	public Alarm( int au_num,int alarm_num, int alarm_state, int profile_num) {
		this.alarm_num = alarm_num;
		this.au_num = au_num;
		this.alarm_state = alarm_state;
		this.profile_num = profile_num;
	}
	
	//유저가 사용할 생성자
	public Alarm(int alarm_num, String alarm_content, int au_num, int alarm_state, int profile_num) {
		this.alarm_num = alarm_num;
		this.alarm_content = alarm_content;
		this.au_num = au_num;
		this.alarm_state = alarm_state;
		this.profile_num = profile_num;
	}
	public int getAlarm_num() {
		return alarm_num;
	}
	public void setAlarm_num(int alarm_num) {
		this.alarm_num = alarm_num;
	}
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
	}
	public Date getAlarm_date() {
		return alarm_date;
	}
	public void setAlarm_date(Date alarm_date) {
		this.alarm_date = alarm_date;
	}
	public int getAu_num() {
		return au_num;
	}
	public void setAu_num(int au_num) {
		this.au_num = au_num;
	}
	public int getAlarm_state() {
		return alarm_state;
	}
	public void setAlarm_state(int alarm_state) {
		this.alarm_state = alarm_state;
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

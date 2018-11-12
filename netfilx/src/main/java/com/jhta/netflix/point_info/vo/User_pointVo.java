package com.jhta.netflix.point_info.vo;

import java.sql.Date;

public class User_pointVo {
	private int users_num;
	private int point_num;
	private Date point_date;
	private String usage;
	private String point_payment;
	private int point;
	
	public User_pointVo() {}
	public User_pointVo(int users_num, int point_num, Date point_date, String usage, String point_payment, int point) {
		super();
		this.users_num = users_num;
		this.point_num = point_num;
		this.point_date = point_date;
		this.usage = usage;
		this.point_payment = point_payment;
		this.point = point;
	}
	
	public int getUsers_num() {
		return users_num;
	}
	public void setUsers_num(int users_num) {
		this.users_num = users_num;
	}
	public int getPoint_num() {
		return point_num;
	}
	public void setPoint_num(int point_num) {
		this.point_num = point_num;
	}
	public Date getPoint_date() {
		return point_date;
	}
	public void setPoint_date(Date point_date) {
		this.point_date = point_date;
	}
	public String getUsage() {
		return usage;
	}
	public void setUsage(String usage) {
		this.usage = usage;
	}
	public String getPoint_payment() {
		return point_payment;
	}
	public void setPoint_payment(String point_payment) {
		this.point_payment = point_payment;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
}

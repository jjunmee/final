package com.jhta.netflix.point_info;

import java.sql.Date;

public class Point_infoVo {
	// 포인트번호 
    private Integer point_num;

    // 날짜 
    private Date point_date;

    // 사용내역 
    private String usage;

    // 결제방법 
    private String point_payment;

    // 유저번호 
    private Integer users_num;

    public Point_infoVo() {}
    
	public Point_infoVo(Integer point_num, Date point_date, String usage, String point_payment, Integer users_num) {
		super();
		this.point_num = point_num;
		this.point_date = point_date;
		this.usage = usage;
		this.point_payment = point_payment;
		this.users_num = users_num;
	}

	public Integer getPoint_num() {
		return point_num;
	}

	public void setPoint_num(Integer point_num) {
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

	public Integer getUsers_num() {
		return users_num;
	}

	public void setUsers_num(Integer users_num) {
		this.users_num = users_num;
	}
    
}

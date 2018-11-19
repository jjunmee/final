package com.jhta.netflix.pay_info.vo;

import java.sql.Date;

public class Pay_gradeVo {
	private Integer pay_num;
    private Date pay_start;
    private Date pay_end;
    private String payment;
    private Integer users_num;
    private Integer grade_num;
    private String grade_name;
    private String grade_price;
    
    public Pay_gradeVo() {}
    
	public Pay_gradeVo(Integer pay_num, Date pay_start, Date pay_end, String payment, Integer users_num,
			Integer grade_num, String grade_name, String grade_price) {
		super();
		this.pay_num = pay_num;
		this.pay_start = pay_start;
		this.pay_end = pay_end;
		this.payment = payment;
		this.users_num = users_num;
		this.grade_num = grade_num;
		this.grade_name = grade_name;
		this.grade_price = grade_price;
	}
	
	public Integer getPay_num() {
		return pay_num;
	}
	public void setPay_num(Integer pay_num) {
		this.pay_num = pay_num;
	}
	public Date getPay_start() {
		return pay_start;
	}
	public void setPay_start(Date pay_start) {
		this.pay_start = pay_start;
	}
	public Date getPay_end() {
		return pay_end;
	}
	public void setPay_end(Date pay_end) {
		this.pay_end = pay_end;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public Integer getUsers_num() {
		return users_num;
	}
	public void setUsers_num(Integer users_num) {
		this.users_num = users_num;
	}
	public Integer getGrade_num() {
		return grade_num;
	}
	public void setGrade_num(Integer grade_num) {
		this.grade_num = grade_num;
	}
	public String getGrade_name() {
		return grade_name;
	}
	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}
	public String getGrade_price() {
		return grade_price;
	}
	public void setGrade_price(String grade_price) {
		this.grade_price = grade_price;
	}
}

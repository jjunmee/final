package com.jhta.netflix.pay_info;

import java.sql.Date;

public class Pay_infoVo {
	// 결제번호 
    private Integer pay_num;

    // 시작일 
    private Date pay_start;

    // 만료일 
    private Date pay_end;

    // 결제방법 
    private String payment;

    // 유저번호 
    private Integer users_num;

    // 등급번호 
    private Integer grade_num;
    
    public Pay_infoVo() {}
    
	public Pay_infoVo(Integer pay_num, Date pay_start, Date pay_end, String payment, Integer users_num,
			Integer grade_num) {
		super();
		this.pay_num = pay_num;
		this.pay_start = pay_start;
		this.pay_end = pay_end;
		this.payment = payment;
		this.users_num = users_num;
		this.grade_num = grade_num;
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
    
}

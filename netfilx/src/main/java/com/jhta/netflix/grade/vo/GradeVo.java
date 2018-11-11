package com.jhta.netflix.grade.vo;

public class GradeVo {
	// 등급번호 
    private Integer grade_num;

    // 등급명 
    private String grade_name;

    // 등급가격 
    private String grade_price;

    public GradeVo() {}

	public GradeVo(Integer grade_num, String grade_name, String grade_price) {
		super();
		this.grade_num = grade_num;
		this.grade_name = grade_name;
		this.grade_price = grade_price;
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

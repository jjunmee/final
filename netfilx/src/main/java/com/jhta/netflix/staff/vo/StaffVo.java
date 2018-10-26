package com.jhta.netflix.staff.vo;

public class StaffVo {
    private Integer staff_num;
    private Boolean staff_position;
    private String staff_name;
    private Integer staff_age;
    private String staff_gender;
    private String staff_debut;
	public StaffVo() {
	}
	public StaffVo(Integer staff_num, Boolean staff_position, String staff_name, Integer staff_age, String staff_gender,
			String staff_debut) {
		this.staff_num = staff_num;
		this.staff_position = staff_position;
		this.staff_name = staff_name;
		this.staff_age = staff_age;
		this.staff_gender = staff_gender;
		this.staff_debut = staff_debut;
	}
	public Integer getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(Integer staff_num) {
		this.staff_num = staff_num;
	}
	public Boolean getStaff_position() {
		return staff_position;
	}
	public void setStaff_position(Boolean staff_position) {
		this.staff_position = staff_position;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public Integer getStaff_age() {
		return staff_age;
	}
	public void setStaff_age(Integer staff_age) {
		this.staff_age = staff_age;
	}
	public String getStaff_gender() {
		return staff_gender;
	}
	public void setStaff_gender(String staff_gender) {
		this.staff_gender = staff_gender;
	}
	public String getStaff_debut() {
		return staff_debut;
	}
	public void setStaff_debut(String staff_debut) {
		this.staff_debut = staff_debut;
	}
}

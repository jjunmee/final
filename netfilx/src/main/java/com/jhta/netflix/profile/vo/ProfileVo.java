package com.jhta.netflix.profile.vo;

public class ProfileVo {
	private int pro_group_no;
	private String pro_group_name;
	private int pimg_num;
	private String pimg_src;
	
	public ProfileVo() {}

	public ProfileVo(int pro_group_no, String pro_group_name) {
		this.pro_group_no = pro_group_no;
		this.pro_group_name = pro_group_name;
	}
	
	public ProfileVo(int pimg_num, int pro_group_no, String pimg_src) {
		this.pimg_num = pimg_num;
		this.pro_group_no = pro_group_no;
		this.pimg_src = pimg_src;
	}
	
	public ProfileVo(int pimg_num, String pro_group_name, String pimg_src) {
		this.pimg_num = pimg_num;
		this.pro_group_name = pro_group_name;
		this.pimg_src = pimg_src;
	}

	public int getPro_group_no() {
		return pro_group_no;
	}

	public void setPro_group_no(int pro_group_no) {
		this.pro_group_no = pro_group_no;
	}

	public String getPro_group_name() {
		return pro_group_name;
	}

	public void setPro_group_name(String pro_group_name) {
		this.pro_group_name = pro_group_name;
	}

	public int getPimg_num() {
		return pimg_num;
	}

	public void setPimg_num(int pimg_num) {
		this.pimg_num = pimg_num;
	}

	public String getPimg_src() {
		return pimg_src;
	}

	public void setPimg_src(String pimg_src) {
		this.pimg_src = pimg_src;
	}
	
	
	
	
	
}

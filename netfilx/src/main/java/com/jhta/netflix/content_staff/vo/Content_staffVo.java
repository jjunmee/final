package com.jhta.netflix.content_staff.vo;

public class Content_staffVo {
    private Integer cs_num;
    private Integer staff_num;
    private Integer content_num;
	public Content_staffVo() {
	}
	public Content_staffVo(Integer cs_num, Integer staff_num, Integer content_num) {
		this.cs_num = cs_num;
		this.staff_num = staff_num;
		this.content_num = content_num;
	}
	public Integer getCs_num() {
		return cs_num;
	}
	public void setCs_num(Integer cs_num) {
		this.cs_num = cs_num;
	}
	public Integer getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(Integer staff_num) {
		this.staff_num = staff_num;
	}
	public Integer getContent_num() {
		return content_num;
	}
	public void setContent_num(Integer content_num) {
		this.content_num = content_num;
	}
    
}

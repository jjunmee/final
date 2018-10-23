package com.jhta.netflix.category.vo;

public class CategoryVo {
    private Integer category_num;
    private String category_name;
    
    public CategoryVo() {}
    
	public CategoryVo(Integer category_num, String category_name) {
		super();
		this.category_num = category_num;
		this.category_name = category_name;
	}
	
	public Integer getCategory_num() {return category_num;}
	public void setCategory_num(Integer category_num) {this.category_num = category_num;}
	public String getCategory_name() {return category_name;}
	public void setCategory_name(String category_name) {this.category_name = category_name;}
}

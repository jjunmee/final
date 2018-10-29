package com.jhta.netflix.category.vo;

public class CateGenreVo {
	private Integer genre_num;
    private String genre_name;
    private Integer category_num;
    private String category_name;
    public CateGenreVo() {}
	public CateGenreVo(Integer genre_num, String genre_name, Integer category_num, String category_name) {
		super();
		this.genre_num = genre_num;
		this.genre_name = genre_name;
		this.category_num = category_num;
		this.category_name = category_name;
	}
	public Integer getGenre_num() {
		return genre_num;
	}
	public void setGenre_num(Integer genre_num) {
		this.genre_num = genre_num;
	}
	public String getGenre_name() {
		return genre_name;
	}
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	public Integer getCategory_num() {
		return category_num;
	}
	public void setCategory_num(Integer category_num) {
		this.category_num = category_num;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
    
}

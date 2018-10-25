package com.jhta.netflix.genre.vo;

public class GenreVo {
    private Integer genre_num;
    private String genre_name;
    private Integer category_num;
	public GenreVo() {
	}
	public GenreVo(Integer genre_num, String genre_name, Integer category_num) {
		this.genre_num = genre_num;
		this.genre_name = genre_name;
		this.category_num = category_num;
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
	
}

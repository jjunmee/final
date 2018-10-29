package com.jhta.netflix.content_genre.vo;

public class Content_genreVo {
    private Integer cgenre_num;
    private Integer content_num;
    private Integer genre_num;
	public Content_genreVo() {
	}
	public Content_genreVo(Integer cgenre_num, Integer content_num, Integer genre_num) {
		this.cgenre_num = cgenre_num;
		this.content_num = content_num;
		this.genre_num = genre_num;
	}
	public Integer getCgenre_num() {
		return cgenre_num;
	}
	public void setCgenre_num(Integer cgenre_num) {
		this.cgenre_num = cgenre_num;
	}
	public Integer getContent_num() {
		return content_num;
	}
	public void setContent_num(Integer content_num) {
		this.content_num = content_num;
	}
	public Integer getGenre_num() {
		return genre_num;
	}
	public void setGenre_num(Integer genre_num) {
		this.genre_num = genre_num;
	}
    
}

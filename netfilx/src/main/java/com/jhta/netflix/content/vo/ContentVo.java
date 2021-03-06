package com.jhta.netflix.content.vo;

import java.sql.Date;

public class ContentVo {
    private Integer content_num;
    private String content_name;
    private String orgsrc;
    private String savesrc;
    private String content_summary;
    private String trailer_orgsrc;
    private String trailer_savesrc;
    private long content_size;
    private long trailer_size;
    private String content_post1;
    private String content_post2;
    private Date release_date;
    private Integer watch_age;
    private Date content_regdate;
    private Integer series_num;
    
	public ContentVo() {
	}
	public ContentVo(Integer content_num, String content_name, String orgsrc, String savesrc, String content_summary,
			String trailer_orgsrc, String trailer_savesrc, long content_size, long trailer_size, String content_post1,
			String content_post2, Date release_date, Integer watch_age, Date content_regdate, Integer series_num) {
		this.content_num = content_num;
		this.content_name = content_name;
		this.orgsrc = orgsrc;
		this.savesrc = savesrc;
		this.content_summary = content_summary;
		this.trailer_orgsrc = trailer_orgsrc;
		this.trailer_savesrc = trailer_savesrc;
		this.content_size = content_size;
		this.trailer_size = trailer_size;
		this.content_post1 = content_post1;
		this.content_post2 = content_post2;
		this.release_date = release_date;
		this.watch_age = watch_age;
		this.content_regdate = content_regdate;
		this.series_num = series_num;
	}

	public Integer getContent_num() {
		return content_num;
	}

	public void setContent_num(Integer content_num) {
		this.content_num = content_num;
	}

	public String getContent_name() {
		return content_name;
	}

	public void setContent_name(String content_name) {
		this.content_name = content_name;
	}

	public String getOrgsrc() {
		return orgsrc;
	}

	public void setOrgsrc(String orgsrc) {
		this.orgsrc = orgsrc;
	}

	public String getSavesrc() {
		return savesrc;
	}

	public void setSavesrc(String savesrc) {
		this.savesrc = savesrc;
	}

	public String getContent_summary() {
		return content_summary;
	}

	public void setContent_summary(String content_summary) {
		this.content_summary = content_summary;
	}

	public String getTrailer_orgsrc() {
		return trailer_orgsrc;
	}

	public void setTrailer_orgsrc(String trailer_orgsrc) {
		this.trailer_orgsrc = trailer_orgsrc;
	}

	public String getTrailer_savesrc() {
		return trailer_savesrc;
	}

	public void setTrailer_savesrc(String trailer_savesrc) {
		this.trailer_savesrc = trailer_savesrc;
	}

	public long getContent_size() {
		return content_size;
	}

	public void setContent_size(long content_size) {
		this.content_size = content_size;
	}

	public long getTrailer_size() {
		return trailer_size;
	}

	public void setTrailer_size(long trailer_size) {
		this.trailer_size = trailer_size;
	}

	public String getContent_post1() {
		return content_post1;
	}

	public void setContent_post1(String content_post1) {
		this.content_post1 = content_post1;
	}

	public String getContent_post2() {
		return content_post2;
	}

	public void setContent_post2(String content_post2) {
		this.content_post2 = content_post2;
	}

	public Date getRelease_date() {
		return release_date;
	}

	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}

	public Integer getWatch_age() {
		return watch_age;
	}

	public void setWatch_age(Integer watch_age) {
		this.watch_age = watch_age;
	}

	public Date getContent_regdate() {
		return content_regdate;
	}

	public void setContent_regdate(Date content_regdate) {
		this.content_regdate = content_regdate;
	}

	public Integer getSeries_num() {
		return series_num;
	}

	public void setSeries_num(Integer series_num) {
		this.series_num = series_num;
	}
	
}

package com.jhta.netflix.content.vo;

import java.sql.Date;

public class ContentVo {
    private Integer contentNum;
    private String contentName;
    private String orgsrc;
    private String savesrc;
    private String contentSummary;
    private String trailerOrgsrc;
    private String trailerSavesrc;
    private Integer contentSize;
    private Integer trailerSize;
    private String contentPost1;
    private String contentPost2;
    private Date release;
    private Integer categoryNum;
    private Integer watchAge;
    private Date contentRegdate;
    private Integer seriesNum;
    private Integer staffNum;
    
	public ContentVo() {
	}
	public ContentVo(Integer contentNum, String contentName, String orgsrc, String savesrc, String contentSummary,
			String trailerOrgsrc, String trailerSavesrc, Integer contentSize, Integer trailerSize, String contentPost1,
			String contentPost2, Date release, Integer categoryNum, Integer watchAge, Date contentRegdate,
			Integer seriesNum, Integer staffNum) {
		this.contentNum = contentNum;
		this.contentName = contentName;
		this.orgsrc = orgsrc;
		this.savesrc = savesrc;
		this.contentSummary = contentSummary;
		this.trailerOrgsrc = trailerOrgsrc;
		this.trailerSavesrc = trailerSavesrc;
		this.contentSize = contentSize;
		this.trailerSize = trailerSize;
		this.contentPost1 = contentPost1;
		this.contentPost2 = contentPost2;
		this.release = release;
		this.categoryNum = categoryNum;
		this.watchAge = watchAge;
		this.contentRegdate = contentRegdate;
		this.seriesNum = seriesNum;
		this.staffNum = staffNum;
	}
	public Integer getContentNum() {
		return contentNum;
	}
	public void setContentNum(Integer contentNum) {
		this.contentNum = contentNum;
	}
	public String getContentName() {
		return contentName;
	}
	public void setContentName(String contentName) {
		this.contentName = contentName;
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
	public String getContentSummary() {
		return contentSummary;
	}
	public void setContentSummary(String contentSummary) {
		this.contentSummary = contentSummary;
	}
	public String getTrailerOrgsrc() {
		return trailerOrgsrc;
	}
	public void setTrailerOrgsrc(String trailerOrgsrc) {
		this.trailerOrgsrc = trailerOrgsrc;
	}
	public String getTrailerSavesrc() {
		return trailerSavesrc;
	}
	public void setTrailerSavesrc(String trailerSavesrc) {
		this.trailerSavesrc = trailerSavesrc;
	}
	public Integer getContentSize() {
		return contentSize;
	}
	public void setContentSize(Integer contentSize) {
		this.contentSize = contentSize;
	}
	public Integer getTrailerSize() {
		return trailerSize;
	}
	public void setTrailerSize(Integer trailerSize) {
		this.trailerSize = trailerSize;
	}
	public String getContentPost1() {
		return contentPost1;
	}
	public void setContentPost1(String contentPost1) {
		this.contentPost1 = contentPost1;
	}
	public String getContentPost2() {
		return contentPost2;
	}
	public void setContentPost2(String contentPost2) {
		this.contentPost2 = contentPost2;
	}
	public Date getRelease() {
		return release;
	}
	public void setRelease(Date release) {
		this.release = release;
	}
	public Integer getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(Integer categoryNum) {
		this.categoryNum = categoryNum;
	}
	public Integer getWatchAge() {
		return watchAge;
	}
	public void setWatchAge(Integer watchAge) {
		this.watchAge = watchAge;
	}
	public Date getContentRegdate() {
		return contentRegdate;
	}
	public void setContentRegdate(Date contentRegdate) {
		this.contentRegdate = contentRegdate;
	}
	public Integer getSeriesNum() {
		return seriesNum;
	}
	public void setSeriesNum(Integer seriesNum) {
		this.seriesNum = seriesNum;
	}
	public Integer getStaffNum() {
		return staffNum;
	}
	public void setStaffNum(Integer staffNum) {
		this.staffNum = staffNum;
	}
}

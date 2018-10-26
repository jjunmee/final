package com.jhta.netflix.survey.vo;

import java.sql.Date;

//¼³¹® 
public class SurveyVo {
	private Integer surveyNum;	 
	private Integer usersNum;
	private String surveyName; 
	private String surveyContent;
	private Date surveyStart;
	private Date surveyEnd; 
	
	public SurveyVo() {}
		
	public SurveyVo(Integer surveyNum, Integer usersNum, String surveyName, String surveyContent, Date surveyStart,
			Date surveyEnd) {
		super();
		this.surveyNum = surveyNum;
		this.usersNum = usersNum;
		this.surveyName = surveyName;
		this.surveyContent = surveyContent;
		this.surveyStart = surveyStart;
		this.surveyEnd = surveyEnd;
	}

	public Integer getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(Integer surveyNum) {
	    this.surveyNum = surveyNum;
	}

	public String getSurveyName() {
		return surveyName;
	}

	public void setSurveyName(String surveyName) {
		this.surveyName = surveyName;
	}

	public Date getSurveyStart() {
		return surveyStart;
	}

	public void setSurveyStart(Date surveyStart) {
		this.surveyStart = surveyStart;
	}

	public Date getSurveyEnd() {
		return surveyEnd;
	}

	public void setSurveyEnd(Date surveyEnd) {
		this.surveyEnd = surveyEnd;
	}

	public Integer getUsersNum() {
		return usersNum;
	}

	public void setUsersNum(Integer usersNum) {
		this.usersNum = usersNum;
	}

	public String getSurveyContent() {
		return surveyContent;
	}

	public void setSurveyContent(String surveyContent) {
		this.surveyContent = surveyContent;
	}
 
}
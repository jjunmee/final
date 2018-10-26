package com.jhta.netflix.survey.vo;

import java.sql.Date;

//¼³¹® 
public class SurveyVo {
	private Integer surveyNum;	 
	private Integer usersNum;
	private String surveyName; 
	private String surveyDescription;
	private Date surveyStart;
	private String surveyEnd; 
	
	public SurveyVo() {}
		
	public SurveyVo(Integer surveyNum, Integer usersNum, String surveyName, String surveyDescription, Date surveyStart,
			String surveyEnd) {
		super();
		this.surveyNum = surveyNum;
		this.usersNum = usersNum;
		this.surveyName = surveyName;
		this.surveyDescription = surveyDescription;
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

	public String getSurveyEnd() {
		return surveyEnd;
	}

	public void setSurveyEnd(String surveyEnd) {
		this.surveyEnd = surveyEnd;
	}

	public Integer getUsersNum() {
		return usersNum;
	}

	public void setUsersNum(Integer usersNum) {
		this.usersNum = usersNum;
	}

	public String getSurveyDescription() {
		return surveyDescription;
	}

	public void setSurveyDescription(String surveyDescription) {
		this.surveyDescription = surveyDescription;
	}
 
}
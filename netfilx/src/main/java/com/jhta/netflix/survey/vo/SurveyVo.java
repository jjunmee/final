package com.jhta.netflix.survey.vo;

import java.sql.Date;

//¼³¹® 
public class SurveyVo {
	private Integer surveyNum;	 
	private Integer userNum;
	private String surveyName; 
	private String surveyDescription;
	private Date surveyStart;
	private String surveyEnd; 
	private int spoint;
	private int joinNum;
	private String state;
	
	public SurveyVo() {}

	public SurveyVo(Integer surveyNum, Integer userNum, String surveyName, String surveyDescription, Date surveyStart,
			String surveyEnd, int spoint, int joinNum, String state) {
		super();
		this.surveyNum = surveyNum;
		this.userNum = userNum;
		this.surveyName = surveyName;
		this.surveyDescription = surveyDescription;
		this.surveyStart = surveyStart;
		this.surveyEnd = surveyEnd;
		this.spoint = spoint;
		this.joinNum = joinNum;
		this.state = state;
	}

	public Integer getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(Integer surveyNum) {
		this.surveyNum = surveyNum;
	}

	public Integer getUserNum() {
		return userNum;
	}

	public void setUserNum(Integer userNum) {
		this.userNum = userNum;
	}

	public String getSurveyName() {
		return surveyName;
	}

	public void setSurveyName(String surveyName) {
		this.surveyName = surveyName;
	}

	public String getSurveyDescription() {
		return surveyDescription;
	}

	public void setSurveyDescription(String surveyDescription) {
		this.surveyDescription = surveyDescription;
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

	public int getSpoint() {
		return spoint;
	}

	public void setSpoint(int spoint) {
		this.spoint = spoint;
	}

	public int getJoinNum() {
		return joinNum;
	}

	public void setJoinNum(int joinNum) {
		this.joinNum = joinNum;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	
	
 
}
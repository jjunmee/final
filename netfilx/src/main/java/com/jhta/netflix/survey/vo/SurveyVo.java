package com.jhta.netflix.survey.vo;

import java.sql.Date;

//설문 
public class SurveyVo {
	// 설문번호 
	private Integer surveyNum;
	// 설문명 
	private String surveyName;
	// 설문시작일 
	private Date surveyStart;
	// 설문만료일 
	private Date surveyEnd;
	// 유저번호 
	private Integer usersNum;
	// 설문설명 
	private String surveyContent;
	
	public SurveyVo() {}
		
	
	public SurveyVo(Integer surveyNum, String surveyName, Date surveyStart, Date surveyEnd, Integer usersNum,
			String surveyContent) {
		super();
		this.surveyNum = surveyNum;
		this.surveyName = surveyName;
		this.surveyStart = surveyStart;
		this.surveyEnd = surveyEnd;
		this.usersNum = usersNum;
		this.surveyContent = surveyContent;
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
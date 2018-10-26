package com.jhta.netflix.survey.vo;

import java.sql.Date;

//���� 
public class SurveyVo {
	// ������ȣ 
	private Integer surveyNum;
	// ������ 
	private String surveyName;
	// ���������� 
	private Date surveyStart;
	// ���������� 
	private Date surveyEnd;
	// ������ȣ 
	private Integer usersNum;
	// �������� 
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
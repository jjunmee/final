package com.jhta.netflix.survey.vo;


public class SurveyQuestionVo {
	private int sqNum;
	private int surveyNum;
	private String sqTitle;
	private String sqType;
	
	public SurveyQuestionVo() {}

	public SurveyQuestionVo(int sqNum, int surveyNum, String sqTitle, String sqType) {
		super();
		this.sqNum = sqNum;
		this.surveyNum = surveyNum;
		this.sqTitle = sqTitle;
		this.sqType = sqType;
	}

	public int getSqNum() {
		return sqNum;
	}

	public void setSqNum(int sqNum) {
		this.sqNum = sqNum;
	}

	public int getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(int surveyNum) {
		this.surveyNum = surveyNum;
	}

	public String getSqTitle() {
		return sqTitle;
	}

	public void setSqTitle(String sqTitle) {
		this.sqTitle = sqTitle;
	}

	public String getSqType() {
		return sqType;
	}

	public void setSqType(String sqType) {
		this.sqType = sqType;
	}
	
	
}

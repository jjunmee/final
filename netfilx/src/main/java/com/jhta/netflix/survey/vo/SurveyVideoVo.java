package com.jhta.netflix.survey.vo;

public class SurveyVideoVo {
	private int scNum;
	private int surveyNum;
	private String scSrc;
	
	public SurveyVideoVo() {}

	public SurveyVideoVo(int scNum, int surveyNum, String scSrc) {
		super();
		this.scNum = scNum;
		this.surveyNum = surveyNum;
		this.scSrc = scSrc;
	}

	public int getScNum() {
		return scNum;
	}

	public void setScNum(int scNum) {
		this.scNum = scNum;
	}

	public int getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(int surveyNum) {
		this.surveyNum = surveyNum;
	}

	public String getScSrc() {
		return scSrc;
	}

	public void setScSrc(String scSrc) {
		this.scSrc = scSrc;
	}
	
	
}

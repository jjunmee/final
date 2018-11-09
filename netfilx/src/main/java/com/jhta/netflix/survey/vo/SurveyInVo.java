package com.jhta.netflix.survey.vo;

public class SurveyInVo {
	private int siNum;
	private int userNum;
	private int surveyNum;
	
	public SurveyInVo() {}

	public SurveyInVo(int siNum, int userNum, int surveyNum) {
		super();
		this.siNum = siNum;
		this.userNum = userNum;
		this.surveyNum = surveyNum;
	}

	public int getSiNum() {
		return siNum;
	}

	public void setSiNum(int siNum) {
		this.siNum = siNum;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public int getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(int surveyNum) {
		this.surveyNum = surveyNum;
	}
	
}

package com.jhta.netflix.survey.vo;

public class SurveyAnswerVo {
	private int saNum;
	private int sqNum;
	private String saAnswer;
	
	public SurveyAnswerVo()	{}

	public SurveyAnswerVo(int saNum, int sqNum, String saAnswer) {
		super();
		this.saNum = saNum;
		this.sqNum = sqNum;
		this.saAnswer = saAnswer;
	}

	public int getSaNum() {
		return saNum;
	}

	public void setSaNum(int saNum) {
		this.saNum = saNum;
	}

	public int getSqNum() {
		return sqNum;
	}

	public void setSqNum(int sqNum) {
		this.sqNum = sqNum;
	}

	public String getSaAnswer() {
		return saAnswer;
	}

	public void setSaAnswer(String saAnswer) {
		this.saAnswer = saAnswer;
	}
	
	
}

package com.jhta.netflix.survey.vo;

public class SurveyResultVo {
	private int srNum;
	private int sqNum;
	private String srAnswer;
	
	public SurveyResultVo() {}

	public SurveyResultVo(int srNum, int sqNum, String srAnswer) {
		super();
		this.srNum = srNum;
		this.sqNum = sqNum;
		this.srAnswer = srAnswer;
	}

	public int getSrNum() {
		return srNum;
	}

	public void setSrNum(int srNum) {
		this.srNum = srNum;
	}

	public int getSqNum() {
		return sqNum;
	}

	public void setSqNum(int sqNum) {
		this.sqNum = sqNum;
	}

	public String getSrAnswer() {
		return srAnswer;
	}

	public void setSrAnswer(String srAnswer) {
		this.srAnswer = srAnswer;
	}
	
	
}

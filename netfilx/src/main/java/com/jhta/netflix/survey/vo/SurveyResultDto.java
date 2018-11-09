package com.jhta.netflix.survey.vo;

import java.util.List;

public class SurveyResultDto {
	private int sqNum;
	private String srAnswer;
	private List<SurveyResultDto> resultList;
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
	public List<SurveyResultDto> getResultList() {
		return resultList;
	}
	public void setResultList(List<SurveyResultDto> resultList) {
		this.resultList = resultList;
	}
	
}

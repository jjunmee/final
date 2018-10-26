package com.jhta.netflix.survey.vo;

import java.util.List;

public class SurveyAnswerDto {
	private String[] alist;
	private List<SurveyAnswerDto> salist;
	public String[] getAlist() {
		return alist;
	}
	public void setAlist(String[] alist) {
		this.alist = alist;
	}
	public List<SurveyAnswerDto> getSalist() {
		return salist;
	}
	public void setSalist(List<SurveyAnswerDto> salist) {
		this.salist = salist;
	}
	
	
}

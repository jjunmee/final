package com.jhta.netflix.survey.vo;

import java.util.List;

public class SurveyQuestionDto {
	private String sqTitle;
	private String sqType;
	private List<SurveyQuestionDto> qlist;
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
	public List<SurveyQuestionDto> getQlist() {
		return qlist;
	}
	public void setQlist(List<SurveyQuestionDto> qlist) {
		this.qlist = qlist;
	}
	
	
}

package com.jhta.netflix.survey.vo;

public class SurveyVideoVo {
	private int svNum;
	private int surveyNum;
	private String svOrgSrc;
	private String svSaveSrc;
	
	public SurveyVideoVo() {}

	public SurveyVideoVo(int svNum, int surveyNum, String svOrgSrc, String svSaveSrc) {
		super();
		this.svNum = svNum;
		this.surveyNum = surveyNum;
		this.svOrgSrc = svOrgSrc;
		this.svSaveSrc = svSaveSrc;
	}

	public int getSvNum() {
		return svNum;
	}

	public void setSvNum(int svNum) {
		this.svNum = svNum;
	}

	public int getSurveyNum() {
		return surveyNum;
	}

	public void setSurveyNum(int surveyNum) {
		this.surveyNum = surveyNum;
	}

	public String getSvOrgSrc() {
		return svOrgSrc;
	}

	public void setSvOrgSrc(String svOrgSrc) {
		this.svOrgSrc = svOrgSrc;
	}

	public String getSvSaveSrc() {
		return svSaveSrc;
	}

	public void setSvSaveSrc(String svSaveSrc) {
		this.svSaveSrc = svSaveSrc;
	}

	

	
	
}

package com.jhta.netflix.survey.vo;

public class SrCntDto {
	private String srAnswer;
	private int cnt;
	
	public SrCntDto() {}

	public SrCntDto(String srAnswer, int cnt) {
		super();
		this.srAnswer = srAnswer;
		this.cnt = cnt;
	}

	public String getSrAnswer() {
		return srAnswer;
	}

	public void setSrAnswer(String srAnswer) {
		this.srAnswer = srAnswer;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
}

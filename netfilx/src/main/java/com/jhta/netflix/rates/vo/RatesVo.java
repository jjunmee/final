package com.jhta.netflix.rates.vo;

public class RatesVo {
	private int rates_num;
	private float rates_score;
	private int profile_num;
	private int content_num;
	public RatesVo() {
	}
	public RatesVo(int rates_num, float rates_score, int profile_num, int content_num) {
		this.rates_num = rates_num;
		this.rates_score = rates_score;
		this.profile_num = profile_num;
		this.content_num = content_num;
	}
	public int getRates_num() {
		return rates_num;
	}
	public void setRates_num(int rates_num) {
		this.rates_num = rates_num;
	}
	public float getRates_score() {
		return rates_score;
	}
	public void setRates_score(float rates_score) {
		this.rates_score = rates_score;
	}
	public int getProfile_num() {
		return profile_num;
	}
	public void setProfile_num(int profile_num) {
		this.profile_num = profile_num;
	}
	public int getContent_num() {
		return content_num;
	}
	public void setContent_num(int content_num) {
		this.content_num = content_num;
	}
	
}

package com.jhta.netflix.rates.vo;

public class RatesAvgVo {
	private float avg;
	private int cnt;
	public RatesAvgVo() {
	}
	public RatesAvgVo(float avg, int cnt) {
		this.avg = avg;
		this.cnt = cnt;
	}
	public float getAvg() {
		return avg;
	}
	public void setAvg(float avg) {
		this.avg = avg;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}

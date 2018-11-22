package com.jhta.netflix.chart.vo;

public class GnameCountVo {
	private String gname;
	private int gcount;
	
	public GnameCountVo() {}
	public GnameCountVo(String gname, int gcount) {
		super();
		this.gname = gname;
		this.gcount = gcount;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public int getGcount() {
		return gcount;
	}
	public void setGcount(int gcount) {
		this.gcount = gcount;
	}
}

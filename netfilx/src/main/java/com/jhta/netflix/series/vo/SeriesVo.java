package com.jhta.netflix.series.vo;

public class SeriesVo {
    private Integer series_num;
    private String series_name;
    private String season;
	public SeriesVo() {
	}
	public SeriesVo(Integer series_num, String series_name, String season) {
		this.series_num = series_num;
		this.series_name = series_name;
		this.season = season;
	}
	public Integer getSeries_num() {
		return series_num;
	}
	public void setSeries_num(Integer series_num) {
		this.series_num = series_num;
	}
	public String getSeries_name() {
		return series_name;
	}
	public void setSeries_name(String series_name) {
		this.series_name = series_name;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
    
}

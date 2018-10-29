package com.jhta.netflix.series.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.series.service.SeriesService;
import com.jhta.netflix.series.vo.SeriesVo;

@Controller
public class SeriesController {
	@Autowired
	private SeriesService service;
	
	@RequestMapping(value="/content/serieslist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String stafflist(String name) {
		List<SeriesVo> list = service.list(name);
		JSONArray arr = new JSONArray();
		for(SeriesVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("series_num", vo.getSeries_num());
			json.put("series_name", vo.getSeries_name());
			json.put("season", vo.getSeason());
			arr.put(json);
		}
		return arr.toString();
	}
	@RequestMapping(value="/content/insertSeries",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insertStaff(String series_name,String season) {
		int n = service.insert(new SeriesVo(0, series_name, season));
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("code", "success");
		}else {
			json.put("code", "fail");
		}
		return json.toString();
	}
}

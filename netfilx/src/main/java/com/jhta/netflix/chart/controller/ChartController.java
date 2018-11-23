package com.jhta.netflix.chart.controller;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.chart.service.ChartService;
import com.jhta.netflix.chart.vo.GnameCountVo;

@Controller
public class ChartController {
	@Autowired
	private ChartService service;
	
	@RequestMapping("/admin/paychart")
	public String paychart() {
		return ".admin.paychart";
	}
	
	@RequestMapping(value="/chart/gradeNameThisCount",produces="application/json;charset=utf-8")
	@ResponseBody
	public String gradeNameThisCount() {
		List<GnameCountVo> list = service.gradeThisNameCount();
		JSONArray arr = new JSONArray();
		for(GnameCountVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("gname", vo.getGname());
			json.put("gcount", vo.getGcount());
			arr.put(json);
		}
		return arr.toString();
	}
	
	@RequestMapping(value="/chart/gradeNameNextCount",produces="application/json;charset=utf-8")
	@ResponseBody
	public String gradeNameNextCount() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("n1", 1);
		map.put("n2", 2);
		List<GnameCountVo> list = service.gradeNextNameCount(map);
		JSONArray arr = new JSONArray();
		for(GnameCountVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("gname", vo.getGname());
			json.put("gcount", vo.getGcount());
			arr.put(json);
		}
		return arr.toString();
	}
}

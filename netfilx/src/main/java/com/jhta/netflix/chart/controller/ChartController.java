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
	
	@RequestMapping(value="/chart/monthTotal",produces="application/json;charset=utf-8")
	@ResponseBody
	public String monthTotal() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		JSONObject json = new JSONObject();
		int thisMonthTotal = service.thisMonthTotal(); //이번달순이익
		int mPayThisMonthSum = service.mPayThisMonthSum(); //이번달멤버십결제총액
		int pointThisMonthPay = service.pointThisMonthPay(); //이번달포인트충전
		int pointMemThisMonthSum = service.pointMemThisMonthSum();//이번달포인트로멤버십결제
		json.put("thisMonthTotal",thisMonthTotal);
		json.put("mPayThisMonthSum",mPayThisMonthSum);
		json.put("pointThisMonthPay",pointThisMonthPay);
		json.put("pointMemThisMonthSum",pointMemThisMonthSum);
		System.out.println("thisMonthTotal========"+mPayThisMonthSum);
		System.out.println("mPayThisMonthSum========"+thisMonthTotal);
		System.out.println("pointThisMonthPay========"+pointThisMonthPay);
		System.out.println("pointMemThisMonthSum========"+pointMemThisMonthSum);
		for(int i=1; i<4; i++) {
			int j = i+1;
			map.put("n"+i, i);
			map.put("n"+j, j);
			int nextMonthTotal = service.nextMonthTotal(map); //지난달순이익
			int mPayNextMonthSum = service.nextMonthTotal(map); //지난달멤버십결제총액
			int pointNextMonthPay = service.pointNextMonthPay(map);//지난달포인트충전
			int pointMemNextMonthSum = service.pointMemNextMonthSum(map);//지난달포인트로멤버십결제
			json.put("nextMonthTotal"+i,nextMonthTotal);
			json.put("mPayNextMonthSum"+i,mPayNextMonthSum);
			json.put("pointNextMonthPay"+i,pointNextMonthPay);
			json.put("pointMemNextMonthSum"+i,pointMemNextMonthSum);
		}
		return json.toString();
	}
}

package com.jhta.netflix.rates.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.rates.service.RatesService;
import com.jhta.netflix.rates.vo.RatesAvgVo;
import com.jhta.netflix.rates.vo.RatesVo;

@Controller
public class RatesController {
	@Autowired
	private RatesService service;
	
	@RequestMapping(value="/rates/setScore",produces="application/json;charset=utf-8")
	@ResponseBody
	public String setScore(RatesVo vo) {
		JSONObject json = new JSONObject();
		try {
			RatesVo resultVo = service.findRecord(vo);
			if(resultVo != null) {
				vo.setRates_num(resultVo.getRates_num());
				int n = service.update(vo);
				if(n>0) {
					json.put("result", true);
				}else {
					json.put("result", false);
				}
			}else {
				int n = service.insert(vo);
				if(n>0) {
					json.put("result", true);
				}else {
					json.put("result", false);
				}
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			json.put("result", false);
		}
		return json.toString();
	}
	@RequestMapping(value="rates/getAvg",produces="application/json;charset=utf-8")
	@ResponseBody
	public String getAvg(int content_num) {
		JSONObject json = new JSONObject();
		RatesAvgVo vo = service.getAvg(content_num);
		double avg = Math.round(vo.getAvg()*100)/100.0;
		json.put("avg", avg);
		json.put("cnt", vo.getCnt());
		return json.toString();
	}
	@RequestMapping(value="rates/record",produces="application/json;charset=utf-8")
	@ResponseBody
	public String record(RatesVo vo) {
		JSONObject json = new JSONObject();
		RatesVo resultVo = service.findRecord(vo);
		if(resultVo != null) {
			json.put("result", resultVo.getRates_score()+"");
		}
		return json.toString();
	}
}

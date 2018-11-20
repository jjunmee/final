package com.jhta.netflix.interasts.controller;

import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.interasts.service.InterastsService;
import com.jhta.netflix.interasts.vo.InterastsVo;

@Controller
public class InterastsController {
	@Autowired
	private InterastsService service;
	
	@RequestMapping(value="/interasts/count",produces="application/json;charset=utf-8")
	@ResponseBody
	public String count(int content_num,int profile_num) {
		JSONObject json = new JSONObject();
		count_check(json,content_num,profile_num);
		return json.toString();
	}
	@RequestMapping(value="/interasts/insert",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insert(InterastsVo vo) {
		JSONObject json = new JSONObject();
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("content_num", vo.getContent_num());
			map.put("profile_num", vo.getProfile_num());
			InterastsVo resultVo = service.find(map);
			if(resultVo == null) {
				int n = service.insert(vo);
				if(n>0) {
					json.put("result", true);
					count_check(json, vo.getContent_num(), vo.getProfile_num());
				}else {
					json.put("result", false);
				}
			}else {
				int n = service.delete(resultVo.getInterasts_num());
				if(n>0) {
					json.put("result", true);
					count_check(json, vo.getContent_num(), vo.getProfile_num());
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
	private void count_check(JSONObject json,int content_num,int profile_num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content_num", content_num);
		map.put("profile_num", profile_num);
		json.put("count", service.count(content_num));
		if(service.find(map) != null) {
			json.put("check", true);
		}else {
			json.put("check", false);
		}
	}
}

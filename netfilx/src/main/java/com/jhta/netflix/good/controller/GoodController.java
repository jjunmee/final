package com.jhta.netflix.good.controller;

import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.good.service.GoodService;
import com.jhta.netflix.good.vo.GoodVo;
import com.jhta.netflix.interasts.vo.InterastsVo;

@Controller
public class GoodController {
	@Autowired
	private GoodService service;
	
	@RequestMapping(value="/good/insert",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insert(GoodVo vo) {
		JSONObject json = new JSONObject();
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("comment_num", vo.getComment_num());
			map.put("profile_num", vo.getProfile_num());
			GoodVo resultVo = service.find(map);
			if(resultVo == null) {
				int n = service.insert(vo);
				if(n>0) {
					json.put("result", true);
					json.put("check", true);
					json.put("count", service.count(vo.getComment_num()));
				}else {
					json.put("result", false);
				}
			}else {
				int n = service.delete(resultVo.getGood_num());
				if(n>0) {
					json.put("result", true);
					json.put("check", false);
					json.put("count", service.count(vo.getComment_num()));
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
}

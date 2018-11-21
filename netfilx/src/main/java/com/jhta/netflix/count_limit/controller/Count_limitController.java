package com.jhta.netflix.count_limit.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.count_limit.service.Count_limitService;
import com.jhta.netflix.count_limit.vo.Count_limitVo;

@Controller
public class Count_limitController {
	@Autowired
	private Count_limitService service;
	
	@RequestMapping(value="/limit/check",produces="application/json;charset=utf-8")
	@ResponseBody
	public String check(int users_num) {
		JSONObject json = new JSONObject();
		String sLimitNum = service.getLimitNum(users_num);
		System.out.println(sLimitNum);
		if(sLimitNum != null) {
			Count_limitVo vo = service.find(users_num);
			if(vo == null) {
				int n = service.insert(new Count_limitVo(0, 1, users_num));
				if(n>0) {
					json.put("check", "true");
				}else {
					json.put("check", "false");
				}
			}else {
				int limitNum = Integer.parseInt(sLimitNum.split("-")[1]);
				if(vo.getCount() >= limitNum) {
					json.put("check", "false");
				}else {
					vo.setCount(vo.getCount()+1);
					service.update(vo);
					json.put("check", "true");
				}
			}
		}else {
			json.put("check", "pay");
		}
		return json.toString();
	}
	@RequestMapping(value="/limit/exit",produces="application/json;charset=utf-8")
	@ResponseBody
	public String exit(int users_num) {
		Count_limitVo vo = service.find(users_num);
		if(vo != null) {
			vo.setCount(vo.getCount()-1);
			service.update(vo);
		}
		return "";
	}
}

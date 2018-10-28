package com.jhta.netflix.staff.controller;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.staff.service.StaffService;
import com.jhta.netflix.staff.vo.StaffVo;

@Controller
public class StaffController {
	@Autowired
	private StaffService service;
	
	@RequestMapping(value="/content/stafflist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String stafflist(int position,String name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("position", position);
		map.put("name", name);
		List<StaffVo> list = service.list(map);
		JSONArray arr = new JSONArray();
		for(StaffVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("staff_num", vo.getStaff_num());
			json.put("staff_position", vo.getStaff_position());
			json.put("staff_name", vo.getStaff_name());
			json.put("staff_age", vo.getStaff_age());
			json.put("staff_gender", vo.getStaff_gender());
			json.put("staff_debut", vo.getStaff_debut());
			arr.put(json);
		}
		return arr.toString();
	}
	@RequestMapping(value="/content/insertStaff",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insertStaff(boolean staff_position,String staff_name,int staff_age,
			String staff_gender,String staff_debut) {
		int n = service.insert(new StaffVo(0, staff_position, staff_name, staff_age, staff_gender, staff_debut));
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("code", "success");
		}else {
			json.put("code", "fail");
		}
		json.put("position", staff_position);
		return json.toString();
	}
}

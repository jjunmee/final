package com.jhta.netflix.staff.controller;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.content.vo.ContentVo;
import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.staff.service.StaffService;
import com.jhta.netflix.staff.vo.StaffVo;

@Controller
public class StaffController {
	@Autowired
	private StaffService service;
	
	@RequestMapping(value="/staff/list",method=RequestMethod.GET)
	public String staffList(Model model,@RequestParam(value="pageNum",defaultValue="1")int pageNum,
			@RequestParam(value="position",defaultValue="false")boolean position,String keyword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(keyword);
		if(keyword != null && !keyword.trim().equals("")) {
			map.put("keyword", keyword);
			model.addAttribute("keyword", keyword);
		}
		int totalRowCount = service.listCount(keyword);
		PageUtil pageUtil = new PageUtil(pageNum, totalRowCount, 10, 10);
		map.put("startRow", pageUtil.getMysqlStartRow());
		map.put("rowBlockCount", pageUtil.getRowBlockCount());
		map.put("position", position);
		List<StaffVo> list = service.list(map);
		model.addAttribute("list", list);
		model.addAttribute("pageUtil", pageUtil);
		model.addAttribute("position", position);
		return ".staff.list";
	}
	@RequestMapping(value="/content/stafflist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String stafflist(int position,String staff_name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("position", position);
		map.put("staff_name", staff_name);
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
		return json.toString();
	}
}

package com.jhta.netflix.series.controller;

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

import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.series.service.SeriesService;
import com.jhta.netflix.series.vo.SeriesVo;
import com.jhta.netflix.staff.vo.StaffVo;

@Controller
public class SeriesController {
	@Autowired
	private SeriesService service;
	
	@RequestMapping(value="/series/list")
	public String list(Model model,@RequestParam(value="pageNum",defaultValue="1")int pageNum,
			String keyword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int totalRowCount = service.count(keyword);
		if(keyword != null && !keyword.trim().equals("")) {
			map.put("keyword", keyword);
			model.addAttribute("keyword", keyword);
		}
		if(totalRowCount != 0) {
			PageUtil pageUtil = new PageUtil(pageNum, totalRowCount, 10, 10);
			if(pageNum > pageUtil.getTotalPageCount()) {
				pageUtil = new PageUtil(pageUtil.getTotalPageCount(), totalRowCount, 10, 10);
			}
			map.put("startRow", pageUtil.getMysqlStartRow());
			map.put("rowBlockCount", pageUtil.getRowBlockCount());
			List<SeriesVo> list = service.list(map);
			model.addAttribute("list", list);
			model.addAttribute("pageUtil", pageUtil);
		}
		return ".series.list";
	}
	@RequestMapping(value="/content/serieslist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String stafflist(String name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", name);
		List<SeriesVo> list = service.list(map);
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

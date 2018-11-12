package com.jhta.netflix.record.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.record.service.RecordService;
import com.jhta.netflix.record.vo.RecordVo;

@Controller
public class RecordController {
	@Autowired
	private RecordService service;
	
	@RequestMapping(value="/record/record",produces="application/json;charset=utf-8")
	@ResponseBody
	public String record(RecordVo vo) {
		JSONObject json = new JSONObject();
		if(vo.getTotal_time() != 0) {
			RecordVo resultVo = service.find(vo);
			if(resultVo == null) {
				service.insert(vo);
			}else {
				vo.setRecord_num(resultVo.getRecord_num());
				vo.setTotal_time(vo.getTotal_time() + resultVo.getTotal_time());
				service.update(vo);
			}
		}
		return json.toString();
	}
	@RequestMapping(value="/record/getInfo",produces="application/json;charset=utf-8")
	@ResponseBody
	public String getInfo(RecordVo vo) {
		JSONObject json = new JSONObject();
		RecordVo resultVo = service.find(vo);
		if(resultVo != null) {
			json.put("record_num", resultVo.getRecord_num());
			json.put("next_watch", resultVo.getNext_watch());
			json.put("total_time", resultVo.getTotal_time());
			json.put("content_num", resultVo.getContent_num());
			json.put("profile_num", resultVo.getProfile_num());
		}
		return json.toString();
	}
}

package com.jhta.netflix.content_comment.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.content_comment.service.Content_commentService;
import com.jhta.netflix.content_comment.vo.Content_commentVo;

@Controller
public class Content_commentController {
	@Autowired
	private Content_commentService service;
	
	@RequestMapping(value="/comment/insert",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insert(Content_commentVo vo) {
		JSONObject json = new JSONObject();
		try {
			int n = service.insert(vo);
			if(n>0) {
				json.put("result", true);
			}else {
				json.put("result", false);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			json.put("result", false);
		}
		return json.toString();
	}
	@RequestMapping(value="/comment/list",produces="application/json;charset=utf-8")
	@ResponseBody
	public String list(int content_num) {
		List<Content_commentVo> list= service.list(content_num);
		JSONArray arr = new JSONArray();
		for(Content_commentVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("comment_num", vo.getComment_num());
			json.put("comment", vo.getComment());
			json.put("c_lev", vo.getC_lev());
			json.put("c_step", vo.getC_step());
			json.put("content_num", vo.getContent_num());
			json.put("profile_num", vo.getProfile_num());
			json.put("comment_open", vo.isComment_open());
			json.put("bookmark", vo.isBookmark());
			arr.put(json);
		}
		return arr.toString();
	}
}

package com.jhta.netflix.genre.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.genre.service.GenreService;
import com.jhta.netflix.genre.vo.GenreVo;

@Controller
public class GenreController {
	@Autowired
	private GenreService service;
	
	@RequestMapping(value="/content/genrelist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String genrelist(int num) {
		List<GenreVo> list = service.list(num);
		JSONArray arr = new JSONArray();
		for(GenreVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("genre_num", vo.getGenre_num());
			json.put("genre_name", vo.getGenre_name());
			arr.put(json);
		}
		return arr.toString();
	}
}

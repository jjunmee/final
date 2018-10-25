package com.jhta.netflix.genre.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.category.vo.CategoryVo;
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
	@RequestMapping(value="/category/genrelist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String cgenrelist() {
		List<GenreVo> list = service.list();
		JSONArray arr = new JSONArray();
		for(GenreVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("genre_num", vo.getGenre_num());
			json.put("genre_name", vo.getGenre_name());
			json.put("category_num", vo.getCategory_num());
			arr.put(json);
		}
		return arr.toString();
	}
	
	@RequestMapping(value="/genre/insert",method=RequestMethod.POST)
	public ModelAndView insert(String genre_name,int category_num) {
		GenreVo vo = new GenreVo(0,genre_name,category_num);
		int n = service.insert(vo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("category/category");
		if(n>0) {
			mv.addObject("code", "success");
		}else {
			mv.addObject("code", "fail");
		}
		return mv;
	}
}

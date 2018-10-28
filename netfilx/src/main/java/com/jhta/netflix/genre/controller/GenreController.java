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

import com.jhta.netflix.category.vo.CateGenreVo;
import com.jhta.netflix.genre.service.GenreService;
import com.jhta.netflix.genre.vo.GenreVo;

@Controller
public class GenreController {
	@Autowired
	private GenreService service;
	
	//카테고리별 장르리스트뿌리기
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
	
	//장르전체리스트 카테고리오름차순으로 뿌리기
	@RequestMapping(value="/category/genrelist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String cgenrelist() {
		List<CateGenreVo> list = service.list();
		JSONArray arr = new JSONArray();
		for(CateGenreVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("genre_num", vo.getGenre_num());
			json.put("genre_name", vo.getGenre_name());
			json.put("category_num", vo.getCategory_num());
			json.put("category_name", vo.getCategory_name());
			arr.put(json);
		}
		return arr.toString();
	}
	
	//장르등록
	@RequestMapping(value="/genre/insert",method=RequestMethod.POST)
	public ModelAndView insert(String genre_name,int category_num) {
		GenreVo vo = new GenreVo(0,genre_name,category_num);
		int n = service.insert(vo);
		ModelAndView mv = new ModelAndView();
		String result = ".category.category";
		if(n>0) {
			mv.addObject("code", "요청성공");
		}else {
			mv.addObject("code", "요청실패");
		}
		mv.setViewName(result);
		return mv;
	}
	
	//장르삭제
	@RequestMapping(value="/genre/delete",method=RequestMethod.GET)
	public ModelAndView delete(int num) {
		int n = service.delete(num);
		ModelAndView mv = new ModelAndView();
		String result = ".category.category";
		if(n>0) {
			mv.addObject("code", "요청성공");
		}else {
			mv.addObject("code", "요청실패");
		}
		mv.setViewName(result);
		return mv;
	}
	
	//장르수정
	@RequestMapping(value="/genre/update",produces="application/json;charset=utf-8")
	@ResponseBody
	public String update(String genre_name,int genre_num,int category_num) {
		GenreVo vo = new GenreVo();
		int n = service.update(vo);
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("updatename",genre_name);
			json.put("updatenum",genre_num);
		}else {
			json.put("code", "요청실패");
		}
		return json.toString();
	}
}

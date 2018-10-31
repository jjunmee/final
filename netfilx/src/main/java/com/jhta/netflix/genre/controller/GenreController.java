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

import com.jhta.netflix.category.service.CategoryService;
import com.jhta.netflix.category.vo.CateGenreVo;
import com.jhta.netflix.content_genre.service.Content_genreService;
import com.jhta.netflix.content_genre.vo.Content_genreVo;
import com.jhta.netflix.genre.service.GenreService;
import com.jhta.netflix.genre.vo.GenreVo;

@Controller
public class GenreController {
	@Autowired
	private GenreService service;
	@Autowired
	private Content_genreService cgservice;
	@Autowired
	private CategoryService cservice;
	
	
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
	
	//카테고리별 장르리스트뿌리기(등록,수정,삭제 페이지에서)
		@RequestMapping(value="/category/check_genrelist",produces="application/json;charset=utf-8")
		@ResponseBody
		public String check_genrelist(int num) {
			System.out.println("넘어온 값"+num);
			List<CateGenreVo> list = service.checklist(num);
			JSONArray arr = new JSONArray();
			for(CateGenreVo vo : list) {
				JSONObject json = new JSONObject();
				json.put("genre_num", vo.getGenre_num());
				json.put("genre_name", vo.getGenre_name());
				json.put("category_num", vo.getCategory_num());
				json.put("category_name", vo.getCategory_name());
				arr.put(json);
				System.out.println("보낼값"+vo.getGenre_name());
			}
			return arr.toString();
		}
	
	//수정 선택한 장르 찾기
	@RequestMapping(value="/genre/genrename",produces="application/json;charset=utf-8")
	@ResponseBody
	public String genrename(int gnum) {
		CateGenreVo vo = service.selectname(gnum);
		JSONObject json = new JSONObject();
		json.put("genre_num", vo.getGenre_num());
		json.put("genre_name", vo.getGenre_name());
		json.put("category_num", vo.getCategory_num());
		json.put("category_name", vo.getCategory_name());
		return json.toString();
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
		cgservice.genredelete(num);
		ModelAndView mv = new ModelAndView();
		String result = ".category.category";
		int n = service.delete(num);
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
		cgservice.genredelete(genre_num);
		JSONObject json = new JSONObject();
		GenreVo vo = new GenreVo(genre_num,genre_name,category_num);
		int n = service.update(vo);
		if(n>0) {
			CateGenreVo upvo = service.selectname(genre_num);
			json.put("genre_num", upvo.getGenre_num());
			json.put("genre_name", upvo.getGenre_name());
			json.put("category_num", upvo.getCategory_num());
			json.put("category_name", upvo.getCategory_name());
		}else {
			json.put("code", "요청실패");
		}
		return json.toString();
	}
	
	//카테고리 삭제
	@RequestMapping(value="/category/delete",produces="application/json;charset=utf-8")
	@ResponseBody
	public String catedelete(int num) {
		List<GenreVo> list = service.list(num);
		JSONObject json = new JSONObject();
		for(GenreVo vo : list) {
			int genre_num = vo.getGenre_num();
			String genre_name = vo.getGenre_name();
			cgservice.genredelete(genre_num);
			GenreVo gvo = new GenreVo(genre_num,genre_name,15);
			int n = service.update(gvo);
			if(n>0) {
				int nd = cservice.delete(num);
				if(nd>0) {
					json.put("code", "요청성공");
					return json.toString();
				}else {
					json.put("code", "요청실패");
				}
				return json.toString();
			}else {
				json.put("code", "요청실패");
			}
		}
		return json.toString();
	}
}

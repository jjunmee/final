package com.jhta.netflix.category.controller;

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
import com.jhta.netflix.category.vo.CategoryVo;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService service;
	
	//카테고리등록수정폼으로 이동
	@RequestMapping(value="/category/category",method=RequestMethod.GET)
	public String categoryForm() {
		return ".category.category";
	}
	
	//카테고리 등록
	@RequestMapping(value="/category/insert",method=RequestMethod.POST)
	public ModelAndView insert(String category_name) {
		CategoryVo vo = new CategoryVo(0,category_name);
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
	
	//카테고리 삭제
	@RequestMapping(value="/category/delete",method=RequestMethod.GET)
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
	
	//카테고리 수정
	@RequestMapping(value="/category/update",produces="application/json;charset=utf-8")
	@ResponseBody
	public String update(String category_name,int category_num) {
		CategoryVo vo = new CategoryVo(category_num,category_name);
		int n = service.update(vo);
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("updatename",category_name);
			json.put("updatenum",category_num);
		}else {
			json.put("code", "요청실패");
		}
		return json.toString();
	}
	
	//카테고리리스트뿌리기
	@RequestMapping(value="/content/categorylist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String categorylist() {
		List<CategoryVo> list = service.list();
		JSONArray arr = new JSONArray();
		for(CategoryVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("category_num", vo.getCategory_num());
			json.put("category_name", vo.getCategory_name());
			arr.put(json);
		}
		return arr.toString();
	}
	
	//수정 선택한 카테고리 찾기
	@RequestMapping(value="/category/categoryname",produces="application/json;charset=utf-8")
	@ResponseBody
	public String categorylist(int num) {
		CategoryVo vo = service.selectname(num);
			JSONObject json = new JSONObject();
			json.put("category_num", vo.getCategory_num());
			json.put("category_name", vo.getCategory_name());
		return json.toString();
	}

}

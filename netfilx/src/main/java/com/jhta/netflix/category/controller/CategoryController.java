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
	
	@RequestMapping(value="/category/category",method=RequestMethod.GET)
	public String categoryForm() {
		return "category/category";
	}
	
	@RequestMapping(value="/category/insert",method=RequestMethod.POST)
	public ModelAndView insert(String category_name) {
		CategoryVo vo = new CategoryVo(0,category_name);
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
	
	@RequestMapping(value="/category/delete",method=RequestMethod.GET)
	public ModelAndView delete(int num) {
		int n = service.delete(num);
		System.out.println(num);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("category/category");
		if(n>0) {
			mv.addObject("code", "success");
		}else {
			mv.addObject("code", "fail");
		}
		return mv;
	}
	
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
			json.put("code", "fail");
		}
		return json.toString();
	}
	
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

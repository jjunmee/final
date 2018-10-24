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
	
	@RequestMapping(value="/content/categorylist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String categorylist() {
		List<CategoryVo> list = service.list();
		JSONArray arr = new JSONArray();
		for(CategoryVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("categoryNum", vo.getCategory_num());
			json.put("categoryName", vo.getCategory_name());
			arr.put(json);
		}
		return arr.toString();
	}
	
	@RequestMapping("/category/categorylist")
	public ModelAndView categoryformlist() {
		List<CategoryVo> list = service.list();
		ModelAndView mv = new ModelAndView("category");
		mv.addObject("clist", list);
		return mv;
	}
}

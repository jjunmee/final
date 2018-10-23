package com.jhta.netflix.category.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public ModelAndView insert(CategoryVo vo) {
		int n = service.insert(vo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("category");
		if(n>0) {
			mv.addObject("code", "success");
		}else {
			mv.addObject("code", "fail");
		}
		return mv;
	}
}

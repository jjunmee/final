package com.jhta.netflix.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class UserController {
	@Autowired
	private UserService service;
	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		return ".user.login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(String id,String pwd) {
		UserVo vo=new UserVo(0,id,pwd,null,0,0);
		System.out.println(id+"asdasd");
		int n = service.login(vo);
		String redirect="";
		if(n>=0) {
			redirect=".main";
		}else {
			redirect=".user.login";
		}
		ModelAndView mv=new ModelAndView(redirect);
		return mv;
	}
	
}

package com.jhta.netflix.pay_info.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.pay_info.service.Pay_infoService;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class Pay_infoController {
	@Autowired
	private Pay_infoService service;
	@Autowired
	private UserService uservice;
	
	@RequestMapping(value="/pay/payform",method=RequestMethod.GET)
	public ModelAndView payform(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		mv.addObject("userPoint", uvo.getPoint());
		mv.setViewName(".pay.payform");
		return mv;
	}
}

package com.jhta.netflix.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class MypageController {
	@Autowired
	private UserService service;
	
	@RequestMapping(value="/mypage/myinfo",method=RequestMethod.GET)
	public ModelAndView userinfo(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo vo = service.userInfo(id);
		mv.addObject("pwd", vo.getPwd());
		mv.addObject("birth", vo.getBirth());
		mv.addObject("point", vo.getPoint());
		mv.setViewName(".mypage.myinfo");
		return mv;
	}
}

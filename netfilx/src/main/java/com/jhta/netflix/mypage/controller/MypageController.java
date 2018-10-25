package com.jhta.netflix.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.user.service.UserService;

@Controller
public class MypageController {
	@Autowired
	private UserService service;
	
	@RequestMapping(value="/mypage/myinfo",method=RequestMethod.GET)
	public String userinfo() {
		return "mypage/myinfo";
	}
}

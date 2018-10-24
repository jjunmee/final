package com.jhta.netflix.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.jhta.netflix.user.service.UserService;

@Controller
public class MypageController {
	@Autowired
	private UserService service;
	
	
}

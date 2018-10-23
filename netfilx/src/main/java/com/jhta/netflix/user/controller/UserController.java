package com.jhta.netflix.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {
	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		return ".user.login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login() {
		return ".user.login";
	}
}

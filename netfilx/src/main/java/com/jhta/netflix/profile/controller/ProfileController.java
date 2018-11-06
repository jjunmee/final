package com.jhta.netflix.profile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProfileController {
	
	@RequestMapping(value="/admin/profile")
	public String adminProfileView() {
		return ".admin.profile";
	}
}

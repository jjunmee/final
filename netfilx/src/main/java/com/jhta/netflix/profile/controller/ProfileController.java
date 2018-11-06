package com.jhta.netflix.profile.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jhta.netflix.profile.service.ProfileService;
import com.jhta.netflix.profile.vo.ProfileVo;

@Controller
public class ProfileController {
	@Autowired private ProfileService service;
	
	@RequestMapping(value="/admin/profile")
	public String adminProfileView() {
		return ".admin.profile";
	}
	@RequestMapping(value="/admin/profile/groupInput",method=RequestMethod.POST)
	public String adminProfileInsert(@RequestParam("pro_grou_name") String pro_group_name) {
		ProfileVo vo= new ProfileVo(0,pro_group_name);
		service.groupInsert(vo);
		return "redirect:/admin/profile";
	}
}

package com.jhta.netflix;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session) {
		int profile_num = (Integer)session.getAttribute("profile_num");
		if(profile_num <=0) {
			return "redirect:/profile/user/index";
		}
		return "redirect:/content/userView?profile_num="+profile_num;
	}
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "/main/main";
	}
}

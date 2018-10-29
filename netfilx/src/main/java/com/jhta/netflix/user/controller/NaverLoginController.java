package com.jhta.netflix.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.user.vo.NaverLogin;

@Controller
public class NaverLoginController {
	@Autowired private NaverLogin naverLogin;
	@Autowired
	public void setNaverLogin(NaverLogin naverLogin) {
		this.naverLogin = naverLogin;
	}
	//네이버 아이디로 로그인 이동
	@RequestMapping(value = "/user/naver")
	public ModelAndView naver(HttpSession session) {
		//네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출
		String naverAuthUrl = naverLogin.getAuthorizationUrl(session);
		//생성한 인증 URL을 view로 전달
		return new ModelAndView(".user.naver","url",naverAuthUrl);
	}
}

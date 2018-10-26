package com.jhta.netflix.user.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.SHA512;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class UserController {
	@Autowired private UserService service;
	
	//로그인 이동
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		return ".user.login";
	}
	
	//일반사용자 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(String id,String pwd) {
		UserVo vo=new UserVo(0,id,pwd,null,0,0,null);
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
	
	//일반회원가입 이동
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm() {
		return ".user.join.default";
	}
	
	//일반사용자 회원가입완료
	@RequestMapping(value = "/join/default", method = RequestMethod.POST)
	public ModelAndView defaultJoin(String id,String pwd, Date birth) {
		String pwd2= SHA512.generateSalt();
		String pw=SHA512.get_SHA_512_SecurePassword(pwd, pwd2);
		UserVo vo=new UserVo(0,id,pw,birth,0,0,pwd2);
		int n=service.defaultJoin(vo);
		String redirect="";
		ModelAndView mv=new ModelAndView(redirect);
		if(n>=0) {
			redirect=".main";
		}else {
			redirect=".user.join.default";
			mv.addObject("vo", vo);
		}
		return mv;
	}
	
	
	//가입시 사용중인 이메일인지 체크 json
	@RequestMapping(value = "/email_check_k", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> id_check(@RequestParam("id")String id,HttpServletResponse res) {
		Map<String, Object> map = new HashMap<String, Object>();
		int n=service.id_check(id);
		boolean f=false;
		if(n>0) {f=true;}
		map.put("success", f);
		return map;
	}
}

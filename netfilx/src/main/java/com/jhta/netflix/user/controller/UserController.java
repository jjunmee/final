package com.jhta.netflix.user.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.SHA512;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.validator.JoinValidator;
import com.jhta.netflix.user.validator.LoginValidator;
import com.jhta.netflix.user.vo.DefaultJoinVo;
import com.jhta.netflix.user.vo.LoginVo;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class UserController {
	@Autowired private UserService service;
	
	//일반사용자 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@Valid @ModelAttribute("LoginVo")LoginVo vo,
			BindingResult result,HttpSession session) {
		LoginValidator validator=new LoginValidator();
		validator.validate(vo,result);
		if(result.hasErrors()) {
			return ".user.login";
		}
		UserVo vo1 = service.login(vo.getId());
		if(vo1!=null) {
			String pw = SHA512.get_SHA_512_SecurePassword(vo.getPwd(), vo1.getPwd2());
			if(vo1.getPwd().equals(pw)) {
				session.setAttribute("id", vo.getId());
				session.setAttribute("sts", vo1.getSts());
				return ".main";
			}else {
				return ".user.login";
			}
		}else {
			return ".user.login";
		}
	}
	
	//일반회원가입 이동
	@RequestMapping(value = "/joinSel", method = RequestMethod.GET)
	public String joinSel() {
		return ".user.join.index";
	}
	
	//일반사용자 회원가입완료
	@RequestMapping(value = "/join/default", method = RequestMethod.POST)
	public ModelAndView defaultJoin(@Valid @ModelAttribute("DefaultJoinVo")DefaultJoinVo vo,
			BindingResult result) {
		JoinValidator validator=new JoinValidator();
		validator.validate(vo,result);
		if(result.hasErrors()) {
			return new ModelAndView(".user.join.default");
		}
		String pwd2= SHA512.generateSalt();
		String pw=SHA512.get_SHA_512_SecurePassword(vo.getPwd(), pwd2);
		SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
		Date birth = null;
		try {
			birth = dateForm.parse(vo.getBirth());
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		UserVo vo1=new UserVo(0,vo.getId(),pw,birth,0,0,pwd2);
		int n=service.defaultJoin(vo1);
		String redirect="";
		if(n>=0) {
			redirect=".main";
		}else {
			redirect=".user.join.default";
		}
		ModelAndView mv=new ModelAndView(redirect);
		mv.addObject("vo", vo1);
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

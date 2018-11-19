package com.jhta.netflix.user.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.SHA512;
import com.jhta.netflix.lib.UserStatus;
import com.jhta.netflix.user.service.CertificationService;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.validator.JoinValidator;
import com.jhta.netflix.user.validator.LoginValidator;
import com.jhta.netflix.user.vo.CertificationVo;
import com.jhta.netflix.user.vo.DefaultJoinVo;
import com.jhta.netflix.user.vo.LoginVo;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class UserController {
	@Autowired private UserService service;
	
	@Autowired private CertificationService cer_service;
	
	@Autowired private JavaMailSender mailSender;
	
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
				session.setAttribute("users_num", vo1.getUsersNum());
				session.setAttribute("id", vo.getId());
				session.setAttribute("sts", vo1.getSts());
				return "redirect:/profile/user/index";
			}else {
				return ".user.login";
			}
		}else {
			return ".user.login";
		}
	}
	
	//회원가입 이동
	@RequestMapping(value = "/join/default", method = RequestMethod.GET)
	public String joinSel() {
		return "/user/join/default";
	}
	
	//일반사용자 회원가입완료
	@RequestMapping(value = "/join/default", method = RequestMethod.POST)
	public String defaultJoin(@Valid @ModelAttribute("DefaultJoinVo")DefaultJoinVo vo,
			BindingResult result,HttpServletRequest req,HttpSession session) {
		JoinValidator validator=new JoinValidator();
		validator.validate(vo,result);
		if(result.hasErrors()) {
			return "/user/join/default";
		}
		String pass_key = cer_service.getInfo(Integer.parseInt(req.getParameter("passNum")));
		String pass_check = req.getParameter("passCheck");
		if(!pass_key.equals(pass_check)) {
			return "/user/join/default";
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
		UserVo vo1=new UserVo(0,vo.getId(),pw,birth,0,UserStatus.TRUE_USER,pwd2);
		int n=service.defaultJoin(vo1);
		if(n>=0) {
			session.setAttribute("id",vo.getId());
			session.setAttribute("sts", UserStatus.TRUE_USER);
			return "redirect:/profile/user/index";
		}else {
			return "/user/join/default";
		}
	}
	
	
	//가입시 사용중인 이메일인지 체크 json
	@RequestMapping(value = "/email_check_k", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> id_check(@RequestParam("id")String id,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		int n=service.id_check(id);
		boolean f=false;
		String pass=null;
		int ser_no=0;
		if(n==0) {
				try {
					//메일보낸 pass와 동일한지 검사할 인증  key
					pass = SHA512.generateSalt();
					SimpleMailMessage mailMsg=new SimpleMailMessage();
					mailMsg.setSubject("WATFLIX 회원가입 본인인증 메일");
					mailMsg.setText("인증을 위한 보안키 '"+ pass +"'를 입력해주세요");
					mailMsg.setTo(id);
					mailMsg.setFrom("admin@watflix.com");
					//번호 가져와서 인서트
					ser_no = cer_service.maxNo()+1;
					CertificationVo vo = new CertificationVo(ser_no, pass);
					int row=cer_service.insert(vo);
					if(row>0) {
						mailSender.send(mailMsg);
						map.put("sertification", ser_no);
						f=true;
					}else {
						f=false;
					}
				}catch(Exception e) {
					f=false;
				}
		}
		map.put("success", f);
		return map;
	}
	//logout
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return ".main";
	}
	
	//관리자페이지에서 회원리스트 뿌리기
	public ModelAndView userlist(@RequestParam(value="pageNum",defaultValue="1")int pageNum,@RequestParam(value="pageNum",defaultValue="-1")int sts) {
		ModelAndView mv = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sts", sts);
		
		return mv;
	}
}

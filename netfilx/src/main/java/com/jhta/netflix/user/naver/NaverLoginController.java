package com.jhta.netflix.user.naver;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class NaverLoginController {
	/* NaverLoginBO */
	private NaverLoginBo naverLoginBO;
	private String apiResult = null;
	@Autowired private UserService service;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBo naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	//로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/loginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session, 0);
		//네이버 
		model.addAttribute("url", naverAuthUrl);
		/* 생성한 인증 URL을 View로 전달 */
		return ".user.login";
	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/user/naver", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
	    apiResult = naverLoginBO.getUserProfile(oauthToken);
	    JSONObject json = new JSONObject(apiResult);
	    JSONObject json1 = new JSONObject(oauthToken);
	    String id = (String)json.getJSONObject("response").getString("email");
	    ModelAndView mv=null;
	    //아이디 조회
	    UserVo vo=service.login(id);
	    if(vo!=null) {
	    	session.setAttribute("id", id);
	    	session.setAttribute("sts", vo.getSts());
	    	session.setAttribute("access_token", json1.getJSONObject("rowResponse").getString("access_token"));
	    	session.setAttribute("tokenType", json1.getJSONObject("rowResponse").getString("tokenType"));
	    	session.setAttribute("refresh_token", json1.getJSONObject("rowResponse").getString("refresh_token"));
	    	mv= new ModelAndView(".main");
	    }else{
	    	mv=new ModelAndView(".user.login");
	    	mv.addObject("errMSG", "가입되어있는 아이디가 없습니다.");
	    }
        /* 네이버 로그인 성공 페이지 View 호출 */
		return mv;
	}
}

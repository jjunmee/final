package com.jhta.netflix.user.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.jhta.netflix.lib.UserStatus;
import com.jhta.netflix.user.naver.NaverLoginBo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class NaverLoginController {
	/* NaverLoginBO */
	@Autowired private NaverLoginBo naverLoginBO;
	private String apiResult = null;
	@Autowired private UserService service;
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBo naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	//로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/loginForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("url", naverAuthUrl);
		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String google_url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		System.out.println(google_url);
		model.addAttribute("google_url", google_url);
		/* 생성한 인증 URL을 View로 전달 */
		return ".user.login";
	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/user/naver", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		//collback 구분을 위한 설정
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
	    if(vo==null) {
	    	vo=new UserVo(0,id,json1.getString("accessToken").toString(),null,0,UserStatus.TRUE_USER,null);
	    	service.defaultJoin(vo);
	    	session.setAttribute("sts", UserStatus.TRUE_USER);
	    }else {
	    	session.setAttribute("sts", vo.getSts());
	    }
	    session.setAttribute("id", id);
	    session.setAttribute("sns", "naver");
	    session.setAttribute("accessToken", json1.getString("accessToken").toString());
	    session.setAttribute("tokenType", json1.getString("tokenType").toString());
	    session.setAttribute("refreshToken", json1.getString("refreshToken").toString());
	    mv= new ModelAndView(".main");
        /* 네이버 로그인 성공 페이지 View 호출 */
		return mv;
	}
	
}

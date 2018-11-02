package com.jhta.netflix.user.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jhta.netflix.lib.UserStatus;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class GoogleLoginController {
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	@Autowired private UserService service;

	// 구글 Callback호출 메소드
	@RequestMapping(value = "/user/google", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(@RequestParam String code,HttpSession session) throws IOException {
		 
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
        AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
                null);
 
        String accessToken = accessGrant.getAccessToken();
        Long expireTime = accessGrant.getExpireTime();
        if (expireTime != null && expireTime < System.currentTimeMillis()) {
            accessToken = accessGrant.getRefreshToken();
        }
        Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
        Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
        PlusOperations plusOperations = google.plusOperations();
        Person profile = plusOperations.getGoogleProfile();
        String id = profile.getAccountEmail();
        UserVo vo= service.login(id);
        String path = "";
        if(vo==null) {
        	System.out.println(UserStatus.TRUE_USER);
	    	vo=new UserVo(0,id,accessToken,null,0,UserStatus.TRUE_USER, null);
	    	service.defaultJoin(vo);
	    	session.setAttribute("sts", UserStatus.TRUE_USER);
	    	path=".main";
	    }else {
	    	session.setAttribute("sts", vo.getSts());
	    	path=".main";
	    }
	    session.setAttribute("id", id);
	    session.setAttribute("sns", "google");
	    session.setAttribute("accessToken", accessToken);
	    return path;
	}
}

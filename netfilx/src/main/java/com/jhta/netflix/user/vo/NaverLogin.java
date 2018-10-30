package com.jhta.netflix.user.vo;

import javax.servlet.http.HttpSession;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.jhta.netflix.user.model.NaverLoginApi;

public class NaverLogin {
	private final static String CLIENT_ID = "ZxZeXVmBP7JrDzS9rW3c";
	private final static String CLIENT_SECRET = "JbufpSZkrH";
	private final static String REDIRECT_URI = "http://localhost:8080/netflix/user/naver";

	/* 네아로 인증 URL생성 매소드 */
	public String getAuthorizationUrl(HttpSession session) {

		/* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).state("RANDOM_STRING").build(NaverLoginApi.instance());
		return oauthService.getAuthorizationUrl();
	}
}

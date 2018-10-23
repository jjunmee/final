<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<h1>로그인페이지</h1>
	<form method="POST" action="<c:url value='/login' />" >
		<input type="text" id="id" name="id" class="" tabindex="1" alt="아이디" placeholder="이메일">
		<input type="text" id="pwd" name="pwd" class="" tabindex="2" alt="비밀번호" placeholder="비밀번호">
		<button type="submit" tabindex="3">로그인</button>
		<input type="button" tabindex="4" value="회원가입">
		<button type="reset" tabindex="5">취소</button>
	</form>
</div>
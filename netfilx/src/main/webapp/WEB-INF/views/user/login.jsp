<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<h1>로그인페이지</h1>
	<form method="POST" action="<c:url value='/login'/>" >
		<div class="form-group col-sm-3">
			<label for="id"></label>
			<input type="text" id="id" name="id" class="form-control" tabindex="1" alt="아이디" placeholder="이메일">
		</div>
		<div class="form-group col-sm-3">
			<label for="pwd"></label>
			<input type="text" id="pwd" name="pwd" class="form-control" tabindex="2" alt="비밀번호" placeholder="비밀번호">
		</div>
		<button type="submit" tabindex="3" class="btn btn-default" role="button">로그인</button>
		<a href="<c:url value='/joinForm'/>" tabindex="4" class="btn btn-default" role="button">회원가입</a>
		<button type="reset" tabindex="5" class="btn btn-default" role="button">취소</button>
	</form>
</div>
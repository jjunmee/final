<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<div>
	<h1>로그인페이지</h1>
	<form:form method="POST" action="${pageContext.request.contextPath }/login" commandName="LoginVo">
		<div class="form-group col-sm-3">
			<label for="id"></label>
			<input type="text" id="id" name="id" class="form-control" tabindex="1" alt="아이디" placeholder="이메일"><br>
			<c:if test="${!empty(errMSG) }">
			<span>${errMSG } </span><br>
			</c:if>
			<form:errors path="id"/>
		</div>
		<div class="form-group col-sm-3">
			<label for="pwd"></label>
			<input type="password" id="pwd" name="pwd" class="form-control" tabindex="2" alt="비밀번호" placeholder="비밀번호">
			<form:errors path="pwd"/>
		</div>
		<button type="submit" tabindex="3" class="btn btn-default" role="button">로그인</button>
		<a href="<c:url value='/joinSel'/>" tabindex="4" class="btn btn-default" role="button">회원가입</a>
		<button type="reset" tabindex="5" class="btn btn-default" role="button">취소</button>
		<a href="${url }"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
	</form:form>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<a href="<c:url value='/loginForm'/>">로그인</a><br>
	<a href="<c:url value='/survey/home'/>">설문</a><br>
	<a href="<c:url value='/content/insert'/>">컨텐츠등록</a><br>
	<a href="<c:url value='/category/category'/>">카테고리관리</a><br>
	<a href="<c:url value='/mypage/myinfo'/>">계정관리</a><br>
</div>

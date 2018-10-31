<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<h1>회원가입</h1>
<div class="form-group col-sm-3">
	<label for="defult"></label>
	<a href="<c:url value='/join/default' />" class="btn btn-default">일반회원</a>
</div>
<div class="form-group col-sm-3">
	<label for="naver"></label>
	<a href="${url }" class="btn btn-default">네이버계정가입</a>
</div>
<div class="form-group col-sm-3">
	<label for="google"></label>
	<a href="" class="btn btn-default">구글계졍가입</a>
</div>
<div class="form-group col-sm-3">
	<label for="facebook"></label>
	<a href="" class="btn btn-default">페이스북계정가입</a>
</div>


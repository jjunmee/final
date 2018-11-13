<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container">
	<form method="post" action="<c:url value='/profile/user/insert'/>" onsubmit="return pwdCk();">
	<img src="http://dmszone.com:8080/profile/1/1.jpeg" width="200">
	<input type="hidden" name="pimg_num" value="1">
	<input type="text" name="nickname">
	<input type="password" name="profile_pwd" id="pwd" min="4">
	<input type="password" id="pwd1" min="4">
	<input type="submit" value="추가하기">
	<input type="checkbox" id="child_ck" name="child_ck" onchange="change_child(this.value)">
	<label for="child_ck">어린이인가요?</label>
	<input type="hidden" id="child" name="child">
	<input type="hidden" value="${first }" name="profile_first">
	<input type="button" class="btn btn-default" value="취소" onclick="javascript:history.go(-1)">
	</form> 
</div>
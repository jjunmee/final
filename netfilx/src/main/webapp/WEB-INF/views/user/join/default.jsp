<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="<c:url value='/resources/js/lib/lib.js'/>"></script>
<script src="<c:url value='/resources/js/user/join.js'/>"></script>
<form:form method="post" name="joinFrm" action="${pageContext.request.contextPath }/join/default" onsubmit="return joinFormCheck();"  commandName="DefaultJoinVo">
	<div class="body">
		<div class="form-group col-sm-3">
			<input type="text" id="id" name="id" class="form-control" tabindex="" alt="아이디" placeholder="이메일" onchange="email_check();">
			<form:errors path="id"/>
			<input type="button" class="btn btn-default" id="check" onclick="email_check_id();" value="메일전송">
			<input type="text" id="passCheck" name="passCheck" class="form-control">
			<form:errors path="passCheck"/><br>
			
			<form:errors path="email_boolean"/>
			<input type="hidden" id="email_boolean" name="email_boolean" value="false">
			<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }">
			<span id="email_ck"></span>
			<input type="hidden" name="passNum" id="passNum" />
		</div>
		<div class="form-group col-sm-3">
			<input type="password" id="pwd" name="pwd" class="form-control" tabindex="" alt="비밀번호" placeholder="비밀번호" min="8" size="32">
			<form:errors path="pwd"/>
		</div>
		<div class="form-group col-sm-3">
			<input type="password" id="pwd2" name="pwd2" class="form-control" tabindex="" alt="비밀번호확인" placeholder="비밀번호확인" min="8" size="32">
			<form:errors path="pwd2"/>
		</div>
		<div class="form-group col-sm-3">
			<input type="text" id="birth" name="birth" class="form-control" tabindex="" alt="생년월일" placeholder="주민번호 앞6자리" size="6">
			<form:errors path="birth"/>
		</div>
		<div class="form-group col-sm-3">
			<button type="submit" class="btn btn-default" tabindex="">가입하기</button>
			<input type="reset" class="btn btn-default" value="취소" onclick="javascript:history.go(-1);">
		</div>
	</div>
</form:form>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/main.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/loginform.css'/>">
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/js/lib/lib.js'/>"></script>
<script src="<c:url value='/resources/js/user/join.js'/>"></script>
<title>WATFLIX</title>
</head>
<body>
	<img id="backImg" src='<c:url value="/resources/images/mainback.jpg"/>'>
	<img id="logoImg" src='<c:url value="/resources/images/mainlogo.png"/>'>
	<div id="loginBox">
		<div id="loginBack"></div>
		<div id="loginInfo">
			<h1>회원가입</h1>
			<form:form method="post" name="joinFrm" action="${pageContext.request.contextPath }/join/default" onsubmit="return joinFormCheck();" commandName="DefaultJoinVo">
				<div class="row">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<input type="text" id="id" name="id" class="form-control" tabindex="" alt="아이디" placeholder="이메일" onchange="email_check();">
							<form:errors path="id" />
							<form:errors path="email_boolean" />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<input type="text" id="passCheck" name="passCheck" class="form-control">
							<input type="hidden" id="email_boolean" name="email_boolean" value="false"> 
							<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"> 
							<input type="hidden" name="passNum" id="passNum" />
							<form:errors path="passCheck" />
							<span id="email_ck"></span>
						</div>
						<div class="col-sm-2 col-md-2" style="margin-left: -36px;">
							<input type="button" class="btn btn-default" id="check" onclick="email_check_id();" value="메일전송">
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<input type="password" id="pwd" name="pwd" class="form-control" tabindex="" alt="비밀번호" placeholder="비밀번호" min="8" size="32">
							<form:errors path="pwd" />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<input type="password" id="pwd2" name="pwd2" class="form-control" tabindex="" alt="비밀번호확인" placeholder="비밀번호확인" min="8" size="32">
							<form:errors path="pwd2" />
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<input type="text" id="birth" name="birth" class="form-control" tabindex="" alt="생년월일" placeholder="주민번호 앞6자리" size="6">
							<form:errors path="birth" />
						</div>
					</div>
					<div class="row">
						<div class="footer">
							<button type="submit" class="btn btn-primary" tabindex="">가입하기</button>
							<input type="reset" class="btn btn-danger" value="취소" onclick="javascript:history.go(-1);">
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>

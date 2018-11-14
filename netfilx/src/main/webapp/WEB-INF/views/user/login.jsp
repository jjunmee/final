<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<title>WATFLIX</title>
</head>
<body>
	<img id="backImg" src='<c:url value="/resources/images/mainback.jpg"/>'>
	<img id="logoImg" src='<c:url value="/resources/images/mainlogo.png"/>'>
	<div id="loginBox">
		<div id="loginBack"></div>
		<div id="loginInfo">
			<h1>로그인</h1>
			<div id="">
				<form:form method="POST" action="${pageContext.request.contextPath }/login" commandName="LoginVo">
				<div class="form-group" style="margin-top: 50px">
					<input type="text" id="id" name="id" class="form-control" tabindex="1" alt="아이디" placeholder="이메일">
					<c:choose>
						<c:when test="${!empty(errMSG) }">
							<span>${errMSG } </span><br>
						</c:when>
						<c:otherwise>
							<form:errors path="id"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<input type="password" id="pwd" name="pwd" class="form-control" tabindex="2" alt="비밀번호" placeholder="비밀번호">
					<form:errors path="pwd"/>
				</div>
				<div id="loginBtn" class="form-group">
					<button type="submit" tabindex="3" class="btn btn-danger col-sm-12" role="button">로그인</button>
				</div>
				<div id="loginSns">
				<a href="${url }" class="btn btn-success">Naver Login</a>
				<a href="${google_url}" class="btn btn-primary">Google Login</a>
				</div>
				<div id="JoinInfo">
				<span style="color: white;">WATFLIX 회원이 아니신가요?  </span><a href="<c:url value='/join/default'/>" style="color: blue;">지금 가입하세요</a>
				</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html> 

	

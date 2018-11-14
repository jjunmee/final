<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		*{margin: 0px;padding: 0px;}
		#backImg{width: 2000px;}
		#logoImg{width: 300px;position: absolute;top:50px;left: 50%;transform:translate(-50%, 0%);}
		#loginBox{width: 400px;height: 600px;position: absolute;top: 50%;left: 50%;
			transform:translate(-50%, -30%);}
		#loginBack{width: 100%;height: 100%;background-color: black;opacity: 0.6;
			position: absolute;top: 0px;left: 0px;}
		#loginInfo{width: 400px;height: 600px;position: absolute;top: 0px;left: 0px;padding: 30px;}
		#loginInfo>h1{color: white;}
	</style>
</head>
<body>
	<img id="backImg" src='<c:url value="/resources/images/mainback.jpg"/>'>
	<img id="logoImg" src='<c:url value="/resources/images/mainlogo.png"/>'>
	<div id="loginBox">
		<div id="loginBack"></div>
		<div id="loginInfo">
			<h1>로그인</h1>
		</div>
	</div>
</body>
</html>
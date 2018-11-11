<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<h1>마이페이지</h1>
	<hr>
	<h2>계정</h2>
	<table>
		<tr>
			<td>이메일 : ${id }</td>
			<td><a href="">이메일주소변경</a></td>
		</tr>
		<tr>
			<td>비밀번호 : ${pwd }</td>
			<td><a href="">비밀번호변경</a></td>
		</tr>
		<tr>
			<td>생년월일 : ${birth }</td>
			<td><a href="">생년월일변경</a></td>
		</tr>
		<!-- 없으면 안보이게 처리 -->
		<tr>
			<td>포인트 : ${point }</td>
			<td><a href="">포인트충전</a></td>
		</tr>
	</table>
	<hr>
	<h2>걸제정보</h2>
	<table>
		<tr>
			<td>${payment }</td>
			<td><a href="">결제정보 업데이트</a> / <a href="">결제정보 상세정보</a></td>
		</tr>
		<tr>
			<td>${grade_name }</td>
			<td><a href="">멤버쉽 변경</a></td>
		</tr>
	</table>
	<hr>
	<h2>프로필</h2>
	<table>
		<tr>
			<td>프로필사진/프로필명</td>
		</tr>
	</table>
</div>
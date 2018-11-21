<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<style>
	#myPage>table{widht:800px;}
	#myPage table td{padding: 15px;}
</style>
<div id="myPage" class="mhdiv">
	<h1>마이페이지</h1>
	<h2>계정</h2>
	<table>
		<tr>
			<td>이메일 : ${id }</td>
			<td><!-- <a href="">이메일주소변경</a> --></td>
		</tr>
		<tr>
			<td>비밀번호 : ******</td>
			<td><!-- <a href="">비밀번호변경</a> --></td>
		</tr>
		<tr>
			<td>생년월일 : <fmt:formatDate value="${birth}" pattern="yyyy-MM-dd"/></td>
			<td><!-- <a href="">생년월일변경</a> --></td>
		</tr>
		<!-- 없으면 안보이게 처리 -->
		<tr>
			<td>포인트 : ${point }</td>
			<td><a href="<c:url value='/point/fill'/>">포인트충전</a>/<a href="<c:url value='/point/userInfo'/>">사용내역</a></td>
		</tr>
	</table>
	<h2>가입 멤버십 정보</h2>
	<table>
		<tr>
			<td>
			<c:choose>
				<c:when test="${grade_name != null}">
					종류 : ${grade_name } / 시청가능인원 : ${grade_person }명 / 만료일 : ${pay_end }
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/pay/payform'/>">멤버쉽 구매하기</a>
				</c:otherwise>
			</c:choose>
			</td>
			<td>
				<a href="<c:url value='/pay/userInfo'/>">결제내역</a>
			</td>
		</tr>
	</table>
	<h2>프로필</h2>
	<table>
		<tr>
			<td>프로필사진/ ${nickname }</td>
			<td><a href="<c:url value='/mypage/commentlist'/>">댓글 보기</a></td>
			<td><a href="<c:url value='/mypage/recordlist'/>">시청기록보기</a></td>
			<td><a href="<c:url value='/mypage/interastslist'/>">찜영상</a></td>
		</tr>
	</table>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<div class="mhdiv">
	<h1>내가 쓴 댓글</h1>
	<div>
		<form action="<c:url value='/admin/userlist'></c:url>" method="post">
			전체보기<input type="radio" name="sts" value="-1">
			일반 사용자<input type="radio" name="sts" value="0">
			관리자<input type="radio" name="sts" value="1">
			본인인증자<input type="radio" name="sts" value="2">
			성인인증자<input type="radio" name="sts" value="3">
			본인인증자 + 성인인증자<input type="radio" name="sts" value="4">
			탈퇴회원<input type="radio" name="sts" value="5">
			<input type="submit" value="검색">
		</form>
	</div>
	<table>
		<tr>
			<th>회원번호</th>
			<th>회원ID</th>
			<th>회원생년월일</th>
			<th>보유포인트</th>
			<th>회원상태</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.users_num }</td>
			<td>${vo.id }</td>
			<td>${vo.birth }</td>
			<td>${vo.point }</td>
			<td>${vo.sts }</td>
		</tr>
		</c:forEach>
	</table>
	<div>
		<c:choose>
			<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
				<a href='javascript:setPageNum(${pageUtil.startPageNum - 1 });' 
				style="color: blue;">[이전]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[이전]
			 -->
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
			<c:choose>
				<c:when test="${pu.pageNum == i }">
					<a href="<c:url value='/admin/userlist?pageNum=${i }&sts=${sts }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/admin/userlist?pageNum=${i }&sts=${sts }'></c:url>">
						<span style="color: gray;">[${i }]</span>
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
				<a href='javascript:setPageNum(${pageUtil.endPageNum + 1 });' 
				style="color: blue;">[다음]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[다음]
			 -->
			</c:otherwise>
		</c:choose>
	</div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<div class="mhdiv">
	<h1>${id } 님 포인트 사용내역</h1>
	<div>
		<form action="<c:url value='/point/userInfo'></c:url>" method="post" class="form1000">
			<select name="keyword">
				<option></option>
				<option value="사용" <c:if test="${keyword=='사용' }">selected="selected"</c:if>>사용</option>
				<option value="적립" <c:if test="${keyword=='적립' }">selected="selected"</c:if>>적립</option>
				<option value="충전" <c:if test="${keyword=='충전' }">selected="selected"</c:if>>충전</option>
			</select>
			<input type="submit" value="검색">
		</form>
	</div>
	<table>
		<tr>
			<th>구분</th>
			<th>상태</th>
			<th>금액</th>
			<th>날짜</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<c:set var="usage" value="${fn:split(vo.usage,'-')}"/>
			<c:forEach var="use" items="${usage}" varStatus="u">
				<td><c:if test="${u.count == 1 }">${use}</c:if>
				<c:if test="${u.count == 2 }">${use}</c:if>
				<c:if test="${u.count == 3 }">${use}</c:if></td>
			</c:forEach>
			<td>${vo.point_date }</td>
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
					<a href="<c:url value='/point/userInfo?pageNum=${i }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/point/userInfo?pageNum=${i }&keyword=${keyword }'></c:url>">
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
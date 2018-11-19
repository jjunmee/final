<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<div class="mhdiv">
	<h1>${id } 님 결제내역</h1>
	<div>
				<!-- 
		<form action="<c:url value='/point/userInfo'></c:url>" method="post">
			<select name="keyword">
				<option></option>
				<option value="사용" <c:if test="${keyword=='사용' }">selected="selected"</c:if>>사용</option>
			</select>
			<input type="submit" value="검색">
		</form>
				 -->
	</div>
	<table>
		<tr>
			<th>시작일</th>
			<th>만료일</th>
			<th>결제방법</th>
			<th>등급명</th>
			<th>가격</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.pay_start }</td>
			<td>${vo.pay_end }</td>
			<td>${vo.payment }</td>
			<td>${vo.grade_name }</td>
			<td>${vo.grade_price }</td>
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
					<a href="<c:url value='/pay/userInfo?pageNum=${i }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/pay/userInfo?pageNum=${i }&keyword=${keyword }'></c:url>">
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
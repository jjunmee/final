<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<div class="mhdiv">
	<h1>시청내역</h1>
	<table>
		<tr>
			<th>이어보기시간</th>
			<th>누적시청시간</th>
			<th>시청컨텐츠</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.next_watch }</td>
			<td>${vo.total_time }</td>
			<td>${vo.content_name }</td>
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
					<a href="<c:url value='/mypage/recordlist?pageNum=${i }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/mypage/recordlist?pageNum=${i }&keyword=${keyword }'></c:url>">
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
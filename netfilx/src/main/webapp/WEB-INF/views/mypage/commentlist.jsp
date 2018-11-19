<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<div class="mhdiv">
	<h1>내가 쓴 댓글</h1>
	<div>
		<form action="<c:url value='/mypage/commentlist'></c:url>" method="post">
			공개<input type="checkbox" name="comment_true" value="true"<c:if test="${comment_open == true }">checked="checked"</c:if>>/
			비공개<input type="checkbox" name="comment_false" value="false"<c:if test="${comment_open == false }">checked="checked"</c:if>>/
			책갈피있음<input type="checkbox" name="bookmark_true" value="true"<c:if test="${bookmark == true }">checked="checked"</c:if>>/
			책갈피없음<input type="checkbox" name="bookmark_false" value="false"<c:if test="${bookmark == false }">checked="checked"</c:if>>/
			<input type="submit" value="검색">
		</form>
	</div>
	<table>
		<tr>
			<th>댓글내용</th>
			<th>컨텐츠명</th>
			<th>공개/비공개</th>
			<th>책갈피시간</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.comment }</td>
			<td>${vo.content_name }</td>
			<c:choose>
				<c:when test="${vo.comment_open == true}">
					<td>공개</td>
				</c:when>
				<c:otherwise>
					<td>비공개</td>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${vo.bookmark == true}">
					<td><fmt:formatNumber value="${vo.bookmark_time/60 }" pattern="0"/> : ${vo.bookmark_time%60 }</td>
				</c:when>
				<c:otherwise>
					<td>無</td>
				</c:otherwise>
			</c:choose>
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
					<a href="<c:url value='/mypage/commentlist?pageNum=${i }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/mypage/commentlist?pageNum=${i }&keyword=${keyword }'></c:url>">
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<h1>리스트</h1>
	<a href="<c:url value="/qna/insert"/>"> 글 등록 </a>
	<table width="800" border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>게시일</th>
			<th>공개/비공개</th>
			<th>글쓴이</th>
			<th>답글남기기</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.qna_num }</td>
			<td><a href='<c:url value="/qna/detail?qna_num=${vo.qna_num }"/>'>${vo.qna_title }</a></td>
			<td>${vo.qna_regdate }</td>
			<td>${vo.qna_open }</td>
			<td>${vo.users_num }</td>
			<td><a href='<c:url value="/qna/insert?qna_num=${vo.qna_num }"/>'>답글남기기</a></td>
		</tr>
		</c:forEach>
	</table>
	<br>
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
					<a href="<c:url value='/qna/list?pageNum=${i }&field=${field }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/qna/list?pageNum=${i }&field=${field }&keyword=${keyword }'></c:url>">
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
	<div>
		<form action="<c:url value='/qna/list'></c:url>" method="post">
			<select name="field">
				<option value="qna_title" <c:if test="${field=='qna_title' }">selected="selected"</c:if>>제목</option>
				<option value="id" <c:if test="${field=='id' }">selected="selected"</c:if>>작성자</option>
				<option value="qna_content" <c:if test="${field=='qna_content' }">selected="selected"</c:if>>내용</option>
			</select>
			<input type="text" name="keyword" value="${keyword }">
			<input type="submit" value="검색">
		</form>
	</div>
</div>

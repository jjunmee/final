<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<h1>리스트</h1>
	<a href="<c:url value="/qna/insert"/>"> 글 등록 </a>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>게시일</th>
			<th>공개/비공개</th>
			<th>글쓴이</th>
		</tr>
	</table>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>스테프 목록</h1>
	<select style="background-color: gray;">
		<option value="false">배우</option>
		<option value="true">감독</option>
	</select>
	<input type="text" name="keyword" style="background-color: lightgray;">
	<input type="submit" value="검색">
	<table>
		<tr>
			<th>구분</th>
			<th>이름</th>
			<th>출생년도</th>
			<th>성별</th>
			<th>데뷔작</th>
		</tr>
		<c:forEach items="${list }" var="vo">
			<tr>
				<c:choose>
					<c:when test="${vo.staff_position == false }">
						<td>배우</td>
					</c:when>
					<c:otherwise>
						<td>감독</td>
					</c:otherwise>
				</c:choose>
				<td>${vo.staff_name }</td>
				<td>${vo.staff_age }</td>
				<td>${vo.staff_gender }</td>
				<td>${vo.staff_debut }</td>
			</tr>
		</c:forEach>
	</table>
	<c:choose>
			<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
				<a href='javascript:setPageNum(${pageUtil.startPageNum - 1 });' 
				style="color: blue;">[이전]</a>
			</c:when>
			<c:otherwise>
				[이전]
			</c:otherwise>
		</c:choose>
		<c:forEach begin="${pageUtil.startPageNum }" end="${pageUtil.endPageNum }" var="i">
			<c:choose>
				<c:when test="${pageUtil.pageNum == i }">
					<a href='javascript:setPageNum(${i });' 
					style="color: red;">[${i }]</a>
				</c:when>
				<c:otherwise>
					<a href='javascript:setPageNum(${i });' 
					style="color: lightgray;">[${i }]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
				<a href='javascript:setPageNum(${pageUtil.endPageNum + 1 });' 
				style="color: blue;">[다음]</a>
			</c:when>
			<c:otherwise>
				[다음]
			</c:otherwise>
		</c:choose>
</body>
</html>
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
	<h1>컨텐츠 목록</h1>
	<table>
		<tr>
			<th>컨텐츠 번호</th>
			<th>컨텐츠 이름</th>
			<th>컨텐츠 줄거리</th>
			<th>방영/상영 일</th>
			<th>등록일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach items="${contentList }" var="vo">
			<tr>
				<td>${vo.content_num }</td>
				<td>${vo.content_name }</td>
				<td>${vo.content_summary }</td>
				<td>${vo.release_date }</td>
				<td>${vo.content_regdate }</td>
				<td>
					<a href='<c:url value="/content/update?num=${vo.content_num }"/>'>수정</a>
				</td>
				<td>
					<a href='<c:url value="/content/delete?num=${vo.content_num }"/>'>삭제</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<c:choose>
		<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
			<a href='<c:url value="/content/list?pageNum=${pageUtil.startPageNum - 1 }"/>'
			style="color: blue;">[이전]</a>
		</c:when>
		<c:otherwise>
			[이전]
		</c:otherwise>
	</c:choose>
	<c:forEach begin="${pageUtil.startPageNum }" end="${pageUtil.endPageNum }" var="i">
		<c:choose>
			<c:when test="${pageUtil.pageNum == i }">
				<a href='<c:url value="/content/list?pageNum=${i }"/>' 
				style="color: red;">[${i }]</a>
			</c:when>
			<c:otherwise>
				<a href='<c:url value="/content/list?pageNum=${i }"/>' 
				style="color: lightgray;">[${i }]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
			<a href='<c:url value="/content/list?pageNum=${pageUtil.endPageNum + 1 }"/>'
			style="color: blue;">[다음]</a>
		</c:when>
		<c:otherwise>
			[다음]
		</c:otherwise>
	</c:choose>
</body>
</html>






















<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		function setPageNum(pageNum) {
			$("#pageNum").val(pageNum);
			$("#listForm").submit();
		}
		function deleteStaff(num) {
			var pageNum = $("#pageNum").val();
			var position = $("#position").val();
			var keyword = $("#keyword").val();
			location.href='<c:url value="/staff/delete'
			+'?pageNum='+pageNum+'&position='+position
			+'&keyword='+keyword+'&num='+num+'"/>';
		}
	</script>
</head>
<body>
	<h1>스테프 목록</h1>
	<form id="listForm" action='<c:url value="/staff/list"/>' method="post">
		<select id="position" name="position" onchange="submit()" style="background-color: gray;">
			<option value="false"
				<c:if test="${position == false }">selected="selected"</c:if>
				>배우</option>
			<option value="true"
				<c:if test="${position == true }">selected="selected"</c:if>
				>감독</option>
		</select>
		<input type="text" placeholder="이름" id="keyword" name="keyword" value="${keyword }" 
			style="background-color: lightgray;">
		<input type="submit" value="검색">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageUtil.pageNum }">
		<table>
			<tr>
				<th>구분</th>
				<th>이름</th>
				<th>출생년도</th>
				<th>성별</th>
				<th>데뷔작</th>
				<th>수정</th>
				<th>삭제</th>
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
					<td>
						<a href='<c:url value="/staff/update?num=${vo.staff_num }"/>'>수정</a>
					</td><!-- 수정작업! -->
					<td>
						<a href='javascript:deleteStaff(${vo.staff_num });'>삭제</a>
					</td>
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
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		#listBox{width: 1100px;margin: auto;text-align: right;}
		#listBox>h1,#pageDiv{text-align: left;}
		#listTable{width: 1100px;}
		.updateA{color: skyblue;}
		.deleteA{color: pink;}
		p{text-overflow: ellipsis;overflow: hidden;width: 435px;height: 15px;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		function setPageNum(pageNum) {
			$("#pageNum").val(pageNum);
			$("#listForm").submit();
		}
	</script>
</head>
<body>
	<div id="listBox">
		<h1>컨텐츠 목록</h1>
		<form id="listForm" action='<c:url value="/content/list"/>' method="post">
			<select name="sort" onchange="submit()">
				<option value="recommend"
				<c:if test="${sort == 'recommend' }">selected="selected"</c:if>
				>추천컨텐츠</option>
				<option value="date"
				<c:if test="${sort == 'date' }">selected="selected"</c:if>
				>출시일순</option>
				<option value="asc"
				<c:if test="${sort == 'asc' }">selected="selected"</c:if>
				>오름차순</option>
				<option value="desc"
				<c:if test="${sort == 'desc' }">selected="selected"</c:if>
				>내림차순</option>
			</select>
			<table id="listTable" class="table">
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
						<td><p>${vo.content_summary }</p></td>
						<td>${vo.release_date }</td>
						<td>${vo.content_regdate }</td>
						<td>
							<a class="updateA" href='<c:url value="/content/update?num=${vo.content_num }"/>'>수정</a>
						</td>
						<td>
							<a class="deleteA" href='<c:url value="/content/delete?num=${vo.content_num }"/>'>삭제</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div id="pageDiv">
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
			</div>
			<br>
			<input type="hidden" id="pageNum" name="pageNum" value="${pageUtil.pageNum }">
			<input type="text" placeholder="제목" name="keyword" value="${keyword }">
			<input type="submit" value="검색" class="btn btn-default btn-sm">
		</form>
	</div>
</body>
</html>





















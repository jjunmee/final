<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
<h1>분류</h1>
	<form method="post" action='<c:url value="/category/insert"/>'>
		분류 
		<input type="text" name="category_name">
		<input type="submit" value="추가">
	</form>
	<form method="post" action='<c:url value="/category/update/"/>'>
		<table border="1" width="800">
			<tr>
				<th>분류</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach items="${clist }" var="vo">
				<tr>
					<td><input type="text" value="${vo.category_name }"></td>
				</tr>
				<tr>
					<td><input type="submit" value="수정"></td>
				</tr>
				<tr>
					<td><a href="${pageContext.request.contextPath }/category/delete?num=${vo.category_num}">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
<h1>장르</h1>
	<form method="post" action="genre/insert">
		장르 
		<input type="text" name="genre_name">
		<input type="submit" value="추가">
	</form>
		<table>
			<tr>
				<th>장르</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach items="${list }" var="vo">
			<tr>
				<td><input type="text" value="${vo.genre_name }"></td>
			</tr>
			<tr>
				<td><a href="${pageContext.request.contextPath }/category/update?num=${vo.genre_num}">수정</a></td>
			</tr>
			<tr>
				<td><a href="${pageContext.request.contextPath }/category/delete?num=${vo.genre_num}">삭제</a></td>
			</tr>
			</c:forEach>
		</table>
</div>

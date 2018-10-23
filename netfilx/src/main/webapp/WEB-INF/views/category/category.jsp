<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
<h1>분류</h1>
	<form method="post" action="category/insert">
		분류 
		<input type="text" name="category">
		<input type="submit" value="추가">
	</form>
		<table>
			<tr>
				<th>장르</th>
				<th>삭제</th>
			</tr>
			<tr>
				<td><input type="text" value=""></td>
			</tr>
		</table>
</div>

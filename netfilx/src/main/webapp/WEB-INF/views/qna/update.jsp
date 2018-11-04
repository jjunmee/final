<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	input[type=text], select, textarea {
	    background-color: #999;
	    color: #fff;
	}
	
	input[type=submit] {
	    background-color: #ddd;
	    color: white;
	}
	
	input[type=submit]:hover {
	    background-color: #000;
	}
</style>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div>
	<h1>UPDATE</h1>
	<form method="post" action='<c:url value="/qna/update"/>'>
		<input type="hidden" name="qna_num" value="${qna_num}">
		<table width="800" border="1">
			<tr>
				<th>TITLE</th>
				<td><input type="text" name="qna_title" value="${qna_title }"></td>
			</tr>
			<tr>
				<th>CONTENT</th>
				<td><textarea rows="5" cols="20" name="qna_content">${qna_content }</textarea></td>
			</tr>
			<tr>
				<th>OPEN/CLOSED</th>
				<td>
					<c:choose>
						<c:when test="${step == 0}">
							OPEN<input type="radio" name="qna_open" value="1">
							CLOSED<input type="radio" name="qna_open" value="0">
						</c:when>
						<c:otherwise>
							<input type="hidden" name="qna_open" value="${qna_open }">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				id ${id}<br>
				<input type="submit" value="수정">
				</td>
			</tr>
		</table>
	</form>
</div>

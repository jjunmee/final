<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div>
	<h1>INSERT</h1>
	<form method="post" action='<c:url value="/qna/insert"/>'>
		<input type="hidden" name="qna_num" value="${qna_num}">
		<table width="800" border="1">
			<tr>
				<th>TITLE</th>
				<td><input type="text" name="qna_title" value="${qna_title }"></td>
			</tr>
			<c:choose>
				<c:when test="${qna_num == 0}">
					<tr>
						<th>CONTENT</th>
						<td>
							<textarea rows="5" cols="20" name="qna_content"></textarea>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th>CONTENT</th>
						<td>
							${qna_content }
						</td>
					</tr>
					<tr>
						<th>ANSWER</th>
						<td>
							<textarea rows="5" cols="20" name="qna_content"></textarea>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th>OPEN/CLOSED</th>
				<td>
					<c:choose>
						<c:when test="${qna_num == 0}">
							OPEN<input type="radio" name="qna_open" value="true">
							CLOSED<input type="radio" name="qna_open" value="false">
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${qna_open == true}">
									OPEN
								</c:when>
								<c:otherwise>
									CLOSED
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="qna_open" value="${qna_open }">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="등록">
				</td>
			</tr>
		</table>
	</form>
</div>

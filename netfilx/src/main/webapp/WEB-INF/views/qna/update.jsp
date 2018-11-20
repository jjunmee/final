<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div class="mhdiv">
	<h1>UPDATE</h1>
	<form method="post" action='<c:url value="/qna/update"/>' class="form1000">
		<input type="hidden" name="qna_num" value="${qna_num}">
		<table width="800" border="1">
			<tr>
				<th>TITLE</th>
				<td><input type="text" name="qna_title" value="${qna_title }"></td>
			</tr>
			<c:choose>
				<c:when test="${qna_state == '답변대기'}">
					<tr>
						<th>CONTENT</th>
						<td><textarea rows="5" cols="20" name="qna_content">${qna_content }</textarea></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th>CONTENT</th>
						<td>
							${u_qna_content }
						</td>
					</tr>
					<tr>
						<th>ANSWER</th>
						<td><textarea rows="5" cols="20" name="qna_content">${qna_content }</textarea></td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<th>OPEN/CLOSED</th> 
				<td>
					<c:choose>
						<c:when test="${step == 0}">
							OPEN<input type="radio" name="qna_open" value="1" <c:if test="${qna_open== true}">checked="checked"</c:if>>
							CLOSED<input type="radio" name="qna_open" value="0" <c:if test="${qna_open== false}">checked="checked"</c:if>>
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

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
<div>
	<h1>글 수정</h1>
	<table width="800" border="1">
		<tr>
			<th>TITLE</th>
			<td>${qna_title }</td>
		</tr>
		<c:choose>
			<c:when test="${qna_state == '답변완료'}">
				<tr>
					<th>CONTENT</th>
					<td>
						${qna_content }
					</td>
				</tr>
				<tr>
					<th>
						ANSWER
					</th>
					<td>
						<span style="color:red">답변이 완료된 글은 수정이 불가합니다.</span>
						<br>
						${a_qna_regdate}
						<br>
						re: ${a_qna_content}
					</td>
				</tr>
				<tr>
					<th>
						답변일
					</th>
					<td>
						${a_qna_regdate}
					</td>
				</tr>
			</c:when>
			<c:when test="${qna_state == '답변대기'}">
				<tr>
					<th>CONTENT</th>
					<td>
						${qna_content }
					</td>
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
					<td>
						${qna_content }
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
		<tr>
			<th>OPEN/CLOSED</th>
			<td>
				<c:choose>
					<c:when test="${qna_open == 1}">
						비공개
					</c:when>
					<c:otherwise>
						공개
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:choose>
					<c:when test="${qna_state == '답변완료'}">
						<a href='<c:url value="/qna/delete?qna_num=${qna_num }&step=${step }"/>'>삭제</a>
					</c:when>
					<%-- 답변이고 관리자일때 --%>
					<c:when test="${qna_state != '답변'}">
						<a href='<c:url value="/qna/update?qna_num=${qna_num }&step=${step }"/>'>수정</a>
					<%-- 답변이고 관리자일때 삭제할때 --%>
						<a href='<c:url value="/qna/delete?qna_num=${u_qna_num }&step=${step }"/>'>삭제</a>
					</c:when>
					<c:otherwise>
						<a href='<c:url value="/qna/update?qna_num=${qna_num }&step=${step }"/>'>수정</a>
						<a href='<c:url value="/qna/delete?qna_num=${qna_num }&step=${step }"/>'>삭제</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</div>
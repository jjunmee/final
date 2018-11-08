<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div>
	<h1>리스트</h1>
	<a href="<c:url value="/qna/insert"/>"> 글 등록 </a>
	<table>
		<tr>
			<th></th>
			<th>TITLE</th>
			<th>RAGDATE</th>
			<th>OPEN/CLOSED</th>
			<th>ID</th>
			<th>STATE</th>
			<th></th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<!-- 답변은 번호 말고 답변이라고 적기 -->
			<c:choose>
				<c:when test="${vo.step == 0 }">
					<td>문의.${vo.qna_num }</td>
				</c:when>
				<c:otherwise>
					<td>답변</td>
				</c:otherwise>
			</c:choose>
			<!-- 비공개라면 등록한 users_num과 등록한사람의 users_num이 같을경우에만 볼 수 있게 -->
			<td><a href='<c:url value="/qna/detail?qna_num=${vo.qna_num }&qna_open=${vo.qna_open }"/>'>${vo.qna_title }</a></td>
			<td>${vo.qna_regdate }</td>
			<c:choose>
				<c:when test="${vo.qna_open == true }">
					<td>공개</td>
				</c:when>
				<c:otherwise>
					<td>비공개</td>
				</c:otherwise>
			</c:choose>
			<td>${vo.id }</td>
			<!-- 답글 상태(유저의 글에만 상태 보이기) -->
			<c:choose>
				<c:when test="${vo.step == 0 }">
					<td>${vo.qna_state }</td>
				</c:when>
			</c:choose>
			<!-- 관리자일 때만 답글 남기기 -->
			<c:choose>
				<c:when test="${vo.qna_state == '답변대기' && userSts == 1}">
					<td><a href='<c:url value="/qna/insert?qna_num=${vo.qna_num }"/>'>답글남기기</a></td>
				</c:when>
			</c:choose>
		</tr>
		</c:forEach>
	</table>
	<br>
	<div>
		<c:choose>
			<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
				<a href='javascript:setPageNum(${pageUtil.startPageNum - 1 });' 
				style="color: blue;">[이전]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[이전]
			 -->
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
			<c:choose>
				<c:when test="${pu.pageNum == i }">
					<a href="<c:url value='/qna/list?pageNum=${i }&field=${field }&keyword=${keyword }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/qna/list?pageNum=${i }&field=${field }&keyword=${keyword }'></c:url>">
						<span style="color: gray;">[${i }]</span>
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
				<a href='javascript:setPageNum(${pageUtil.endPageNum + 1 });' 
				style="color: blue;">[다음]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[다음]
			 -->
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<form action="<c:url value='/qna/list'></c:url>" method="post">
			<select name="field">
				<option value="qna_title" <c:if test="${field=='qna_title' }">selected="selected"</c:if>>제목</option>
				<option value="id" <c:if test="${field=='id' }">selected="selected"</c:if>>작성자</option>
				<option value="qna_content" <c:if test="${field=='qna_content' }">selected="selected"</c:if>>내용</option>
			</select>
			<input type="text" name="keyword" value="${keyword }">
			<input type="submit" value="검색">
		</form>
	</div>
</div>

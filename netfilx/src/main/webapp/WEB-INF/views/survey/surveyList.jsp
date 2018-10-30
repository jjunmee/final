<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	$(function(){
		
	});

</script>


<div id="tab">
	<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>&nbsp;
	<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>&nbsp;
	<a href="<c:url value='/survey/surveyInsert1'/>">설문등록하러가기</a>
</div>
<div id="listBox">
		
	<table class="jhTable" border="1">
		<tr>
			<th>설문번호</th><th>설문제목</th><th>조사인원</th><th>배당금</th><th>마감기한</th>
		</tr>
		<c:set var="num" value="${fn:length(list) }"/>
		<c:forEach var="vo" items="${list }">
			<tr>
				<td>${num }</td>
				<td>${vo.surveyName }</td>
				<td><span id="joinNum">${vo.joinNum }</span></td>
				<td>${Math.round(vo.spoint/vo.joinNum) }포인트</td>
				<c:choose>
					<c:when test="${code==1 }">
						<td>${vo.surveyEnd }</td>
					</c:when>
					<c:when test="${code==2 }">
						<td>${vo.surveyStart }</td>
					</c:when>
				</c:choose>				
			</tr>
			<c:set var="num" value="${num-1 }"/>
		</c:forEach>	
	</table>
		
	
	
</div>
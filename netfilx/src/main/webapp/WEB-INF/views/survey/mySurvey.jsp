<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	

</script>
<div><input type="button" onclick="location='<c:url value="/survey/surveyInsert1"/>'" value="설문구매하러가기"></div>
<div class="surveyList">
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/mySurvey'/>">설문등록하러가기</a>
		</div>
	</div>
	
	<div id="myListBox" class="centerBox">			
		<table>
			<tr>
				<th>번호</th>
				<th>설문제목</th>
				<th>조사인원</th>
				<th>결제금액</th>
				<th>설문현황</th>				
			</tr>
			<c:set var="num" value="1"/>
			<c:forEach var="vo" items="${list1 }">
				<tr>
					<td>${num }</td>
					<td><a href="<c:url value='/survey/update?surveyNum=${vo.surveyNum }'/>">${vo.surveyName }</a></td>
					<td>${vo.joinNum }</td>
					<td>${vo.spoint }포인트</td>
					<td>${vo.state }</td>								
				</tr>
				<c:set var="num" value="${num+1 }"/>
			</c:forEach>	
			<c:forEach var="vo" items="${list2 }">
				<tr>
					<td>${num }</td>
					<td>${vo.surveyName }</td>
					<td>${vo.joinNum }</td>
					<td>${vo.spoint }포인트</td>
					<td>${vo.state }</td>								
				</tr>
				<c:set var="num" value="${num+1 }"/>
			</c:forEach>	
			<c:forEach var="vo" items="${list3 }">
				<tr>
					<td>${num }</td>
					<td>${vo.surveyName }</td>
					<td>${vo.joinNum }</td>
					<td>${vo.spoint }포인트</td>
					<td>${vo.state }</td>								
				</tr>
				<c:set var="num" value="${num+1 }"/>
			</c:forEach>	
		</table>
			
	
	</div>
</div>
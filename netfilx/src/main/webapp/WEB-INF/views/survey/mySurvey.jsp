<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	

</script>
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 90px;height:700px;}
	.surveyList .topBox{padding-left: 14%;padding-bottom: 10px;}
	.surveyList .topBox .delBox{float:left;margin-top: 15px;}
	.surveyList .topBox .surBtn{float:auto;margin-left: 425px;}
	.surveyList .leftBox{width:14%;height:100%;float: left} 
	.surveyList .centerBox{width:78%;float:left}
</style>
<div class="surveyList">
	<div class="topBox">
		<div class="delBox"><a href="<c:url value='/survey/delete'/>">삭제</a></div>
		<div class="surBtn"><input type="button" class="surBtn" onclick="location='<c:url value="/survey/surveyInsert1"/>'" value="설문구매하러가기"></div>
	</div>
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/mySurvey'/>">나의 설문지</a>
		</div>
	</div>
	
	<div id="myListBox" class="centerBox">			
		<table>
			<tr>
				<th><input type="checkbox"></th>
				<th>번호</th>
				<th>설문제목</th>
				<th>조사인원</th>
				<th>결제금액</th>
				<th>설문현황</th>				
			</tr>
			<c:set var="num" value="1"/>
			<c:forEach var="vo" items="${list1 }">
				<tr>
					<td><input type="checkbox" value="${vo.surveyNum }"></td>
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
					<td><input type="checkbox" value="${vo.surveyNum }"></td>
					<td>${num }</td>
					<td><a href="<c:url value='/survey/stats?surveyNum=${vo.surveyNum}'/>">${vo.surveyName }</td>
					<td>${vo.joinNum }</td>
					<td>${vo.spoint }포인트</td>
					<td>${vo.state }</td>								
				</tr>
				<c:set var="num" value="${num+1 }"/>
			</c:forEach>	
			<c:forEach var="vo" items="${list3 }">
				<tr>
					<td><input type="checkbox" value="${vo.surveyNum }"></td>
					<td>${num }</td>
					<td><a href="<c:url value='/survey/stats?surveyNum=${vo.surveyNum}'/>">${vo.surveyName }</td>
					<td>${vo.joinNum }</td>
					<td>${vo.spoint }포인트</td>
					<td>${vo.state }</td>								
				</tr>
				<c:set var="num" value="${num+1 }"/>
			</c:forEach>	
		</table>
			
	
	</div>
</div>
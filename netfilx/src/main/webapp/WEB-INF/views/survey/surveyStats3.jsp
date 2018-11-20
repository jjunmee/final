<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link type='text/css' href="<c:url value='/resources/css/survey.css'/>" rel='stylesheet' media='screen' />
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 90px;height:auto;overflow: hidden}
	.surveyList .surBtn{padding-left: 73%;padding-bottom: 10px;}
	.surveyList .leftBox{width:14%;float: left} 
	.surveyList .centerBox{width:78%;float:left} 
</style>
<script type="text/javascript">
function idCheck(n){
	var userId=document.getElementById("userId");
	if(userId.getAttribute("value")==null || userId.getAttribute("value")==''){
		alert('먼저 로그인을 해주세요');
	}else{
		if(n==0){//나의설문지
			location.href="<c:url value='/survey/mySurvey'/>";
		}else if(n==1){//설문구매
			location.href="<c:url value='/survey/surveyInsert1'/>";
		}
	}
}
</script>
<div class="surveyList">
	<div class="surBtn"><input type="button" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="javascript:idCheck(0);">나의 설문지</a>
		</div>
	</div>
	
	<div id="myBox" class="centerBox">
		<div id="surveyName">
			${surveyVo.surveyName }<br>
			${sqTitle }
		</div>
		<div id="qNums">
			<c:forEach var="i" begin="1" end="${qNums }">
				<a href="<c:url value='/survey/stats?surveyNum=${surveyVo.surveyNum }&qNum=${i }'/>">${i }</a>
			</c:forEach>
		</div>
		<div id="chart_div">
			<c:forEach var="i" begin="0" end="${fn:length(ansList)-1 }">
				${ansList[i].srAnswer }<br>
			</c:forEach>
		</div>
		
		 
	</div>
	<input type="hidden" id="userId" value="${sessionScope.id }">
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link type='text/css' href="<c:url value='/resources/css/survey.css'/>" rel='stylesheet' media='screen' />
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 90px;height:auto;overflow: hidden}
	 
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart', 'bar']});
	google.charts.setOnLoadCallback(drawMultSeries);
	 
	function drawMultSeries() {	
		var data = google.visualization.arrayToDataTable([
			${strConcat}
		]);
		var options = { 
			title: '${sqTitle}',
			width:1000,
			
			chartArea: {width: '50%'},
			tooltip:{textStyle : {fontSize:12}, showColorCode : true},
	
			hAxis: {
				title: '',
				minValue: 0
			},
			vAxis: {
				title: ''
			}
		};
		var chart=new google.visualization.BarChart(document.getElementById('chart_div'));
		chart.draw(data,options);
		//window.addEventListener('resize', function() { chart.draw(data, barChartOption); }, false);
		
	}
    
	function idCheck(n){
		if(n==0){//나의설문지
			location.href="<c:url value='/survey/mySurvey'/>";
		}else if(n==1){//설문구매
			location.href="<c:url value='/survey/surveyInsert1'/>";
		}
	}
</script>
<div class="surveyList">
	<div id="tab" class="leftBox">
		<c:if test="${userSts=='user' }">
			<div class="surBtn"><input type="button" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
		</c:if>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">진행중인 설문지</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문지</a>
		</div>
		<c:if test="${userSts=='user' }">
			<div class="leftDivBox">
				<a href="javascript:idCheck(0);">나의 설문지</a>
			</div>
		</c:if>
	</div>
	<div id="myBox" class="centerBox">
		<div id="surveyName">
			<h3>${surveyVo.surveyName }</h3>
		</div>
		<div id="chart_div" style="margin-top: 15px;">
			
		</div>
		<div id="qNums" style="margin-top: 15px;">
			<c:forEach var="i" begin="1" end="${qNums }">
				<c:if test="${i==qNum }">
					<span style="color:white">[ ${i }번 ]&nbsp;</span>
				</c:if>
				<c:if test="${i!=qNum }">				
					<a href="<c:url value='/survey/stats?surveyNum=${surveyVo.surveyNum }&qNum=${i }'/>">[ ${i }번 ]&nbsp;</a>
				</c:if>
			</c:forEach>
		</div>
		
		 
	</div>
	<input type="hidden" id="userId" value="${sessionScope.id }">
</div>
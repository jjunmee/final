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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawMultSeries);
 
function drawMultSeries() {
	var data = google.visualization.arrayToDataTable([
		${strConcat}
	]);
	var options = { 
		title: '${surveyVo.surveyName}',
		width:1000,
		height:1000,
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
			<a href="<c:url value='/survey/mySurvey'/>">나의 설문지</a>
		</div>
	</div>
	
	<div id="myBox" class="centerBox">
		<div id="chart_div">
			
		</div>
		
		 
	</div>
	
</div>
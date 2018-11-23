<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Load D3 -->
<script src="https://d3js.org/d3.v4.min.js"></script>
<!-- Load billboard.js with base style -->
<link rel="stylesheet" href="<c:url value='/resources/css/chart/billboard.css'/>">
<script src="<c:url value='/resources/js/chart/billboard.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<style>
	.bb-chart-arc path {stroke : none;}
	.bb path{stroke:none;}
	#chartDiv{margin:auto; padding-top: 25px; width: 1000px; border-radius: 3px; background-color: #555; height: 1000px;}
	#gradeNameThisCount{float: left;width: 500px; margin-top: 40px;}
	#gradeNameNextCount{float: left;width: 500px; margin-top: 40px;}
	#monthTotal{width: 950px; height: 500px; background-color: #444; clear: left; margin: auto;}
</style>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		gradeNameThisCount();
		gradeNameNextCount();
		monthTotal();
	});
	
	//이번달 등급 카운트
	function gradeNameThisCount(){
		$.ajax({
			url:"<c:url value='/chart/gradeNameThisCount'/>",
			dataType:"json",
			success:function(tc){
				var arr = new Array();
				$(tc).each(function(i,json) {
					arr.push([json.gname,json.gcount]);
				});
				var chart = bb.generate({
					data: {
						columns: arr,
						type: "donut"
					},
					donut: {
						title: "이번달 등급",
						padAngle: 0.1
					},
					tooltip:{
						show:false
					},
					legend:{
						position : "right"
					},
					bindto: "#gradeNameThisCount"
				});
			}
		});
	}
	//1달전 등급 카운트
	function gradeNameNextCount(){
		$.ajax({
			url:"<c:url value='/chart/gradeNameNextCount'/>",
			dataType:"json",
			success:function(nc){
				var arr = new Array();
				$(nc).each(function(i,json) {
					arr.push([json.gname,json.gcount]);
				});
				var chart = bb.generate({
					data: {
						columns: arr,
						type: "donut"
					},
					donut: {
						title: "1달전",
						padAngle: 0.1
					},
					tooltip:{
						show:false
					},
					legend:{
						position : "right"
					},
					bindto: "#gradeNameNextCount"
				});
			}
		});
	}
	function monthTotal(){
		$.ajax({
			url:"<c:url value='/chart/monthTotal'/>",
			dataType:"json",
			success:function(mt){
				var chart = bb.generate({
					data: {
					columns: [
						["순이익",mt.nextMonthTotal3,mt.nextMonthTotal2,mt.nextMonthTotal1,mt.thisMonthTotal],
						["멤버십결제총액",mt.mPayNextMonthSum3,mt.mPayNextMonthSum2,mt.mPayNextMonthSum1,mt.mPayThisMonthSum],
						["포인트충전",mt.pointNextMonthPay3,mt.pointNextMonthPay2,mt.pointNextMonthPay1,mt.pointThisMonthPay],
						["포인트사용",mt.pointMemNextMonthSum3,mt.pointMemNextMonthSum2,mt.pointMemNextMonthSum1,mt.pointMemThisMonthSum],
					]
					},
					legend:{
						position : "right"
					},
					tooltip:{
						show:false,
						grouped: false
					},
					axis: {
						x: {
							tick: {
								type: "timeseries"
							}
						}
					},
					bindto: "#monthTotal"
				});
			}
		})
	}
</script>
<div class="mhdiv">
	<h1>통계</h1>
	<div id="chartDiv">
		<div id="monthTotal">
		<h2>매출현황</h2>
		</div>
		<div id="gradeNameThisCount">
		<h2>이번달등급퍼센트</h2>
		</div>
		<div id="gradeNameNextCount">
		<h2>지난달등급퍼센트</h2>
		</div>
	</div>
</div>
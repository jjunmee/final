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
</style>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		thisMonthTotal();
	});
	/* 
	function gTNC(){
		$.ajax({
			url:"<c:url value='/paychart/gradeThisNameCount'/>",
			dataType:"json",
			success:function(gnc){
				var chart = bb.generate({
				  data: {
				    columns: [
				$(gnc).each(function(i,json){
					[json.gname,json.gcount],
				})
				    ],
				    type: "donut"
				  },
				  donut: {
				    title: "매출",
				    padAngle: 0.05
				  },
				  tooltip:{
					  show:false
				  },
				  legend:{
					  position : "right"
				  },
				  bindto: "#gradeThisNameCount"
				});
			}
		});
	}
	 */
	function thisMonthTotal(){
		var chart = bb.generate({
		  data: {
		    columns: [
			["data1", 30],
			["data2", 45],
			["data3", 25]
		    ],
		    type: "donut"
		  },
		  donut: {
		    title: "매출",
		    padAngle: 0.05
		  },
		  tooltip:{
			  show:false
		  },
		  legend:{
			  position : "right"
		  },
		  bindto: "#gradeThisNameCount"
		});
	}
</script>
<div class="mhdiv">
	<h1>매출현황</h1>
	<div id="thisMonthTotal">${thisMonthTotal}</div>
	<div id="nextMonthTotal"></div>
	<div id="mPayThisMonthSum"></div>
	<div id="mPayNextMonthSum"></div>
	<div id="pointThisMonthPay"></div>
	<div id="pointNextMonthPay"></div>
	<div id="pointMemThisMonthSum"></div>
	<div id="pointMemNextMonthSum"></div>
	<div id="gradeThisNameCount"></div>
	<div id="gradeNextNameCount"></div>
	
</div>
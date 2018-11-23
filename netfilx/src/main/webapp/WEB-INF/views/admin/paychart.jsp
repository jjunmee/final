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
	#chartDiv{margin:auto; width: 1000px; border-radius: 3px; background-color: #555; height: 400px;}
	#gradeNameThisCount{float: left;width: 500px; margin-top: 40px;}
	#gradeNameNextCount{float: left;width: 500px; margin-top: 40px;}
</style>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		gradeNameThisCount();
		gradeNameNextCount();
	});
	
	//이번달 등급 카운트
	function gradeNameThisCount(){
		$.ajax({
			url:"<c:url value='/chart/gradeNameThisCount'/>",
			dataType:"json",
			success:function(mt){
				var arr = new Array();
				$(mt).each(function(i,json) {
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
			success:function(mt){
				var arr = new Array();
				$(mt).each(function(i,json) {
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
</script>
<div class="mhdiv">
	<h1>매출현황</h1>
	<div id="chartDiv">
		<div id="gradeNameThisCount"></div>
		<div id="gradeNameNextCount"></div>
	</div>
</div>
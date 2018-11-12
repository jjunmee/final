<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	.btnStyle{width: 150px;}
	
	.surveyList{padding-left: 80px;padding-top: 100px;height:700px;}
	.surveyList .leftBox{width:14%;height:100%;float: left;padding-top: 34px;} 
	.surveyList .centerBox{width:78%;float:left}
</style>
<script type="text/javascript">
	$(function(){
		if(${userPoint}<1000){
			$("#spoint").attr("disabled","disabled");
			$("#joinNum").attr("readonly","readonly");
			
		}
		
		
		$("#nthing").on({
			mouseover: function(){
				var cal=Math.round($("#spoint").val()/$("#joinNum").val());				
				$(this).val(cal+"포인트");
			},
			mouseout: function(){
				$(this).val("배당금확인하기");
			}		
		});
		
		$("#submitBtn").click(function(){
			$("#spointSpan").html("");
			$("#joinNumSpan").html("");
			
			if($("#spoint").val()<1000){
				$("#spointSpan").html("1000포인트 이상 가능합니다.");
			}else if($("#joinNum").val()<10){
				$("#joinNumSpan").html("설문참여자는 10명 이상이어야 합니다.")
			}else{
				if(${userPoint}<$("#spoint").val()){
					alert("포인트가 부족합니다.");
				}else{
					//modal사용해서 결제를 진행할껀지 
					$("#frm").submit();									
				}
			}
			
		})
		
	});
	function idCheck(n){
		var userId=document.getElementById("userId");
		if(userId.getAttribute("value")==null || userId.getAttribute("value")==''){
			alert('먼저 로그인을 해주세요');
		}else{
			if(n==0){//나의설문지
				location.href="<c:url value='/survey/mySurvey'/>";
			}
		}
	}

</script>
<div class="surveyList">	
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="javascript:idCheck(0)">나의 설문지</a>
		</div>
	</div>
	<div id="box" class="centerBox">	
		<form id="frm" action="<c:url value='/survey/surveyInsert1'/>" method="post">
			<div id="box">
				<h2> ${userId }님이 현재 보유하고 있는 포인트는 ${userPoint }입니다. </h2>				
				<table>
					<tr>
						<th>결제포인트</th>
						<td>
							<input type="number" id="spoint" name="spoint" min="1000" max="9999000" step="1000" value="1000">
							<span id="spointSpan"></span>
						</td>
					</tr>
					<tr>
						<th>인원</th>
						<td>
							<input type="number" id="joinNum" name="joinNum" min="10" max="9999000" step="10" value="10">
							<span id="joinNumSpan"></span>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" id="nthing" class="btnStyle"  value="배당금확인하기"></td>
					</tr>	
					<tr>
						<td colspan="2">이 설문조사 폼은 !~~~~~~!!설명!!!</td>	
					</tr>
					<tr>
						<td colspan="2"><input type="button" id="submitBtn" value="결제하고 설문등록하러가기"></td>
					</tr>
				</table>	
			</div>
		</form>		
	</div>
</div>
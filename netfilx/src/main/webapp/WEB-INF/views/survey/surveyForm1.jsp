<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>

<!-- Page styles -->
<link type='text/css' href="<c:url value='/resources/css/demo.css'/>" rel='stylesheet' media='screen' />

<!-- Confirm CSS files -->
<link type='text/css' href="<c:url value='/resources/css/confirm.css'/>" rel='stylesheet' media='screen' />

</head>
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
		
		$("#submitBtn").click(function(e){
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
					//modal사용해서 결제를 진행할껀지 // 모달 창 여는 버튼에 이벤트 걸기
					e.preventDefault();
					confirm("결제하시겠습니까?", function () {
						window.location.href = 'http://simplemodal.com';
					});											
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
				<table>
					<tr>
						<th colspan="2"><h3> ${userId }님이 현재 보유하고 있는 포인트는 ${userPoint }입니다. </h3>	</th>
					</tr>
					<tr>
						<th>결제포인트</th>
						<th>
							<input type="number" id="spoint" name="spoint" min="1000" max="9999000" step="1000" value="1000">
							<span id="spointSpan"></span>
						</th>						
					</tr>
					<tr>
						<th>인원</th>
						<th>
							<input type="number" id="joinNum" name="joinNum" min="10" max="9999000" step="10" value="10">
							<span id="joinNumSpan"></span>
						</th>						
					</tr>
					<tr>
						<td colspan="2"><br>
							* 이 설문조사는 WATFLIX 유저만이 참여할 수 있습니다.<br><br>
							* 설문지를 구매하려면 최소 1000포인트 이상 결제해야합니다.<br><br>
							* 설문에 참여할 수 있는 인원은 최소 10명 이상이어야 합니다.<br><br>
							* 설문에 참여한 사람은 (최소금액/최소인원)의 포인트를 가져갈 수 있습니다.<br><br>
							* 배당금액의 소수점 이하는 버려지게 되며 추후 설문이 완료되었을 때 설문구매자에게 돌려지게 됩니다.<br><br>
							* 설문이 완료되었을 때 인원참여자의 수가 남게 되었을 경우 그만큼의 포인트는 설문구매자에게 반환됩니다.<br><br>
						</td>	
					</tr>
					<tr>
						<td><input type="button" id="nthing" value="배당금확인하기"></td>
						<td>
							<div id='container'>
								<div id='content'>
									<div id='confirm-dialog'>
										<input type='button' id="submitBtn" name='confirm' class='confirm' value='결제하고 설문등록하러가기'/>
									</div>
									<!-- modal content -->
									<div id='confirm'>
										<div class='header'><span>Confirm</span></div>
										<div class='message'></div>
										<div class='buttons'>
											<div class='no simplemodal-close'>No</div><div class='yes'>Yes</div>
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>	
			</div>
			
			<!-- Load JavaScript files -->
			<script type='text/javascript' src="<c:url value='/resources/js/survey/jquery.js'/>"></script>
			<script type='text/javascript' src="<c:url value='/resources/js/survey/jquery.simplemodal.js'/>"></script>
			<script type='text/javascript' src="<c:url value='/resources/js/survey/confirm.js'/>"></script>

		</form>		
	</div>
</div>
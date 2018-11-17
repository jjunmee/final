<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link type='text/css' href="<c:url value='/resources/css/survey.css'/>" rel='stylesheet' media='screen' />

<script type="text/javascript">
	function checkAll(){
		var chk=document.getElementsByName("check");
		if(chk[0].checked==true){
			for(var i=1;i<chk.length;i++){
				chk[i].checked=true;
			}
		}else{
			for(var i=1;i<chk.length;i++){
				chk[i].checked=false;
			}
		}
	} 
	function check1(){
		var chk=document.getElementsByName("check");
		for(var i=1;i<chk.length;i++){
			if(chk[i].checked==false){
				chk[0].checked=false;
			}
		}
	}
	function delete1(){
		var delNumArr="";
		var chk=document.getElementsByName("check");
		for(var i=1;i<chk.length;i++){
			if(chk[i].checked==true){
				delNumArr+=chk[i].value+",";
			}
		}
		delNumArr=delNumArr.substring(0, delNumArr.lastIndexOf(","));//맨끝 콤마 지우기
		if(delNumArr==''){
			alert("삭제할 대상을 선택하세요");
			return false;
		}
		if(confirm("삭제하시겠습니까?")){
			location.href="<c:url value='/survey/delete?delNumArr="+delNumArr+"'/>";
		}
	}
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
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 90px;height:700px;overflow: auto;}
	.surveyList .topBox{padding-left: 14%;padding-bottom: 10px;}
	.surveyList .topBox .delBox{float:left;margin-top: 0px;}
	.surveyList .topBox .surBtn{float:auto;margin-left: 425px;}
	.surveyList .leftBox{width:14%;height:100%;float: left} 
	.surveyList .centerBox{width:78%;float:left;}
</style>
<div class="surveyList">
	<div class="topBox">
		<div class="delBox"><input type="button" value="삭제" onclick="delete1()"></div>
		<div class="surBtn"><input type="button" class="surBtn" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
	</div>
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="javascript:idCheck(0);">나의 설문지</a>
			<input type="hidden" id="userId" value="${sessionScope.id }">
		</div>
	</div>
	
	<div id="myListBox" class="centerBox">			
		<table>
			<tr>
				<th><input type="checkbox" name="check" onclick="checkAll()"></th>
				<th>번호</th>
				<th>설문제목</th>
				<th>조사인원</th>
				<th>결제금액</th>
				<th>설문현황</th>				
			</tr>
			<c:set var="num" value="1"/>
				<c:forEach var="vo" items="${list0 }">
					<tr>
						<td><input type="checkbox" name="check" value="${vo.surveyNum }" onclick="check1()"></td>
						<td>${num }</td>
						<td><a href="<c:url value='/survey/update?surveyNum=${vo.surveyNum }'/>">${vo.surveyName }</a></td>
						<td>${vo.joinNum }</td>
						<td>${vo.spoint }포인트</td>
						<td>${vo.state }</td>								
					</tr>
					<c:set var="num" value="${num+1 }"/>
				</c:forEach>	
				<c:forEach var="vo" items="${list1 }">
					<tr>
						<td><input type="checkbox" name="check" value="${vo.surveyNum }" onclick="check1()"></td>
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
						<td><input type="checkbox" name="check" value="${vo.surveyNum }" onclick="check1()"></td>
						<td>${num }</td>
						<td><a href="<c:url value='/survey/stats?surveyNum=${vo.surveyNum}'/>">${vo.surveyName }</a></td>
						<td>${vo.joinNum }</td>
						<td>${vo.spoint }포인트</td>
						<td>${vo.state }</td>								
					</tr>
					<c:set var="num" value="${num+1 }"/>
				</c:forEach>	
				<c:forEach var="vo" items="${list3 }">
					<tr>
						<td><input type="checkbox" name="check" value="${vo.surveyNum }" onclick="check1()"></td>
						<td>${num }</td>
						<td><a href="<c:url value='/survey/stats?surveyNum=${vo.surveyNum}'/>">${vo.surveyName }</a></td>
						<td>${vo.joinNum }</td>
						<td>${vo.spoint }포인트</td>
						<td>${vo.state }</td>								
					</tr>
					<c:set var="num" value="${num+1 }"/>
				</c:forEach>	
		</table>
			
	
	</div>
</div>
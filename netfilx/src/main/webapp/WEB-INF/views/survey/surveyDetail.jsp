<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	function idCheck(){
		var userId=document.getElementById("userId");
		if(userId.getAttribute("value")==null || userId.getAttribute("value")==''){
			alert('먼저 로그인을 해주세요');
		}else{
			location.href="<c:url value='/survey/mySurvey'/>";
		}
	}
</script>
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 100px;height:700px;}
	.surveyList .leftBox{width:14%;height:100%;float: left} 
	.surveyList .centerBox{width:78%;float:left}
</style>
<div class="surveyList">
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="javascript:idCheck();">나의 설문지</a>
		</div>
	</div>
	
	<div id="box" class="centerBox">			
		<div id="surveyName">${surveyVo.surveyName }</div>
		<c:if test="${videoVo!=null }">
			<div id="video">
				<video controls autoplay>
					<source src='<c:url value="/resources/upload/survey/${videoVo.svSaveSrc }"/>' type="video/mp4">
				</video>
			</div>
		</c:if>
		<div id="surveyDescription">${surveyVo.surveyDescription }</div>
		<div id="surveyStart">${surveyVo.surveyStart }</div>
		<div id="surveyEnd">${surveyVo.surveyEnd }</div>
		
		<form id="qstFrm" action="<c:url value='/survey/resultInsert'/>" method="post">			
			<div id="question">
				<c:if test="${choiceType=='1' }">
					<table>
						<tr>
							<th></th>
							<c:forEach var="i" begin="0" end="${fn:length(saList[0])-1 }">
								<th>${saList[0][i].saAnswer }</th>
							</c:forEach>
						</tr>
						<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
							<tr>
								<th>
									${sqVoList[i].sqTitle }
									<input type="hidden" name="resultList[${i }].sqNum" value="${sqVoList[i].sqNum }">
								</th>
								<c:forEach var="j" begin="0" end="${fn:length(saList[0])-1 }">
									<td><input type="radio" name="resultList[${i }].srAnswer" value="${j }"></td>
								</c:forEach>
							</tr>
						</c:forEach>						
					</table>				
				</c:if>		
			
				<c:if test="${choiceType=='2' }">
					<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
						${sqVoList[i].sqTitle }<br>
						<input type="hidden" name="resultList[${i }].sqNum" value="${sqVoList[i].sqNum }">
						<c:if test="${sqVoList[i].sqType==1 }">
							<c:forEach var="j" begin="0" end="${fn:length(saList[i])-1 }">
								<input type="radio" name="resultList[${i }].srAnswer" value="${j }">
								${saList[i][j].saAnswer }
							</c:forEach>
						</c:if>
						<c:if test="${sqVoList[i].sqType==2 }">
							<c:forEach var="j" begin="0" end="${fn:length(saList[i])-1 }">
								<input type="checkbox" name="resultList[${i }].srAnswer" value="${j }">
								${saList[i][j].saAnswer }
							</c:forEach>			
						</c:if>
						<c:if test="${sqVoList[i].sqType==3 }">
							<c:set var="num1" value="${fn:split(saList[i][0].saAnswer,'!@#$')[0] }"/>
							<fmt:formatNumber value="${num1 }" type="number" var="n1"/>
							<c:set var="num2" value="${fn:split(saList[i][1].saAnswer,'!@#$')[0] }"/>
							<fmt:formatNumber value="${num2 }" type="number" var="n2"/>
							<c:set var="ans1" value="${fn:split(saList[i][0].saAnswer,'!@#$')[1] }"/>
							<c:set var="ans2" value="${fn:split(saList[i][1].saAnswer,'!@#$')[1] }"/>
							${ans1 }
							<c:forEach var="j" begin="${n1 }" end="${n2 }">								
								<input type="radio" name="resultList[${i }].srAnswer" value="${j }">								
							</c:forEach>
							${ans2 }
						</c:if>
						<c:if test="${sqVoList[i].sqType==4 }">
							<input type="text" name="resultList[${i }].srAnswer">
						</c:if>
						<br>
					</c:forEach>	
				</c:if>		
			</div>
			<div id="things">
				<input type="hidden" id="userId" value="${sessionScope.id }">
				<input type="hidden" name="surveyNum" value="${surveyVo.surveyNum }">
				<input type="submit" value="참가">
			</div>
		</form>
	</div>
</div>
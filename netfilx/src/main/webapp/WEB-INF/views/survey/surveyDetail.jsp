<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	
  
</script>
<div><input type="button" onclick="location='<c:url value="/survey/surveyInsert1"/>'" value="설문구매하러가기"></div>
<div class="surveyList">
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/mySurvey'/>">설문등록하러가기</a>
		</div>
	</div>
	
	<div id="box" class="centerBox">			
		<div id="surveyName">${surveyVo.surveyName }</div>
		<c:if test="${videoVo!=null }">
			<div id="video">${videoVo.svSaveSrc }</div>
		</c:if>
		<div id="surveyDescription">${surveyVo.surveyDescription }</div>
		<div id="surveyStart">${surveyVo.surveyStart }</div>
		<div id="surveyEnd">${surveyVo.surveyEnd }</div>
		<br><br>
		<div id="question">
			<c:forEach var="i" begin="0" end="${fn:length(sqVoList) }">
				${sqVoList[i].sqTitle }
				<c:forEach var="j" begin="0" end="${fn:length(saList[i]) }">
					${saList[i][j].saAnswer }
				</c:forEach>
				<br>
			</c:forEach>
		</div>
	
	</div>
</div>
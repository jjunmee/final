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
	
	<div id="myBox" class="centerBox">
		<!-- sqList돌리면서 saList돌리면 될듯 -->
		짜잔
	</div>
</div>
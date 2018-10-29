<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">


</script>
<form action="<c:url value='/survey/surveyInsert1'/>" method="post">
	<div id="box">
		<h2> ${userId }님이 현재 보유하고 있는 포인트는 ${userPoint }입니다. </h2>
		<div id="payBox">
			결제포인트
			
			<br>
			인원<br>
			배당금
		</div>
		<div id="descriptionBox">
			이 설문조사 폼은 ~~~~~설명!
		</div>
		<input type="submit"  value="결제하고 설문등록하러가기">
	</div>
</form>
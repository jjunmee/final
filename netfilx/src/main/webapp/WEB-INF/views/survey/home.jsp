<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="tab">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<a href="">현재 진행중인 설문</a>&nbsp;
	<a href="">종료된 설문</a>&nbsp;
	<a href="<c:url value='/survey/surveyInsert'/>">설문등록하러가기</a>
</div>
<div id="listBox">

</div>
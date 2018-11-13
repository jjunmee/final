<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container">
	<c:choose>
		<c:when test="${empty(list) }">
			<a href="<c:url value='/profile/user/insertForm?first=true'/>" class="btn btn-default" >프로필 추가</a>
		</c:when>	
		<c:otherwise>
			<c:if test="${fn:length(list) < 4 }">
				<a href="<c:url value='/profile/user/insertForm?first=false'/>" class="btn btn-default" >프로필 추가</a>
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:if test="${!empty(list) }">
	<c:forEach var="vo" items="${list }" >
		<div class="container">
			<a href="<c:url value='/profile/user/getInfo?profile_num=${vo.profile_num }'/>">
				<img src="${vo.pimg_src }" width="200" id="profile_num" name="profile_num">
			</a>
		</div>
	</c:forEach>
	</c:if>	
</div>
<div class="container">
	<a href="c:url vlaue=''/>" class="">프로필 관리</a>
</div>
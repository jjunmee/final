<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container">
	<c:choose>
		<c:when test="${empty(list) }">
			<a href="<c:url value='/profile/user/img/listForm?first=true'/>" class="btn btn-default" >프로필 추가</a>
		</c:when>	
		<c:otherwise>
			<c:if test="${fn:length(list) < 4 }">
				<a href="<c:url value='/profile/user/img/listForm?first=false'/>" class="btn btn-default" >프로필 추가</a>
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:if test="${!empty(list) }">
		<div class="container">
			<c:forEach var="vo" items="${list }" >
					<a data-toggle="modal" data-target="#myModal" class="modalProfileNum" data-profile_num="${vo.profile_num }" data-row="${pageContext.request.contextPath }/profile/user/getInfo">
						<img src="${vo.pimg_src }" width="200" id="profile_num" name="profile_num">
					</a>
			</c:forEach>
		</div>
	</c:if>	
</div>
<c:if test="${profile_first eq true }">
	<div class="container">
		<a href="c:url value='/profile/user/info/admin'/>" class="">프로필 관리</a>
	</div>
</c:if>
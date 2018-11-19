<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/profile.css'/>">  
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container main">
	<div><h2>프로필 관리</h2></div>
	<div class="container">
	<c:if test="${!empty(list) }">
			<c:forEach var="vo" items="${list }" >
				<div class="profile">
					<div class="profile_img">
						<c:choose>
							<c:when test="${vo.profile_first eq true }">
								<c:set var="first" value="true"/>
							</c:when>
							<c:otherwise>
								<c:set var="first" value="false"/>
							</c:otherwise>
						</c:choose>
						<a href="<c:url value='/profile/user/updateFormView?profile_num=${vo.profile_num }'/>">
							<img src="${vo.pimg_src }" width="180" id="profile_num" name="profile_num">
						</a>
					</div>
					<div>
						<p class="profile_nickname">${vo.nickname }</p>
					</div>
				</div>
			</c:forEach>
	</c:if>
	<div class="profile">
			<div class="profile_img">
				<c:choose>
					<c:when test="${empty(list) }">
						<a href="<c:url value='/profile/user/img/listForm?first=true'/>" class="btn-lg">
							<i class="glyphicon glyphicon-plus-sign" ></i>
						</a>
					</c:when>
					<c:otherwise>
						<c:if test="${fn:length(list) < 4 }">
							<a href="<c:url value='/profile/user/img/listForm?first=false'/>" class="btn-lg">
								<i class="glyphicon glyphicon-plus-sign"></i>
							</a>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
			<div>
				<p class="profile_nickname">프로필 추가</p>
			</div>
		</div>
	</div>		
	<div class="container">
		<p class="footer">
			<a href="<c:url value='/profile/user/index'/>" class="manages">&nbsp;&nbsp;완료&nbsp;&nbsp;</a>
		</p>
	</div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container">
	<div><h2>프로필 관리</h2></div>
	<c:if test="${!empty(list) }">
		<div class="container">
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
							<img src="${vo.pimg_src }" width="200" id="profile_num" name="profile_num">
						</a>
					</div>
					<div class="profile_nickname">
						<a href="<c:url value='/profile/user/updateFormView?profile_num=${vo.profile_num }'/>">
						${vo.nickname }
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>	
</div>
<div class="container">
	<a href="<c:url value='/profile/user/index'/>" class="btn btn-primary">완료</a>
</div>
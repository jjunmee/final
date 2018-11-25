<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/profile.css'/>">
<c:if test="${!empty(vo) }">
	<c:set var="c_profile_num" value="${vo.profile_num }" />
	<c:set var="c_nickname" value="${vo.nickname}" />
	<c:set var="c_pimg_src" value="${vo.pimg_src }" />
	<c:set var="c_pimg_num" value="${vo.pimg_num }" />
</c:if>
<div class="container-fluid">
	<div class="row main">
	<form method="post" action="<c:url value='${action }'/>" onsubmit="return pwdCk();">
		<div class="row">
			<div class="col-md-offset-2">
			<c:choose>
				<c:when test="${!empty(c_profile_num) }">
				<h1>프로필 변경</h1>
				</c:when>
				<c:otherwise>
				<h2>프로필 추가</h2>
				<h4>Watflix를 시청할 다른 사용자를 등록하시려면 프로필을 추가하세요.</h4>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-2 col-md-2 col-md-offset-2">
		<c:choose>
			<c:when test="${!empty(vo) }">
				<c:choose>
				<c:when test="${!empty(n_pimg_num) }">
						<a href="<c:url value='/profile/user/img/change?profile_num=${vo.profile_num }'/>">
							<img src="${n_pimg_src }" width="180" height="180">
						</a>
						<input type="hidden" name="pimg_num" value="${n_pimg_num }">
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/profile/user/img/change?profile_num=${vo.profile_num }'/>">
							<img src="${vo.pimg_src }" width="180" height="180">
						</a>
						<input type="hidden" name="pimg_num" value="${vo.pimg_num }">
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<img src="${pimg_src }" width="180">
				<input type="hidden" name="pimg_num" value="${pimg_num }" >
			</c:otherwise>
		</c:choose>
			</div>
		<div class="col-sm-3 col-md-3 col-md-offset-1">
			<div class="inup-input">
			<input type="text" id="nickname" name="nickname" placeholder="닉네임을 적어주세요" value="${c_nickname }" class="form-control">
			</div>
			<div class="inup-input"> 
			<input type="password" name="profile_pwd" id="pwd" min="4" max="4" placeholder="4자리 비밀번호" class="form-control">
			</div><div class="inup-input"> 
			<input type="password" id="pwd1" min="4" max="4" placeholder="4자리 비밀번호 확인" class="form-control">
			</div><div class="inup-input"> 
			<input type="checkbox" id="child_ck" name="child_ck" onchange="change_child(this.value)">
			<label for="child_ck">어린이인가요?</label>
			<input type="hidden" id="child" name="child">
			</div>
			<c:choose>
				<c:when test="${vo.profile_first eq true }">
					<c:set var="first" value="true" />
				</c:when>
				<c:otherwise>
					<c:set var="first" value="false" />
				</c:otherwise>
			</c:choose>
			<input type="hidden" value="${first }" name="profile_first">
			<input type="hidden" value="${c_profile_num }" id="profile_num1" name="profile_num">
		</div>
		</div>
		<div class="container footer">
		<c:choose>
			<c:when test="${!empty(vo) }">
				<input type="submit" class="btn btn-primary" value="저장하기">
				<c:if test="${vo.profile_first ne true}">
					<a href="<c:url value='/profile/manageProfiles/del?profile_num=${c_profile_num }'/>" class="btn btn-danger">삭제하기</a>
				</c:if>
				<a href="<c:url value='/profile/manageProfiles'/>" class="btn btn-default">취소</a>
			</c:when>
			<c:otherwise>
				<input type="submit" class="btn btn-primary" value="추가하기">
				<a href="<c:url value='/profile/user/index'/>" class="btn btn-danger">취소</a>
			</c:otherwise>
		</c:choose>
		</div>
	</form>
	</div>
</div>
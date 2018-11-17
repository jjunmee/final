<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>
<c:if test="${!empty(vo) }">
	<c:set var="c_profile_num" value="${vo.profile_num }"/>
	<c:set var="c_nickname" value="${vo.nickname}"/>
	<c:set var="c_pimg_src" value="${vo.pimg_src }"/>
	<c:set var="c_pimg_num" value="${vo.pimg_num }"/>
</c:if>
<div class="container col-sm-12">
	<form method="post" action="<c:url value='${action }'/>" onsubmit="return pwdCk();">
		<table class="col-sm-8" style="margin: 0 auto;">
			<tr>
				<th rowspan="3" class="col-sm-4">
					<c:choose>
						<c:when test="${!empty(vo) }">
							<c:choose>
								<c:when test="${!empty(n_pimg_num) }">
									<a href="<c:url value='/profile/user/img/change?profile_num=${vo.profile_num }'/>">
										<img src="${n_pimg_src }" width="150">
									</a>
									<input type="hidden" name="pimg_num" value="${n_pimg_num }">
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/profile/user/img/change?profile_num=${vo.profile_num }'/>">
										<img src="${vo.pimg_src }" width="150">
									</a>
									<input type="hidden" name="pimg_num" value="${vo.pimg_num }">
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<img src="${pimg_src }" width="150">
							<input type="hidden" name="pimg_num" value="${pimg_num }">		
						</c:otherwise>
					</c:choose>
				</th>
				<td class="col-sm-4"><input type="text" name="nickname" placeholder="닉네임을 적어주세요" value="${c_nickname }"></td>
				<td class="col-sm-4"><input type="password" name="profile_pwd" id="pwd" min="4" max="4" placeholder="4자리 비밀번호"></td>
				<td class="col-sm-4"><input type="password" id="pwd1" min="4" max="4" placeholder="4자리 비밀번호 확인"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" id="child_ck" name="child_ck" onchange="change_child(this.value)">
					<label for="child_ck">어린이인가요?</label>
					<input type="hidden" id="child" name="child">
					<c:choose>
						<c:when test="${vo.profile_first eq true }">
							<c:set var="first" value="true"/>
						</c:when>
						<c:otherwise>
							<c:set var="first" value="false"/>
						</c:otherwise>
					</c:choose>
					<input type="hidden" value="${first }" name="profile_first">
					<input type="hidden" value="${c_profile_num }" name="profile_num">
				</td>	
			</tr>
			<tr>
				<td colspan="2">
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
				</td>				
			</tr>
		</table>
	</form> 
</div>
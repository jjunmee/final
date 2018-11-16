<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script src="<c:url value='/resources/js/profile/user-profile.js'/>"></script>

<div class="container col-sm-12">
	<form method="post" action="<c:url value='/profile/user/insert'/>" onsubmit="return pwdCk();">
		<table class="col-sm-8" style="margin: 0 auto;">
			<tr>
				<th rowspan="3" class="col-sm-4">
					<img src="${pimg_src }" width="150">
					<input type="hidden" name="pimg_num" value="${pimg_num }">
				</th>
				<td class="col-sm-4"><input type="text" name="nickname" placeholder="닉네임을 적어주세요"></td>
				<td class="col-sm-4"><input type="password" name="profile_pwd" id="pwd" min="4" max="4" placeholder="4자리 비밀번호"></td>
				<td class="col-sm-4"><input type="password" id="pwd1" min="4" max="4" placeholder="4자리 비밀번호 확인"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" id="child_ck" name="child_ck" onchange="change_child(this.value)">
					<label for="child_ck">어린이인가요?</label>
					<input type="hidden" id="child" name="child">
					<input type="hidden" value="${first }" name="profile_first">
				</td>	
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="추가하기">
					<input type="button" class="btn btn-default" value="취소" onclick="javascript:history.go(-1)">
				</td>				
			</tr>
		</table>
	</form> 
</div>
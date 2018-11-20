<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mh.css'/>">
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div class="mhdiv">
	<h1>회원관리</h1>
	<div>
		<form action="<c:url value='/admin/userlist'></c:url>" method="post" class="form1000">
			전체보기<input type="radio" name="sts" value="-1" <c:if test="${sts == -1 }">checked="checked"</c:if>>
			관리자<input type="radio" name="sts" value="1" <c:if test="${sts == 1 }">checked="checked"</c:if>>
			일반 사용자<input type="radio" name="sts" value="0" <c:if test="${sts == 0 }">checked="checked"</c:if>>
			쇼셜가입자<input type="radio" name="sts" value="2" <c:if test="${sts == 2 }">checked="checked"</c:if>>
			탈퇴회원<input type="radio" name="sts" value="9" <c:if test="${sts == 9 }">checked="checked"</c:if>>
			<input type="submit" value="검색">
		</form>
	</div>
	<table>
		<tr>
			<th>회원번호</th>
			<th>회원ID</th>
			<th>회원생년월일</th>
			<th>보유포인트</th>
			<th>회원상태</th>
			<th>멤버쉽</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.users_num }</td>
			<td>${vo.id }</td>
			<td>
				<fmt:formatDate value="${vo.birth}" pattern="yyyy-MM-dd"/>
			</td>
			<td>${vo.point }</td>
			<td>
				<form action="<c:url value='/admin/userOut'></c:url>" method="post">
				<input type="hidden" name="users_num" value="${vo.users_num }">
				<select name="sts">
					<option>==선택==</option>
					<option value="1" label="관리자" <c:if test="${vo.sts == 1}">selected="selected"</c:if>>관리자</option>
					<option value="0" label="일반사용자" <c:if test="${vo.sts == 0}">selected="selected"</c:if>>일반사용자</option>
					<option value="2" label="본인인증자" <c:if test="${vo.sts == 2}">selected="selected"</c:if>>쇼셜가입자</option>
					<option value="9" label="탈퇴처리" <c:if test="${vo.sts == 9}">selected="selected"</c:if>>탈퇴처리</option>
				</select>
				<input type="submit" value="변경">
				</form>
			</td>
			<td>
				<c:if test="${vo.grade_name != null }">
					<form action="<c:url value='/admin/userStsUp'></c:url>" method="post">
					<input type="hidden" name="users_num" value="${vo.users_num }">
					<select name="sts">
						<c:forEach var="g" items="${glist }">
							<option value="${g.grade_num }" label="${g.grade_name }" <c:if test="${vo.grade_num == g.grade_num }">selected="selected"</c:if>>${g.grade_name }</option>
						</c:forEach>
					</select>
					<input type="submit" value="변경">
					</form>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div>
		<c:choose>
			<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
				<a href='javascript:setPageNum(${pageUtil.startPageNum - 1 });' 
				style="color: blue;">[이전]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[이전]
			 -->
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
			<c:choose>
				<c:when test="${pu.pageNum == i }">
					<a href="<c:url value='/admin/userlist?pageNum=${i }&sts=${sts }'></c:url>">
						<span style="color: blue;">[${i }]</span>
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/admin/userlist?pageNum=${i }&sts=${sts }'></c:url>">
						<span style="color: gray;">[${i }]</span>
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
				<a href='javascript:setPageNum(${pageUtil.endPageNum + 1 });' 
				style="color: blue;">[다음]</a>
			</c:when>
			<c:otherwise>
			<!-- 
				[다음]
			 -->
			</c:otherwise>
		</c:choose>
	</div>
</div>
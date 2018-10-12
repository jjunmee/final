<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<ul>
		<li><a href="<c:url value=''/>">홈으로</a></li>
		<li><a href="<c:url value='/item'/>">판매상품</a></li>
		<li><a href="<c:url value='/board'/>">문의게시판</a></li>
		<li><a href="<c:url value='/admin/memberlist'/>">회원목록(관리자)</a></li>
		<li><a href="<c:url value='/admin/notice'/>">공지사항(관리자)</a></li>
		<li><a href="<c:url value='/member/mypage'/>">마이페이지</a></li>
	</ul>
</div>
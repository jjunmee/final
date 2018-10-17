<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<c:forEach var="str" items="${list }">
		${str }<br>
	</c:forEach>
	<h1>문의게시판</h1>
	<ul>
		<li>문의1</li>
		<li>문의2</li>
		<li>문의3</li>
		<li>문의4</li>
	</ul>
</div>
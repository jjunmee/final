<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		input{background-color: lightgray;}
		select{background-color: gray;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		function setPageNum(pageNum) {
			$("#pageNum").val(pageNum);
			$("#listForm").submit();
		}
		function deleteStaff(num) {
			var pageNum = $("#pageNum").val();
			var position = $("#position").val();
			var keyword = $("#keyword").val();
			location.href='<c:url value="/staff/delete'
			+'?pageNum='+pageNum+'&position='+position
			+'&keyword='+keyword+'&num='+num+'"/>';
		}
		function updateForm(num) {
			$.get("<c:url value='/staff/find'/>",
					{'num':num},
					function(data) {
				$("#tr"+num).empty();
				var str = 
					"<td>"
						+"<select name=\"staff_position\">"
							+"<option value=\"false\"";
							if(data.staff_position == false){
								str+="selected=\"selected\"";
							}
								str+=">배우</option>"
							+"<option value=\"true\"";
							if(data.staff_position == true){
								str+="selected=\"selected\"";
							}
								str+=">감독</option>"
						+"</select>"
						+"<input type=\"hidden\" name=\"staff_num\" value=\""+data.staff_num+"\">"
					+"</td>"
					+"<td><input type=\"text\" name=\"staff_name\" value=\""+data.staff_name+"\"></td>"
					+"<td><input type=\"text\" name=\"staff_age\" value=\""+data.staff_age+"\"></td>"
					+"<td><input type=\"text\" name=\"staff_gender\" value=\""+data.staff_gender+"\"></td>"
					+"<td><input type=\"text\" name=\"staff_debut\" value=\""+data.staff_debut+"\"></td>"
					+"<td>"
						+"<a href='javascript:updateStaff();'>확인</a>"
					+"</td>"
					+"<td>"
						+"<a href='javascript:cancelFunction();'>취소</a>"
					+"</td>";
				$("#tr"+num).append(str);
			});
		}
		function cancelFunction() {
			$("#listForm").submit();
		}
		function showForm() {
			$("#insertBox").css("display", "block");
		}
		function removeForm() {
			$("#insertBox").css("display", "none");
		}
		function updateStaff() {
			var params = $("#updateForm").serialize();
			$.post("<c:url value='/staff/update'/>", params, function(data) {
				if(data.result){
					$("#listForm").submit();
				}else{
					alert("데이터 수정 실패!!");
				}
			});
		}
		function insertStaff() {
			var params = $("#insertForm").serialize();
			$.post("<c:url value='/content/insertStaff'/>", params, function(data) {
				if(data.code == 'success'){
					$("#listForm").submit();
				}else{
					alert("데이터 등록 실패!!");
				}
			});
		}
	</script>
</head>
<body>
	<h1>스테프 목록</h1>
	<input type="button" value="등록" onclick="showForm()">
	<form id="updateForm" action='<c:url value="/staff/update"/>' method="post">
		<table>
			<tr id="tr${vo.series_num }">
				<th>시리즈 번호</th>
				<th>시리즈 명</th>
				<th>시즌</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach items="${list }" var="vo">
				<tr>
					<td>${vo.series_num }</td>
					<td>${vo.series_name }</td>
					<td>${vo.season }</td>
					<td>
						<a href='javascript:updateForm(${vo.series_num });'>수정</a>
					</td>
					<td>
						<a href='javascript:deleteStaff(${vo.series_num });'>삭제</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<c:choose>
		<c:when test="${pageUtil.pageNum > pageUtil.pageBlockCount }">
			<a href='javascript:setPageNum(${pageUtil.startPageNum - 1 });' 
			style="color: blue;">[이전]</a>
		</c:when>
		<c:otherwise>
			[이전]
		</c:otherwise>
	</c:choose>
	<c:forEach begin="${pageUtil.startPageNum }" end="${pageUtil.endPageNum }" var="i">
		<c:choose>
			<c:when test="${pageUtil.pageNum == i }">
				<a href='javascript:setPageNum(${i });' 
				style="color: red;">[${i }]</a>
			</c:when>
			<c:otherwise>
				<a href='javascript:setPageNum(${i });' 
				style="color: lightgray;">[${i }]</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${pageUtil.endPageNum != pageUtil.totalPageCount }">
			<a href='javascript:setPageNum(${pageUtil.endPageNum + 1 });' 
			style="color: blue;">[다음]</a>
		</c:when>
		<c:otherwise>
			[다음]
		</c:otherwise>
	</c:choose>
	<br>
	<form id="listForm" action='<c:url value="/series/list"/>' method="post">
		<input type="text" placeholder="시리즈명" id="keyword" name="keyword" value="${keyword }">
		<input type="submit" value="검색">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageUtil.pageNum }">
	</form>
	<div id="insertBox" style="background-color: gray;position: absolute;
							border: 1px solid red;top: 200px;left: 100px;display: none;">
		<form id="insertForm" action="javascript:false;" method="post" 
			onsubmit="insertStaff()">
			<table>
				<tr>
					<th>시리즈 명</th>
					<td><input type="text" name="staff_name"> </td>
				</tr>
				<tr>
					<th>시즌</th>
					<td><input type="text" name="staff_age"> </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록"> 
						<input type="button" value="취소" onclick="removeForm()"> 
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
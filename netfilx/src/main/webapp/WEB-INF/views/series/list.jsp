<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		#listBox{width: 1100px;margin: auto;text-align: right;}
		h1,#pageDiv{text-align: left;}
		#listTable{width: 1100px;}
		#listTable input[type="text"]{width: 100%;}
		.updateA{color: skyblue;}
		.deleteA{color: pink;}
		
		#insertBox{background-color: gray;position: absolute;border: 5px solid white;padding: 3px;
			border-radius: 8px;top:50%;left: 50%;transform:translate(-50%, -70%);width: 616px;display: none;}
		#insertBox table{width: 600px;}
		#insertBox th{width: 100px;}
		#insertBox td{width: 500px;}

		#insertBox table input[type="text"]{width: 100%;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		function setPageNum(pageNum) {
			$("#pageNum").val(pageNum);
			$("#listForm").submit();
		}
		function deleteSeries(num) {
			var pageNum = $("#pageNum").val();
			var keyword = $("#keyword").val();
			location.href='<c:url value="/series/delete'
			+'?pageNum='+pageNum+'&keyword='+keyword+'&num='+num+'"/>';
		}
		function updateForm(num) {
			$.get("<c:url value='/series/find'/>",
					{'num':num},
					function(data) {
				$("#tr"+num).empty();
				var str = 
					"<td><input type=\"text\" name=\"series_num\" value=\""+data.series_num+"\"  readonly=\"readonly\"></td>"
					+"<td><input type=\"text\" name=\"series_name\" value=\""+data.series_name+"\"></td>"
					+"<td><input type=\"text\" name=\"season\" value=\""+data.season+"\"></td>"
					+"<td>"
						+"<a class=\"updateA\" href='javascript:updateSeries();'>확인</a>"
					+"</td>"
					+"<td>"
						+"<a class=\"deleteA\" href='javascript:cancelFunction();'>취소</a>"
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
		function updateSeries() {
			var params = $("#updateForm").serialize();
			$.post("<c:url value='/series/update'/>", params, function(data) {
				if(data.result){
					$("#listForm").submit();
				}else{
					alert("데이터 수정 실패!!");
				}
			});
		}
		function insertSeries() {
			var params = $("#insertForm").serialize();
			$.post("<c:url value='/content/insertSeries'/>", params, function(data) {
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
	<div id="listBox">
		<h1>시리즈 목록</h1>
		<input type="button" value="등록" onclick="showForm()" class="btn btn-success btn-sm">
		<form id="updateForm" action='javascript:false;' method="post">
			<table id="listTable" class="table">
				<tr>
					<th style="width: 100px;">시리즈 번호</th>
					<th style="width: 800px;">시리즈 명</th>
					<th style="width: 100px;">시즌</th>
					<th style="width: 50px;">수정</th>
					<th style="width: 50px;">삭제</th>
				</tr>
				<c:forEach items="${list }" var="vo">
					<tr id="tr${vo.series_num }">
						<td>${vo.series_num }</td>
						<td>${vo.series_name }</td>
						<td>${vo.season }</td>
						<td>
							<a class="updateA" href='javascript:updateForm(${vo.series_num });'>수정</a>
						</td>
						<td>
							<a class="deleteA" href='javascript:deleteSeries(${vo.series_num });'>삭제</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		<div id="pageDiv">
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
		</div>
		<br>
		<form id="listForm" action='<c:url value="/series/list"/>' method="post">
			<input type="text" placeholder="시리즈명" id="keyword" name="keyword" value="${keyword }">
			<input type="submit" value="검색" class="btn btn-default btn-sm">
			<input type="hidden" id="pageNum" name="pageNum" value="${pageUtil.pageNum }">
		</form>
		<div id="insertBox">
			<form id="insertForm" action="javascript:false;" method="post" 
				onsubmit="insertSeries()">
				<table>
					<tr>
						<th>시리즈 명</th>
						<td><input type="text" name="series_name"> </td>
					</tr>
					<tr>
						<th>시즌</th>
						<td><input type="text" name="season"> </td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: right;">
							<input type="submit" value="등록" class="btn btn-default btn-sm"> 
							<input type="button" value="취소" onclick="removeForm()" class="btn btn btn-sm"> 
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
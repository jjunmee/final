<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		$(function() {
			$.ajax({
				url:"<c:url value='/content/categorylist'/>",
				dataType:"json",
				success:function(data){
					$(data).each(function(i,json) {
						var str = "<option value=\""+json.categoryNum+"\">"
							+json.categoryName+"</option>";
						console.log(str);
						$("#category").append(str);
					})
				}
			});
		});
	</script>
</head>
<body>
	<h1>컨텐츠등록</h1>
	<form action='<c:url value="/content/insert"/>' method="post"
	enctype="multipart/form-data">
		<table>
			<tr>
				<th>컨텐츠 명</th>
				<td><input type="text" name="contentNum"></td>
			</tr>
			<tr>
				<th>줄거리</th>
				<td><input type="text" name="contentSummary"></td>
			</tr>
			<tr>
				<th>개봉/방영 일</th>
				<td><input type="date" name="release"></td>
			</tr>
			<tr>
				<th>시청연령</th>
				<td>
					<select name="watchAge">
						<option value="0">전체</option>
						<option value="12">12세</option>
						<option value="15">15세</option>
						<option value="19">19세</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					<select name="categoryNum" id="category">
					</select>
				</td>
			</tr>
			<tr>
				<th>장르</th>
			</tr>
			<tr>
				<th>영상</th>
				<td><input type="file" name="orgFile"></td>
			</tr>
			<tr>
				<th>트레일러 영상</th>
				<td><input type="file" name="trailerFile"></td>
			</tr>
		</table>
	</form>
</body>
</html>
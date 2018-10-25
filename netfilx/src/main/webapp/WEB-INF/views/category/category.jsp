<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json){
					var str="<tr>"
								+"<td><input type=\"text\" value=" +json.categoryName+ "></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/category/update?num=" + json.categoryNum + "\">수정</a></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/category/delete?num=" + json.categoryNum + "\">삭제</a></td>"
							+"</tr>";
					$("#categorylist").append(str);
				});
			}
		});
	});
	function update(){
		
	};
</script>
<div>
<h1>분류</h1>
	<form method="post" action='<c:url value="/category/insert"/>'>
		분류 
		<input type="text" name="category_name">
		<input type="submit" value="추가">
	</form>
	<form method="post" action='<c:url value="/category/update/"/>'>
		<table border="1" id="categorylist">
			<tr>
				<th>분류</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</table>
	</form>
<h1>장르</h1>
	<form method="post" action="genre/insert">
		장르 
		<input type="text" name="genre_name">
		<input type="submit" value="추가">
	</form>
		<table>
			<tr>
				<th>장르</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach items="${list }" var="vo">
			<tr>
				<td><input type="text" value="${vo.genre_name }"></td>
				<td><a href="javascript:void(0);" onclick="update()">수정</a></td>
				<td><a href="${pageContext.request.contextPath }/category/delete?num=${vo.genre_num}">삭제</a></td>
			</tr>
			</c:forEach>
		</table>
</div>

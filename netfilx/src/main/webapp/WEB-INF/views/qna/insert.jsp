<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
	});
</script>
<div>
	<h1>문의등록</h1>
	<form method="post" action="<c:url value="/qna/insert"/>">
		<input type="hidden" name="qna_num" value="${qna_num}">
		문의제목 <input type="text" name="qna_title"><br>
		문의내용 <textarea rows="20" cols="5" name="qna_content"></textarea><br>
		공개<input type="radio" name="open" value="0">
		비공개<input type="radio" name="open" value="1"><br>
		<!-- 유저 로그인 완료되면 삭제 -->
		id <input type="text" name="id"><br>
		<input type="submit" value="등록">
	</form>
</div>

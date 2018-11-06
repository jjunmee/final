<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		video{width: 100%;}
		#block{width: 70%;padding: 20px;background-color: red;}
		#block ul{list-style: none;}
		#block li{float: right;margin-right: 10px;}
		
		#info{height: 80px;background-color: orange;}
		
		#commentDiv{background-color: yellow;padding: 10px;}
		#commentDiv>h4{display: inline;}
		#commentDiv>select{background-color: lightgray;}
		#comment{width: 80%;float: right;resize: none;background-color: lightgray;}
		#btnDiv{display: none;text-align: right;}
		#commentList>div{border: 1px solid red;}
		#commentList>div>div{text-align: right;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		function showBtn(){
			$("#btnDiv").show();
		}
		function hideBtn(){
			$("#btnDiv").hide();
		}
		function insertComment(){
			var params = $("#insertForm").serialize();
			$.post('<c:url value="/comment/insert"/>',
					params,
					function(data) {
						if(data.result){
							$("#insertForm>textarea").val("");
							hideBtn();
						}else{
							alert("오류로 인해 데이터 등록 실패!!");
						}
			});
		}
		function printList(){
			$.get('<c:url value="/comment/list"/>',
					{"content_num":${vo.content_num }},
					function(data) {
						data.each(function(i, json) {
							var str = 
								"<div>"
									+"<h5>"+json.profile_num+"</h5>"
									+"<p>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>"
									+"<div>"
										+"<input type=\"button\" value=\"좋아요 129\">"
										+"<a href="">답글</a>"
										+"<br>"
										+"<a href="">답글 보기</a>"
									+"</div>"
								+"</div>";
						});
			});
		}
	</script>
</head>
<body>
	<div id="block">
		<video controls autoplay>
			<source src='<c:url value="/resources/media/hut.mp4"/>' type="video/mp4">
		</video>
		<div id="info">
			<h3>${vo.content_name }</h3>
			<ul>
				<li>
					<input type="button" value="신고">
				</li>
				<li>
					<input type="button" value="좋아요">
				</li>
				<li>
					<input type="button" value="찜">
				</li>
			</ul>
		</div>
		<div id="commentDiv">
			<h4>댓글 00,000개</h4>
			<select name="sort">
				<option value="new">최신순</option>
				<option value="like">좋아요순</option>
			</select>
			<br><br>
			<form id="insertForm" onsubmit="insertComment()" action="javascript:false;">
				<div style="width: 20%;float: left;text-align: center;">
					프로필명 
				</div>
				<textarea rows="1" placeholder="댓글 추가..." name="comment" id="comment" 
				onfocus="showBtn()"></textarea>
				<input type="hidden" name="content_num" value="${vo.content_num }">
				<input type="hidden" name="profile_num" value="1">
				<br><br>
				<div id="btnDiv">
					<select name="comment_open" style="background-color: lightgray;">
						<option value="true">공개</option>
						<option value="false">비공개</option>
					</select>
					<input type="button" value="취소" onclick="hideBtn()">
					<input type="submit" value="입력">
				</div>
			</form>
			<div id="commentList">
				<div>
					<h5>프로필명</h5>
					<p>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>
					<div>
						<input type="button" value="좋아요 129">
						<a href="">답글</a>
						<br>
						<a href="">답글 보기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
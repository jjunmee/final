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
		#block{width: 70%;padding: 20px;}
		#block ul{list-style: none;}
		#block li{float: right;margin-right: 10px;}
		
		#info{height: 80px;}
		
		#commentDiv{padding: 10px;}
		#commentDiv>h4{display: inline;}
		#commentDiv>select{background-color: lightgray;}
		#comment{width: 80%;float: right;resize: none;background-color: lightgray;}
		#btnDiv{display: none;text-align: right;padding: 10px;}
		#commentList>div{border: 1px solid red;padding: 10px;}
		.goodBox{text-align: right;}
		.goodBox h5,p{text-align: left;}
		
		div[id^="subList"]>div{border: 1px solid orange;padding: 10px;}
		
		div[id^="subDiv"]{padding: 10px;display: none;}
		form[id^="subForm"]>div{width: 20%;float: left;text-align: center;}
		#subComment{width: 80%;float: right;resize: none;background-color: lightgray;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		var rowPage = 1;

		$(function() {
			rowPage = 1;
			printList(0,true);
			$.get("<c:url value='/interasts/count'/>",
					{"content_num":${vo.content_num },"profile_num":1},
					clickJj
			);
			$("#jjBtn").click(function() {
				$.get("<c:url value='/interasts/insert'/>",
						{"content_num":${vo.content_num },"profile_num":1},
						function(data) {
							if(data.result){
								clickJj(data);
							}else{
								alert("오류로 인해 찜에 실패했습니다!!");
							}
				});
			});
		});
		function clickJj(data) {
			$("#jjBtn").val("찜 "+data.count);
			$("#jjBtn").prop("disabled", data.check);
		}
		function showBtn(){
			$("#btnDiv").show();
		}
		function hideBtn(){
			$("#btnDiv").hide();
		}
		function showSub(num){
			$("#subDiv"+num).show();
		}
		function hideSub(num){
			$("#subDiv"+num).hide();
		}
		function insertComment(){
			var params = $("#insertForm").serialize();
			$.post('<c:url value="/comment/insert"/>',
					params,
					function(data) {
						if(data.result){
							$("#insertForm>textarea").val("");
							hideBtn();
							rowPage = 1;
							printList(0,true);
						}else{
							alert("오류로 인해 데이터 등록 실패!!");
						}
			});
		}
		function commentSub(num){
			var params = $("#subForm"+num).serialize();
			$.post('<c:url value="/comment/insert"/>',
					params,
					function(data) {
						if(data.result){
							$("#subForm"+num+">textarea").val("");
							hideSub(num);
						}else{
							alert("오류로 인해 데이터 등록 실패!!");
						}
			});
		}
		function printList(rowNum,clear){
			if(clear){
				$("#commentList").empty();
			}
			var sort = $("#sort").val();
			$.get('<c:url value="/comment/list"/>',
				{"content_num":${vo.content_num },"profile_num":1,"sort":sort,"rowNum":rowNum},
				function(data) {
					$(data).each(function(i, json) {
						var str = 
							"<div>"
								+"<h5>"+json.nickname+"</h5>"
								+"<p>"+json.comment+"</p>"
								+"<div class=\"goodBox\">"
									+"<input type=\"button\" value=\"좋아요 "+json.good_count
										+"\" onclick=\"clickGood(event,"+json.comment_num+")\" ";
									if(json.good_check){
										str+="disabled=\"disabled\"";
									}
									str+=">"
									+"<a href=\"javascript:showSub("+json.comment_num+");\">답글</a>"
									+"<br>"
									+"<div id=\"subDiv"+json.comment_num+"\">"
										+"<form id=\"subForm"+json.comment_num+"\" onsubmit=\"commentSub("+json.comment_num+")\" "
										+"action=\"javascript:false;\">"
											+"<div>"
												+"프로필명" 
											+"</div>"
											+"<textarea rows=\"1\" placeholder=\"공개 답글 추가...\" name=\"comment\" id=\"subComment\"></textarea>"
											+"<input type=\"hidden\" name=\"content_num\" value=\"${vo.content_num }\">"
											+"<input type=\"hidden\" name=\"profile_num\" value=\"1\">"
											+"<input type=\"hidden\" name=\"comment_open\" value=\"true\">"
											+"<input type=\"hidden\" name=\"c_lev\" value=\""+json.comment_num+"\">"
											+"<input type=\"hidden\" name=\"c_step\" value=\"1\">"
											+"<br><br>"
											+"<input type=\"button\" value=\"취소\" onclick=\"hideSub("+json.comment_num+")\">"
											+"<input type=\"submit\" value=\"입력\">"
										+"</form>"
										+"<br>"
									+"</div>"
									+"<a href=\"javascript:false;\" onclick=\"printSubList(event,"+json.comment_num+")\">답글 전체 보기</a>"
									+"<div id=\"subList"+json.comment_num+"\">"
									+"</div>"
								+"</div>"
							+"</div>";
						$("#commentList").append(str);
					});
				if(data.length == 5){
					$("#moreBtn").show();
				}else{
					$("#moreBtn").hide();
				}
				$.get("<c:url value='/comment/count'/>",
						{"content_num":${vo.content_num }},
						function(data) {
							$("#commentDiv>h4").html("댓글 "+data.count+"개");
				});
			});
		}
		function printSubList(event,num){
			if($(event.target).html() == '답글 숨기기'){
				$("#subList"+num).empty();
				$(event.target).html("답글 보기");
			}else{
				$("#subList"+num).empty();
				$.get('<c:url value="/comment/subList"/>',
						{"comment_num":num,"profile_num":1},
						function(data) {
							$(data).each(function(i, json) {
								var str =
									"<div>"
										+"<h5>"+json.nickname+"</h5>"
										+"<p>"+json.comment+"</p>"
										+"<div class=\"goodBox\">"
											+"<input type=\"button\" value=\"좋아요 "+json.good_count
												+"\" onclick=\"clickGood(event,"+json.comment_num+")\" ";
											if(json.good_check){
												str+="disabled=\"disabled\"";
											}
											str+=">"
										+"</div>"
									+"</div>";
								$("#subList"+num).append(str);
								$(event.target).html("답글 숨기기");
							});
				});
			}
		}
		function moreList(){
			printList(rowPage++,false);
		}
		function clickGood(event,comment_num){
			$.get('<c:url value="/good/insert"/>',
					{"comment_num":comment_num,"profile_num":1},
					function(data) {
						if(data.result){
							$(event.target).val("좋아요 "+data.count);
							$(event.target).prop("disabled", true);
						}else{
							alert("오류로 인해 좋아요를 실패했습니다!!");
						}
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
					<input type="button" value="찜" id="jjBtn">
				</li>
			</ul>
		</div>
		<div id="commentDiv">
			<h4>댓글 0개</h4>
			<select id="sort" onchange="printList(0,true)">
				<option value="new">최신순</option>
				<option value="good">좋아요순</option>
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
			<!-- 
				<div>
					<h5>프로필명</h5>
					<p>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>
					<div>
						<input type="button" value="좋아요 0" onclick="clickGood()" disabled="disabled">
						<a href="javascript:showSub(50);">답글</a>
						<br>
						<div id="subDiv50">
							<form id="subForm50" onsubmit="subComment()" action="javascript:false;">
								<div>
									프로필명 
								</div>
								<textarea rows="1" placeholder="공개 답글 추가..." name="comment" id="subComment"></textarea>
								<input type="hidden" name="content_num" value="${vo.content_num }">
								<input type="hidden" name="profile_num" value="1">
								<br><br>
								<input type="button" value="취소" onclick="hideSub(50)">
								<input type="submit" value="입력">
							</form>
							<br>
						</div>
						<a href="">답글 보기</a>
					</div>
				</div>
			 -->
			</div>
			<input type="button" value="더보기" onclick="moreList()" id="moreBtn"
				style="width: 100%;display: none;">
		</div>
	</div>

</html>
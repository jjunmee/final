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
		
		#info{text-align: right;padding: 5px;}
		#info>h2{text-align: left;}
		
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
		
		#rateBox{width:220px;height: 40px;display: inline;}
		#rateBox>*{text-align: center;}
		#score{color: red;display: inline;}
		.starRev{width: 150px;height: 30px;display: inline-block;}
		.starR1{
		    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
		    background-size: auto 100%;
		    width: 15px;
		    height: 30px;
		    float:left;
		    text-indent: -9999px;
		    cursor: pointer;
		}
		.starR2{
		    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
		    background-size: auto 100%;
		    width: 15px;
		    height: 30px;
		    float:left;
		    text-indent: -9999px;
		    cursor: pointer;
		}
		.starR1.on{background-position:0 0;}
		.starR2.on{background-position:-15px 0;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		$(window).on("beforeunload", function(){
			alert();
	    });

		var rowPage = 1;

		$(function() {
			$("#score").hide();
			rowPage = 1;
			printList(0,true);
			setAvg();
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
			$('.starRev span').click(function(event){
				var rates_score = $(this).html();
				$.get("<c:url value='/rates/setScore'/>",
						{"content_num":${vo.content_num },"profile_num":1,"rates_score":rates_score},
						function(data) {
							if(data.result){
								$(event.target).parent().children('span').removeClass('on');
								$(event.target).addClass('on').prevAll('span').addClass('on');
								$("#score").show();
								$("#score").html(rates_score);
								setAvg();
							}else{
								alert("오류로 인해 평점등록에 실패했습니다!!");
							}
				});
			});
			setStar();
		});
		function setAvg(){
			$.get("<c:url value='/rates/getAvg'/>",
					{"content_num":${vo.content_num }},
					function(data) {
						$("#rateAvg").val("평점 "+data.avg);
						$("#rateAvg").prop("title", "총 " + data.cnt + "명 참여");
			});
		}
		function setStar(){
			$.get("<c:url value='/rates/record'/>",
					{"content_num":${vo.content_num },"profile_num":1},
					function(data) {
						if(data.result != undefined){
							var spans = $(".starRev").children();
							for(var i = 0;i<spans.length;i++){
								if($(spans[i]).html() == data.result){
									$(spans[i]).trigger('click');
									break;
								}
							}
							$("#score").show();
							$("#score").html(data.result);
						}
			});
		}
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
				$("#player").on(
				"timeupdate", 
				function(event){
					onTrackedVideoFrame(this.currentTime, this.duration);
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
		function onTrackedVideoFrame(currentTime, duration){
		    $("#current").text(currentTime);
		    $("#duration").text(duration)
		}
	</script>
</head>
<body>
	<div id="block">
		<video controls autoplay id="player">
			<source src='<c:url value="/resources/media/hut.mp4"/>' type="video/mp4">
		</video>
		<div id="info">
			<h2>${vo.content_name }</h2>
			<div id="rateBox">
				<h2 id="score">0.0</h2>
				<div class="starRev">
					<span class="starR1">0.5</span>
					<span class="starR2">1.0</span>
					<span class="starR1">1.5</span>
					<span class="starR2">2.0</span>
					<span class="starR1">2.5</span>
					<span class="starR2">3.0</span>
					<span class="starR1">3.5</span>
					<span class="starR2">4.0</span>
					<span class="starR1">4.5</span>
					<span class="starR2">5.0</span>
				</div>
			</div>
			<input type="button" value="평점 0.0" id="rateAvg" disabled="disabled" title="asd">
			<input type="button" value="찜" id="jjBtn">
			<div id="current">0:00</div>
			<div id="duration">0:00</div>
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
</body>
</html>
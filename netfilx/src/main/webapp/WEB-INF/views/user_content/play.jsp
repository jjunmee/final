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
		
		#bookmarkDiv{width: 100%;text-align: right}
		#bookmarkBox{width: 100%;}
		#bookmarkBox>form>*{margin-top: 10px;}
		#bookmark_time{width: 70px;}
		
		.profile_name{width: 20%;float: left;text-align: center;}
		
		#info{text-align: right;padding: 5px;}
		#info>h2{text-align: left;}
		
		#commentDiv{padding: 10px;}
		#commentDiv a{color: #333;font-weight: bold;}
		#commentDiv>h4{display: inline;}
		#comment{width: 80%;float: right;resize: none;}
		#btnDiv{display: none;text-align: right;padding: 10px;}
		#commentList>div{padding: 10px;border-radius: 8px;background-color: #999;margin-bottom: 5px;
			border: 1px solid #828282;}
		.goodBox{text-align: right;}
		.goodBox h5,p{text-align: left;}
		
		div[id^="subList"]>div{padding: 10px;border-radius: 8px;background-color: #777;margin-bottom: 5px;
			border: 1px solid #626262;}
		
		div[id^="subDiv"]{padding: 10px;display: none;}
		form[id^="subForm"]>div{width: 20%;float: left;text-align: center;}
		#subComment{width: 80%;float: right;resize: none;}
		
		#moreBtn{width: 100%;display: none;}
		
		#rateBox{width:220px;height: 40px;display: inline;}
		#rateBox>*{text-align: center;}
		#rateAvg,#jjBtn,.goodBtn{border-radius: 5px;}
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
		var rowPage = 1;
		var playTime = 0;
		var temp = 0;

		$(window).on("beforeunload", function(){
			var v = document.getElementById("player");
			var next_watch = parseInt(document.getElementById("player").currentTime);
			$.get("<c:url value='/record/record'/>",
					{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num },
						"next_watch":Number(next_watch),"total_time":Number(playTime)},
					function(data) {
						
			});
			if(v.played && playTime != 0){
				$.get("<c:url value='/limit/exit'/>",
						{"users_num":${sessionScope.users_num }},
						function(data) {
				});
			}
	    });

		$(function() {
			$("#score").hide();
			$("#bookmarkBox").hide();
			rowPage = 1;
			printList(0,true);
			setAvg();
			$.get("<c:url value='/interasts/count'/>",
					{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num }},
					clickJj
			);
			
			$("#jjBtn").click(function() {
				$.get("<c:url value='/interasts/insert'/>",
						{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num }},
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
						{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num },"rates_score":rates_score},
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
			$("#player").on(
			"timeupdate", 
			function(event){
				if(!this.paused){
					onTrackedVideoFrame(Math.round(this.currentTime), Math.round(this.duration));
				}
			});
			$("#player").on(
			"play", 
			function(event){
				temp = Math.round(this.currentTime);
				$.get("<c:url value='/limit/check'/>",
						{"users_num":${sessionScope.users_num }},
						function(data) {
							if(data.check == "false"){
								this.pause();
								alert("동시접속제한!!!!");
							}else if(data.check == "pay"){
								location.href="<c:url value='/pay/payform'/>";
							}
				});
			});
			$("#player").on(
			"pause", 
			function(event){
				if(playTime != 0){
					$.get("<c:url value='/limit/exit'/>",
							{"users_num":${sessionScope.users_num }},
							function(data) {
					});
				}
			});
			$.get(
			"<c:url value='/record/getInfo'/>", 
			{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num }}, 
			function(data) {
				var player = document.getElementById("player");
				player.currentTime=data.next_watch;
			});
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
					{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num }},
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
		function setTime(){
			var time = $("#bookmark_time").val();
			var duration = parseInt(document.getElementById("player").duration);
			if(time > duration){
				time = duration;
				$("#bookmark_time").val(time);
			}else if(time < 0){
				time = 0;
				$("#bookmark_time").val(time);
			}
			var s = time % 60;
			var m = parseInt(time / 60);
			$("#timeSpan").text(m + " : " + s);
		}
		function clickJj(data) {
			$("#jjBtn").val("찜 "+data.count);
			if(data.check){
				$("#jjBtn").prop("class","jjBtn btn-danger");
			}else{
				$("#jjBtn").prop("class","jjBtn btn-default");
			}
		}
		function showBtn(id){
			if(id == 'bookmarkBox'){
				var time = parseInt(document.getElementById("player").currentTime);
				$("#bookmark_time").val(time);
				setTime();
			}
			$("#"+id).slideDown();
		}
		function hideBtn(id){
			$("#"+id).hide();
		}
		function insertComment(id){
			var params = $("#"+id).serialize();
			$.post('<c:url value="/comment/insert"/>',
					params,
					function(data) {
						if(data.result){
							$("#"+id+">textarea").val("");
							if(id == 'insertForm'){
								hideBtn('btnDiv');
								rowPage = 1;
								printList(0,true);
							}else if(id == 'bookmarkForm'){
								hideBtn('bookmarkBox');
								rowPage = 1;
								printList(0,true);
							}else{
								hideBtn(id.replace("Form", "Div"));
							}
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
				{"content_num":${vo.content_num },"profile_num":${sessionScope.profile_num },"sort":sort,"rowNum":rowNum},
				function(data) {
					$(data).each(function(i, json) {
						var str = 
							"<div>"
								+"<h5>"+json.nickname+"</h5>"
								+"<p>";
								if(json.bookmark){
									var t = json.bookmark_time;
									var s = t%60;
									var m = parseInt(t/60);
									str+="<a href='javascript:playBookmark("+t+")'>"+m+" : "+s+"</a> "
								}
								str+=json.comment+"</p>"
								+"<div class=\"goodBox\">"
									+"<input type=\"button\" value=\"좋아요 "+json.good_count
										+"\" onclick=\"clickGood(event,"+json.comment_num+")\" ";
									if(json.good_check){
										str+="class=\"goodBtn btn-warning\"";
									}else{
										str+="class=\"goodBtn btn-default\"";
									}
									str+=">"
									+"<a href=\"javascript:showBtn('subDiv'+"+json.comment_num+");\">답글</a>"
									+"<br>"
									+"<div id=\"subDiv"+json.comment_num+"\">"
										+"<form id=\"subForm"+json.comment_num+"\" onsubmit=\"insertComment('subForm'+"+json.comment_num+")\" "
										+"action=\"javascript:false;\">"
											+"<div>"
												+"${sessionScope.nickname }" 
											+"</div>"
											+"<textarea rows=\"1\" placeholder=\"공개 답글 추가...\" name=\"comment\" id=\"subComment\"></textarea>"
											+"<input type=\"hidden\" name=\"content_num\" value=\"${vo.content_num }\">"
											+"<input type=\"hidden\" name=\"profile_num\" value=\"${sessionScope.profile_num }\">"
											+"<input type=\"hidden\" name=\"comment_open\" value=\"true\">"
											+"<input type=\"hidden\" name=\"c_lev\" value=\""+json.comment_num+"\">"
											+"<input type=\"hidden\" name=\"c_step\" value=\"1\">"
											+"<br><br>"
											+"<input type=\"button\" value=\"취소\" onclick=\"hideBtn('subDiv'+"+json.comment_num+")\" class=\"btn btn-sm\">"
											+"<input type=\"submit\" value=\"입력\" class=\"btn btn-default btn-sm\">"
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
				$(event.target).html("답글 전체 보기");
			}else{
				$("#subList"+num).empty();
				$.get('<c:url value="/comment/subList"/>',
						{"comment_num":num,"profile_num":${sessionScope.profile_num }},
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
												str+="class=\"goodBtn btn-warning\"";
											}else{
												str+="class=\"goodBtn btn-default\"";
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
					{"comment_num":comment_num,"profile_num":${sessionScope.profile_num }},
					function(data) {
						if(data.result){
							$(event.target).val("좋아요 "+data.count);
							if(data.check){
								$(event.target).prop("class","goodBtn btn-warning");
							}else{
								$(event.target).prop("class","goodBtn btn-default");
							}
						}else{
							alert("오류로 인해 좋아요를 실패했습니다!!");
						}
			});
		}
		function onTrackedVideoFrame(currentTime, duration){
			playTime += currentTime - temp;
			temp = currentTime;
		}
		function playBookmark(time) {
			var player = document.getElementById("player");
			player.currentTime = time;
			player.play();
		}
	</script>
</head>
<body>
	<div id="block">
		<video controls id="player">
			<source src='<c:url value="/resources/media/hut.mp4"/>' type="video/mp4">
		</video>
		<div id="bookmarkDiv">
			<input type="button" value="책갈피" id="bookmark" onclick="showBtn('bookmarkBox')" class="btn btn-primary">
			<div id="bookmarkBox">
				<form id="bookmarkForm" onsubmit="insertComment('bookmarkForm')" action="javascript:false;">
					<div class="profile_name">
						${sessionScope.nickname } 
					</div>
					<textarea rows="1" placeholder="책갈피 추가..." name="comment" id="comment"></textarea>
					<input type="hidden" name="content_num" value="${vo.content_num }">
					<input type="hidden" name="profile_num" value="${sessionScope.profile_num }">
					<br><br>
					<div>
						<span id="timeSpan"></span>
						<input type="number" name="bookmark_time" id="bookmark_time" 
							onclick="setTime()" onchange="setTime()">
					</div>
					<select name="comment_open">
						<option value="true">공개</option>
						<option value="false">비공개</option>
					</select>
					<input type="hidden" name="bookmark" value="true">
					<input type="button" value="취소" onclick="hideBtn('bookmarkBox')" class="btn btn-sm">
					<input type="submit" value="입력" class="btn btn-default btn-sm">
				</form>
			</div>
		</div>
		<div id="info">
			<h2>${vo.content_name }</h2>
			<!-- http://miuus.tistory.com/2 -->
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
			<input type="button" value="평점 0.0" id="rateAvg" disabled="disabled" title="asd" class="btn-warning">
			<input type="button" value="찜" id="jjBtn">
		</div>
		<div id="commentDiv">
			<h4>댓글 0개</h4>
			<select id="sort" onchange="printList(0,true)">
				<option value="new">최신순</option>
				<option value="good">좋아요순</option>
			</select>
			<br><br>
			<form id="insertForm" onsubmit="insertComment('insertForm')" action="javascript:false;">
				<div class="profile_name">
					${sessionScope.nickname } 
				</div>
				<textarea rows="1" placeholder="댓글 추가..." name="comment" id="comment" 
					onfocus="showBtn('btnDiv')"></textarea>
				<input type="hidden" name="content_num" value="${vo.content_num }">
				<input type="hidden" name="profile_num" value="${sessionScope.profile_num }">
				<br><br>
				<div id="btnDiv">
					<select name="comment_open">
						<option value="true">공개</option>
						<option value="false">비공개</option>
					</select>
					<input type="button" value="취소" onclick="hideBtn('btnDiv')" class="btn btn-sm">
					<input type="submit" value="입력" class="btn btn-default btn-sm">
				</div>
			</form>
			<div id="commentList">
			</div>
			<input type="button" value="더보기" onclick="moreList()" id="moreBtn" class="btn btn-default">
		</div>
	</div>
</body>
</html>
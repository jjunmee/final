<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		.carousel-cell{width: 18%;height: 100%;}
		.carousel-cell>img{width: 200px;height: 150px;margin-top: 25px;background-color: black;
			position:absolute;z-index: 2;}
		.carousel-cell>video{width: 300px;height: 200px;margin-left: -50px;background-color: black;
			position:absolute;z-index: 1;display: none;}
		.carousel-cell>div{width: 300px;height: 200px;margin-left: -50px;
			position:absolute;z-index: 1;display: none;cursor: pointer;}
		.carousel-cell>div>*{padding-left: 20px;}
		.main-carousel{height: 200px;}
		.detail{width: 100%;height: 500px;margin: auto;background-color: black;display: none;}
		#detail_div>div{float: left;}
		#detail_div>div>table{width: 150px;}
		.detail>video{height: 500px;right: 0px;position: absolute;z-index: 1;}
		.detail>div{width: 100%;height: 500px;padding: 20px;
			position: absolute;z-index: 2;display: none;}
		#info_div>h5{width: 50%;}
		.closeBtn{position: absolute;right: 0px;top: 0px;}
		.detail_menu{position: absolute;bottom: 0px;left: 35%;}
		.detail_menu>a{margin: 10px;}
	</style>
	<!-- https://flickity.metafizzy.co/ -->
	<link rel="stylesheet" href="https://unpkg.com/flickity@2/dist/flickity.min.css">
	<script type="text/javascript" src='<c:url value="/resources/js/jquery-3.3.1.min.js"/>'></script>
	<script src="https://unpkg.com/flickity@2/dist/flickity.pkgd.min.js"></script>
	<script type="text/javascript">
		$(function () {
			$('.main-carousel').flickity({
				  cellAlign:'center',
				  autoPlay:false,
				  draggable:false,
				  groupCells:5,
				  setGallerySize: false,
				  resize: false,
				  wrapAround: true
			});
			$(".carousel-cell>img").mouseover(function(event) {
				$(this).delay(500).animate({
					'margin-top':0,
					'margin-left':-50,
					'width': 300,
					'height': 200,
					'z-index': 5
				},200, function() {
					$(event.target.nextElementSibling).css({
						'margin-top':0,
						'margin-left':-50,
						'width': 300,
						'height': 200,
						'z-index': 3
					}).show();
					$(event.target.nextElementSibling.nextElementSibling).css({
						'margin-top':0,
						'margin-left':-50,
						'width': 300,
						'height': 200,
						'z-index': 4
					}).show();
					$(event.target.nextElementSibling.nextElementSibling.nextElementSibling).css({
						'margin-top':0,
						'margin-left':-50,
						'width': 300,
						'height': 200,
						'z-index': 5
					}).show();
				}).fadeOut();
			});
			$(".carousel-cell>div").mouseout(function(event) {
				$(event.target.previousElementSibling.previousElementSibling).animate({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 1
				},200, function() {
					$(event.target.previousElementSibling.previousElementSibling.previousElementSibling).css({
						'margin-top':25,
						'margin-left':0,
						'width': 200,
						'height': 150,
						'z-index': 2
					}).show();
				}).fadeOut();
				$(event.target.previousElementSibling).css({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 1
				}).hide();
				$(this).css({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 1
				}).hide();
			});
		});
		function contentDetail(event,vo) {
			$(".detail>video").remove();
			$(".name").html(vo.content_name);
			var info = vo.content_regdate + " / ";
			if(vo.watch_age == 12){
				info += 12;
			}else if(vo.watch_age == 15){
				info += 15;
			}else if(vo.watch_age == 19){
				info += "청불";
			}else{
				info += "전체관람가";
			}
			info += " / " + vo.series_num;
			$("#detail_info").html(info);
			$("#detail_summary").html(vo.content_summary);
			$.get("<c:url value='/staff/detailList'/>",
					{"content_num":vo.content_num},
					function(data) {
						$(data).each(function(i, json) {
							if(json.staff_position == 1){
								$("#tb_director").append("<tr><td>"+json.staff_name+"</td></tr>");
							}else{
								$("#tb_actor").append("<tr><td>"+json.staff_name+"</td></tr>");
							}
						});
			});
			$.get("<c:url value='/genre/detailList'/>",
					{"content_num":vo.content_num},
					function(data) {
						$(data).each(function(i, json) {
							$("#tb_genre").append("<tr><td>"+json.genre_name+"</td></tr>");
						});
			});
			$.get("<c:url value='/interasts/count'/>",
					{"content_num":vo.content_num,"profile_num":1},
					clickJj
			);
			$("#jjBtn").click(function() {
				$.get("<c:url value='/interasts/insert'/>",
						{"content_num":vo.content_num,"profile_num":1},
						function(data) {
							if(data.result){
								clickJj(data);
							}else{
								alert("오류로 인해 찜에 실패했습니다!!");
							}
				});
			});
			$("#playBtn").click(function() {
				location.href = "<c:url value='/content/contentPlay?content_num="+vo.content_num+"'/>";
			});
			$(".detail").slideDown(function() {
				detailView(1);
				$(event.target.previousElementSibling.previousElementSibling).clone()
					.removeAttr("style").prependTo(".detail");
			});
		}
		function clickJj(data) {
			$("#jjBtn").val("찜 "+data.count);
			$("#jjBtn").prop("disabled", data.check);
		}
		function closeDetail(event) {
			$(".detail>video").remove();
			$(".detail>div").hide();
			$(".detail").slideUp();
		}
		function detailView(num) {
			$(".detail>div").hide();
			if(num == 1){
				$("#info_div").show();
			}else if(num == 2){
				
			}else if(num == 3){
				
			}else if(num == 4){
				$("#detail_div").show();
			}
		}
		function contentPlay() {
			location.href = "<c:url value='/content/contentPlay'/>";
		}
	</script>
</head>
<body>
	<h4>내가 찜한 콘텐츠</h4>
	<div class="main-carousel">
		<c:forEach items="${list }" var="vo">
		  <div class="carousel-cell">
	  		<img src='<c:url value="/resources/upload/stillcut/${vo.content_post2 }"/>'>
		  	<video loop autoplay>
				<source src='<c:url value="/resources/media/hut.mp4"/>' type="video/mp4">
			</video>
			<div>
				<h3>${vo.content_name }</h3>
				<h5>
					${vo.content_regdate} / 
					<c:choose>
						<c:when test="${vo.watch_age == 12}">
							${vo.watch_age }
						</c:when>
						<c:when test="${vo.watch_age == 15}">
							${vo.watch_age }
						</c:when>
						<c:when test="${vo.watch_age == 19}">
							청불
						</c:when>
						<c:otherwise>
							전체관람가
						</c:otherwise>
					</c:choose>
				</h5>
				<br><br>
				<h5>${vo.content_summary }</h5>
			</div>
			<div onclick="contentDetail(event,{
				content_num:${vo.content_num},
				content_name:'${vo.content_name}',
				orgsrc:'${vo.orgsrc}',
				savesrc:'${vo.savesrc}',
				content_summary:'${vo.content_summary}',
				trailer_orgsrc:'${vo.trailer_orgsrc}',
				trailer_savesrc:'${vo.trailer_savesrc}',
				content_size:${vo.content_size},
				trailer_size:${vo.trailer_size},
				content_post1:'${vo.content_post1}',
				content_post2:'${vo.content_post2}',
				release_date:'${vo.release_date}',
				watch_age:${vo.watch_age},
				content_regdate:${vo.content_regdate},
				series_num:${vo.series_num}
			})"></div>
		  </div>
		</c:forEach>
	</div>
	<div class="detail">
		<div id="info_div">
			<h2 class="name"></h2>
			<br><br>
			<h4 id="detail_info"></h4>
			<br><br>
			<h5 id="detail_summary"></h5>
			<input type="button" value="재생" id="playBtn">
			<input type="button" value="찜" id="jjBtn">
			<br>
			<div class="detail_menu">
				<a href="javascript:detailView(1);">컨텐츠 정보</a>
				<a href="javascript:false;">회차 정보</a>
				<a href="javascript:false;">비슷한 컨텐츠</a>
				<a href="javascript:detailView(4);">상세 정보</a>
			</div>
			<input class="closeBtn" type="button" value="x" onclick="closeDetail()">
		</div>
		<div id="detail_div">
			<h2 class="name"></h2>
			<br><br>
			<div>
				<table id="tb_director">
					<tr>
						<th>감독/연출</th>
					</tr>
				</table>
				<br>
				<table id="tb_actor">
					<tr>
						<th>출연</th>
					</tr>
				</table>
			</div>
			<div>
				<table id="tb_genre">
					<tr>
						<th>장르</th>
					</tr>
				</table>
				<br>
				<table id="tb_feature">
					<tr>
						<th>특징</th>
					</tr>
				</table>
			</div>
			<div class="detail_menu">
				<a href="javascript:detailView(1);">컨텐츠 정보</a>
				<a href="javascript:detailView(2);">회차 정보</a>
				<a href="javascript:detailView(3);">비슷한 컨텐츠</a>
				<a href="javascript:detailView(4);">상세 정보</a>
			</div>
			<input class="closeBtn" type="button" value="x" onclick="closeDetail()">
		</div>
	</div>
	<h4>Watflix 인기 콘텐츠</h4>
	<h4>지금 뜨는 콘텐츠</h4>
</body>
</html>
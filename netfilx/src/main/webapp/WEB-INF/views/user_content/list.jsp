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
		.content-cover{width: 300px;height: 200px;margin-left: -50px;
			position:absolute;z-index: 1;background-color: yellow;display: null;}
		.main-carousel{
			height: 200px;
		}
		.main-carousel {
			transition: height 0.2s;
		}
		.detail{width: 100%;height: 500px;margin: auto;background-color: black;display: none;}
		.detail>video{height: 500px;right: 0px;position: absolute;z-index: 1;}
		.detail>div{width: 100%;height: 500px;padding: 20px;position: absolute;z-index: 2;}
		.detail>div>h5{width: 50%;}
		.detail>div>#closeBtn{position: absolute;right: 0px;top: 0px;}
		.detail>div>div{position: absolute;bottom: 0px;left: 35%;}
		.detail>div>div>a{margin: 10px;}
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
			$(".carousel-cell img").mouseover(function(event) {
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
			$(".carousel-cell div").mouseout(function(event) {
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
		function contentDetail(event) {
			$(".detail").slideDown(function() {
				$(".detail *").show();
				$(event.target.previousElementSibling.previousElementSibling).clone()
					.removeAttr("style").prependTo(".detail");
			});
		}
		function closeDetail(event) {
			$(".detail *").hide();
			$(".detail").slideUp();
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
				<h5>${vo.watch_age }</h5>
				<br><br>
				<h5>${vo.content_summary }</h5>
			</div>
			<div onclick="contentDetail(event)"></div>
		  </div>
		</c:forEach>
	</div>
	<div class="detail">
		<div>
			<h2>제목</h2>
			<br><br>
			<h4>방영일/시청연령/시즌</h4>
			<br><br>
			<h5>
				줄거리줄거리줄거리줄거리줄거리줄거리줄거리줄거리
				줄거리줄거리줄거리줄거리줄거리줄거리줄거리줄거리
				줄거리줄거리줄거리줄거리줄거리줄거리줄거리줄거리
				줄거리줄거리줄거리줄거리줄거리줄거리줄거리줄거리
			</h5>
			<input type="button" value="재생">
			<input type="button" value="찜">
			<input type="button" value="좋아요">
			<br>
			<div>
				<a href="">컨텐츠 정보</a>
				<a href="">회차 정보</a>
				<a href="">비슷한 컨텐츠</a>
				<a href="">상세 정보</a>
			</div>
			<input id="closeBtn" type="button" value="x" onclick="closeDetail()">
		</div>
	</div>
	<h4>Watflix 인기 콘텐츠</h4>
	<h4>지금 뜨는 콘텐츠</h4>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		.carousel-cell{width: 19%;height: 100%;}
		.carousel-cell img{width: 200px;height: 150px;margin-top: 25px;
			position:relative;z-index: 1;}
		.carousel-cell video{width: 200px;height: 150px;margin-top: 25px;
			position:relative;z-index: 1;}
		.main-carousel{
			height: 200px;
		}
		.main-carousel {
			transition: height 0.2s;
		}
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
				  pageDots: false,
				  resize: false
			});
			$(".carousel-cell img").hover(function() {
				$(this).delay(500).animate({
					'margin-top':0,
					'margin-left':-50,
					'width': 300,
					'height': 200,
					'z-index': 5
				},200);
			}, function() {
				$(this).finish();
				$(this).css({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 1
				});
			});
			$(".carousel-cell video").hover(function() {
				$(this).delay(500).animate({
					'margin-top':0,
					'margin-left':-50,
					'width': 300,
					'height': 200,
					'z-index': 5
				},200);
			}, function() {
				$(this).finish();
				$(this).css({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 1
				});
			});
		});
	</script>
</head>
<body>
	<h4>내가 찜한 콘텐츠</h4>
	<div class="main-carousel">
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/1.jpg"/>'></div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/2.jpg"/>'></div>
	  <div class="carousel-cell">
	  	<video controls="controls" autoplay="autoplay">
			<source src='<c:url value="/resources/media/hut.mp4"/>' type="video/mp4">
		</video>
	  </div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/4.jpg"/>'></div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/5.jpg"/>'></div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/6.jpg"/>'></div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/7.jpg"/>'></div>
	  <div class="carousel-cell"><img src='<c:url value="/resources/images/8.jpg"/>'></div>
	</div>
	<h4>Watflix 인기 콘텐츠</h4>
	<h4>지금 뜨는 콘텐츠</h4>
</body>
</html>
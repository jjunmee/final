<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		.carousel-cell>img,.carousel-cell>video{border: 2px solid #999;border-radius: 8px;}
		.carousel-cell{width: 18%;height: 100%;}
		.carousel-cell>img{width: 200px;height: 150px;margin-top: 25px;
			position:absolute;z-index: 2;cursor: pointer;}
		.carousel-cell>video{width: 300px;height: 200px;margin-top: 0px;margin-left: -50px;
			background-color: black;position:absolute;z-index: 3;display: none;}
		.carousel-cell>div{width: 300px;height: 200px;margin-top: 0px;margin-left: -50px;
			position:absolute;z-index: 4;display: none;cursor: pointer;}
		.carousel-cell>div>*{padding-left: 20px;}
		.main-carousel{height: 200px;}
		#detail{width: 100%;height: 500px;margin: auto;background-color: black;display: none;}
		.detail_div>div{float: left;}
		.detail_div>div>table{width: 150px;}
		#detail>video{height: 500px;right: 0px;position: absolute;z-index: 1;}
		#detail>div{width: 100%;height: 500px;padding: 20px;
			position: absolute;z-index: 2;display: none;}
		.info_div>h5{width: 50%;}
		.closeBtn{position: absolute;right: 0px;top: 0px;border-radius: 50px;background-color: lightgray;}
		.detail_menu{position: absolute;bottom: 0px;left: 50%;transform:translate(-50%, 0%);}
		.detail_menu>a{margin: 10px;}
		
		th{font-size: 20px;}
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
				  pageDots: false
			});
			$(".carousel-cell>img").hover(function(event) {
				$(this).css({
					'z-index': 3
				}).delay(800).animate({
					'margin-top':0,
					'margin-left':-50,
					'width': 300,
					'height': 200
				},200, function() {
					event.target.nextElementSibling.play();
					$(event.target.nextElementSibling).show();
					$(event.target.nextElementSibling.nextElementSibling).show();
					$(event.target.nextElementSibling.nextElementSibling.nextElementSibling).show();
				});
			},function(){
				$(this).stop().stop();
				$(this).css({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 2
				});
			});
			$(".carousel-cell>div").mouseout(function(event) {
				$(event.target.previousElementSibling.previousElementSibling.previousElementSibling).animate({
					'margin-top':25,
					'margin-left':0,
					'width': 200,
					'height': 150,
					'z-index': 2
				},200);
				event.target.previousElementSibling.previousElementSibling.pause();
				$(event.target.previousElementSibling.previousElementSibling).hide();
				$(event.target.previousElementSibling).hide();
				$(this).hide();
			});
		});
		function contentDetail(event,vo,targetId) {
			$("#detail>video").remove();
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
			if(vo.series_num != 0){
				$.get("<c:url value='/content/seriesList'/>",
						{"series_num":vo.series_num},
						function(data) {
							info += " / " + data.series_name;
							$(data.list).each(function(i, json) {
							});
				});
				$(".series_info").html();
			}
			$(".detail_info").html(info);
			$(".detail_summary").html(vo.content_summary);
			$.get("<c:url value='/staff/detailList'/>",
					{"content_num":vo.content_num},
					function(data) {
						$(".tb_director").empty();
						$(".tb_director").append("<tr><th>감독/연출</th></tr>");
						$(".tb_actor").empty();
						$(".tb_actor").append("<tr><th>출연</th></tr>");
						$(data).each(function(i, json) {
							if(json.staff_position == 1){
								$(".tb_director").append("<tr><td>"+json.staff_name+"</td></tr>");
							}else{
								$(".tb_actor").append("<tr><td>"+json.staff_name+"</td></tr>");
							}
						});
			});
			$.get("<c:url value='/genre/detailList'/>",
					{"content_num":vo.content_num},
					function(data) {
						$(".tb_genre").empty();
						$(".tb_genre").append("<tr><th>장르</th></tr>");
						$(data).each(function(i, json) {
							$(".tb_genre").append("<tr><td>"+json.genre_name+"</td></tr>");
						});
			});
			$.get("<c:url value='/interasts/count'/>",
					{"content_num":vo.content_num,"profile_num":${sessionScope.profile_num }},
					clickJj
			);
			$(".jjBtn").off();
			$(".jjBtn").click(function() {
				$.get("<c:url value='/interasts/insert'/>",
						{"content_num":vo.content_num,"profile_num":${sessionScope.profile_num }},
						function(data) {
							if(data.result){
								clickJj(data);
							}else{
								alert("오류로 인해 요청작업을 실패했습니다!!");
							}
				});
			});
			$(".playBtn").click(function() {
				location.href = "<c:url value='/content/contentPlay?content_num="+vo.content_num+"'/>";
			});
			/*
			$("#detail").slideDown(function() {
				detailView(1);
				$(event.target.previousElementSibling.previousElementSibling).clone()
					.removeAttr("style").prop("autoplay", "autoplay").prependTo("#detail");
			});
			*/
			var $detail = $("#detail").hide().detach();
			$detail.appendTo($("#"+targetId)).slideDown(function() {
				$(event.target.previousElementSibling.previousElementSibling).clone()
					.removeAttr("style").prop("autoplay", "autoplay").prependTo("#detail");
				detailView(1,vo.series_num);
			});
		}
		function clickJj(data) {
			$(".jjBtn").val("찜 "+data.count);
			if(data.check){
				$(".jjBtn").prop("class","jjBtn btn btn-danger");
			}else{
				$(".jjBtn").prop("class","jjBtn btn btn-default");
			}
		}
		function closeDetail(event) {
			$("#detail>video").remove();
			$("#detail>div").hide();
			$("#detail").slideUp();
		}
		function detailView(num,series_num) {
			var v = document.getElementById("detail").firstChild;
			$("#detail>div").hide();
			$(".detail_menu").remove();
			$(".closeBtn").remove();
			var str = 
			"<div class=\"detail_menu\">"
				+"<a class=\"a1\" href=\"javascript:detailView(1,"+series_num+");\">콘텐츠 정보</a>";
				if(series_num != 0){
					str+="<a class=\"a2\" href=\"javascript:detailView(2,"+series_num+");\">회차 정보</a>"
				}
				str+="<a class=\"a3\" href=\"javascript:detailView(3,"+series_num+");\">비슷한 컨텐츠</a>"
				+"<a class=\"a4\" href=\"javascript:detailView(4,"+series_num+");\">상세 정보</a>"
			+"</div>"
			+"<input class=\"closeBtn\" type=\"button\" value=\"x\" onclick=\"closeDetail()\">";
			if(num == 1){
				v.play();
				$(".info_div").append(str).show();
			}else if(num == 2){
				v.pause();
				$(".series_info").append(str).show();
			}else if(num == 3){
				v.pause();
				$(".similar_content").append(str).show();
			}else if(num == 4){
				v.pause();
				$(".detail_div").append(str).show();
			}
			$(".detail_menu").show();
			$(".detail_menu>a").css("color", "white");
			$(".a"+num).css("color","red");
		}
		function contentPlay() {
			location.href = "<c:url value='/content/contentPlay'/>";
		}
	</script>
</head>
<body>
	<h4>내가 찜한 콘텐츠</h4>
	<div id="jjimContent">
		<div class="main-carousel">
			<c:forEach items="${jjimList }" var="vo">
			  <div class="carousel-cell">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
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
					content_regdate:'${vo.content_regdate}',
					series_num:${vo.series_num}
				},'jjimContent')"></div>
			  </div>
			</c:forEach>
		</div>
	</div>
	<h4>신규 콘텐츠</h4>
	<div id="newContent">
		<div class="main-carousel">
			<c:forEach items="${newList }" var="vo">
			  <div class="carousel-cell">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
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
					content_regdate:'${vo.content_regdate}',
					series_num:${vo.series_num}
				},'newContent')"></div>
			  </div>
			</c:forEach>
		</div>
	</div>
	<h4>Watflix 인기 콘텐츠</h4>
	<div id="bestContent">
		<div class="main-carousel">
			<c:forEach items="${bestList }" var="vo">
			  <div class="carousel-cell">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
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
					content_regdate:'${vo.content_regdate}',
					series_num:${vo.series_num}
				},'bestContent')"></div>
			  </div>
			</c:forEach>
		</div>
	</div>
	<h4>${sessionScope.nickname } 님의 취향저격 콘텐츠</h4>
	<div id="detail">
		<div class="info_div">
			<h2 class="name"></h2>
			<br><br>
			<h4 class="detail_info"></h4>
			<br><br>
			<h5 class="detail_summary"></h5>
			<input type="button" value="재생" class="playBtn btn btn-info">
			<input type="button" value="찜" class="jjBtn">
		</div>
		<div class="series_info">
			<div class="main-carousel">
				<c:forEach items="${jjimList }" var="vo">
				  <div class="carousel-cell">
				  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
				  	<video loop>
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
						content_regdate:'${vo.content_regdate}',
						series_num:${vo.series_num}
					},'jjimContent')"></div>
				  </div>
				</c:forEach>
			</div>
		</div>
		<div class="similar_content">
		</div>
		<div class="detail_div">
			<h2 class="name"></h2>
			<br><br>
			<div>
				<table class="tb_director">
				</table>
				<br>
				<table class="tb_genre">
				</table>
			</div>
			<div>
				<table class="tb_actor">
				</table>
				<br>
			</div>
		</div>
	</div>
</body>
</html>
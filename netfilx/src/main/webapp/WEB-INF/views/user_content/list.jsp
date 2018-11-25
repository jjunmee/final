<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		#userContentDiv{margin: 10px; padding: 10px;}
		.carousel-cell.main p{text-overflow: ellipsis;overflow: hidden;word-break:break-all;height: 40%;}
		.carousel-cell.main>img,.carousel-cell.main>video{}
		.carousel-cell.main{width: 18%;height: 100%;}
		.carousel-cell.main>img{width: 200px;height: 150px;margin-top: 25px;
			position:absolute;z-index: 2;cursor: pointer;}
		.carousel-cell.main>video{width: 300px;height: 200px;margin-top: 0px;margin-left: -50px;
			background-color: black;position:absolute;z-index: 3;display: none;}
		.carousel-cell.main>div{width: 300px;height: 200px;margin-top: 0px;margin-left: -50px;
			position:absolute;z-index: 4;display: none;cursor: pointer;}
		.carousel-cell.main>div>*{padding-left: 10px;padding-right: 10px;}
		.main-carousel.main{height: 200px;}
		
		.main-carousel.series{height: 300px;margin-top: 50px;}
		.carousel-cell.series{width: 24%;height: 100%;text-align: center;}
		.seriesSub{width: 260px;height: 150px;padding: 5px;margin: auto;}
		.carousel-cell.series>video{border: 2px solid #999;border-radius: 8px;background-color: black;
			height: 150px;}
			
		.seriesSub p{text-overflow: ellipsis;overflow: hidden;word-break:break-all;width: 100%;height: 45%;}
		
		
		#detail{width: 100%;height: 500px;margin: auto;background-color: black;display: none;}
		.detail_div>div{float: left;}
		.detail_div>div>table{width: 150px;}
		#detail>video{height: 500px;right: 0px;position: absolute;z-index: 1;}
		#detail>div{width: 100%;height: 500px;padding: 20px;
			position: absolute;z-index: 2;display: none;}
		.detail_summary{text-overflow: ellipsis;overflow: hidden;word-break:break-all;width: 50%;height: 30%;}
		.info_div>h5{width: 50%;}
		.closeBtn{position: absolute;right: 0px;top: 0px;border-radius: 50px;background-color: #222;}
		.detail_menu{position: absolute;bottom: 0px;left: 50%;transform:translate(-50%, 0%);}
		.detail_menu>a{margin: 10px;font-weight: bold;}
		
		th{font-size: 20px;}
	</style>
	<script type="text/javascript">
		$(function () {
			$('.main-carousel.main').flickity({
				  cellAlign:'center',
				  autoPlay:false,
				  draggable:false,
				  groupCells:5,
				  setGallerySize: false,
				  resize: false,
				  pageDots: false
			});
			$(".carousel-cell.main>img").hover(function(event) {
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
			$(".carousel-cell.main>div").mouseout(function(event) {
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
			$("#detail>div").hide();
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
							$(".detail_info").html(info);
							var str = 
							"<h2>"+data.series_name+"</h2>"
							+"<div class=\"main-carousel series\">";
							$(data.list).each(function(i, json) {
								str+=
								  "<div class=\"carousel-cell series\">"
								  	+"<video loop onclick=\"contentPlay("+json.content_num+")\">"
										+"<source src='<c:url value='http://dmszone.com:8080/watflix/org/"+json.savesrc+"'/>' type='video/mp4'>"
									+"</video>"
									  +"<div class=\"seriesSub\">"
									  	+"<h4>"+json.content_name+"</h4>"
									  	+"<p>"+json.content_summary+"</p>"
									  +"</div>"
								  +"</div>";
							});
							str+="</div>";
							$(".series_info").empty();
							$(".series_info").append(str);
							$(".series_info video").each(function(i, element) {
								element.currentTime = Math.floor(Math.random() * 50) + 10;
							});
							$(".series_info video").css("cursor", "pointer");
							$('.main-carousel.series').flickity({
								  cellAlign:'center',
								  autoPlay:false,
								  draggable:false,
								  groupCells:4,
								  setGallerySize: false,
								  pageDots: false
							});
				});
			}else{
				$(".detail_info").html(info);
			}
			$.get("<c:url value='/content/similarList'/>",
					{"content_num":vo.content_num,"series_num":vo.series_num},
					function(data) {
						var str = 
						"<h2>"+vo.content_name+"</h2>"
						+"<div class=\"main-carousel series\">";
						$(data).each(function(i, json) {
							str+=
							  "<div class=\"carousel-cell series\">"
							  	+"<video loop onclick=\"contentPlay("+json.content_num+")\">"
									+"<source src='<c:url value='http://dmszone.com:8080/watflix/org/"+json.savesrc+"'/>' type='video/mp4'>"
								+"</video>"
								  +"<div class=\"seriesSub\">"
								  	+"<h4>"+json.content_name+"</h4>"
								  	+"<p>"+json.content_summary+"</p>"
								  +"</div>"
							  +"</div>";
						});
						str+="</div>";
						$(".similar_content").empty();
						$(".similar_content").append(str);
						$(".similar_content video").each(function(i, element) {
							element.currentTime = Math.floor(Math.random() * 50) + 10;
						});
						$(".similar_content video").css("cursor", "pointer");
						$('.main-carousel.series').flickity({
							  cellAlign:'center',
							  autoPlay:false,
							  draggable:false,
							  groupCells:4,
							  setGallerySize: false,
							  pageDots: false
						});
			});
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
		function contentPlay(num) {
			location.href = "<c:url value='/content/contentPlay?content_num="+num+"'/>";
		}
	</script>
</head>
<body>
	<h4>내가 찜한 콘텐츠</h4>
	<div id="jjimContent">
		<div class="main-carousel main">
			<c:forEach items="${jjimList }" var="vo">
			  <div class="carousel-cell main">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
					<source src='<c:url value="http://dmszone.com:8080/watflix/org/${vo.savesrc }"/>' type="video/mp4">
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
					<p>${vo.content_summary }</p>
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
		<div class="main-carousel main">
			<c:forEach items="${newList }" var="vo">
			  <div class="carousel-cell main">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
					<source src='<c:url value="http://dmszone.com:8080/watflix/org/${vo.savesrc }"/>' type="video/mp4">
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
					<p>${vo.content_summary }</p>
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
		<div class="main-carousel main">
			<c:forEach items="${bestList }" var="vo">
			  <div class="carousel-cell main">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
					<source src='<c:url value="http://dmszone.com:8080/watflix/org/${vo.savesrc }"/>' type="video/mp4">
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
					<p>${vo.content_summary }</p>
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
	<div id="recommendContent">
		<div class="main-carousel main">
			<c:forEach items="${recommendList }" var="vo">
			  <div class="carousel-cell main">
			  	<img src='<c:url value="http://dmszone.com:8080/watflix/stillcut/${vo.content_post2 }"/>'>
			  	<video loop>
					<source src='<c:url value="http://dmszone.com:8080/watflix/org/${vo.savesrc }"/>' type="video/mp4">
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
					<p>${vo.content_summary }</p>
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
	<div id="detail">
		<div class="info_div">
			<h2 class="name"></h2>
			<br><br>
			<h4 class="detail_info"></h4>
			<br><br>
			<p class="detail_summary"></p>
			<input type="button" value="재생" class="playBtn btn btn-info">
			<input type="button" value="찜" class="jjBtn">
		</div>
		<div class="series_info">
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
>>>>>>> branch 'master' of https://github.com/jjunmee/final.git
			</div>
		</div>
	</div>
</body>
</html>
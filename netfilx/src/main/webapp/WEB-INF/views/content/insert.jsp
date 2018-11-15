<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		#content,#btnBox{text-align: center;}
		form{width:800px;margin: auto;}
		
		#sForm{position: absolute;top:600px;left: 250px;width: 800px;
			border: 1px solid red;background-color: lightgray}
		#insertTable{width: 800px;}
		#insertTable th{width: 100px;}
		#insertTable input[type="text"],textarea{width: 680px;resize: none;}
	</style>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
	<script type="text/javascript">
		$(function() {
			$.ajax({
				url:"<c:url value='/content/categorylist'/>",
				dataType:"json",
				success:function(data){
					$(data).each(function(i,json) {
						var str = "<option value=\""+json.category_num+"\">"
							+json.category_name+"</option>";
						$("#category").append(str);
					})
					genrelist();
				}
			});
			$("#category").change(genrelist);
		});
		function genrelist(data){
			$("#genre").empty();
			var num = $("#category").val();
			$.ajax({
				url:"<c:url value='/content/genrelist?num="+num+"'/>",
				dataType:"json",
				success:function(data){
					$(data).each(function(i,json) {
						var str = "<input type=\"checkbox\" name=\"genre"+json.genre_num
						+"\" value=\""+json.genre_num+"\">"+json.genre_name;
						$("#genre").append(str);
						if((i+1)%3 == 0){
							$("#genre").append("<br>");
						}
					})
				}
			});
		}
		function selectForm(position){
			$("#sForm").remove();
			var str = "<div id=\"sForm\">";
			if(position==0){
				str += "배우이름"
			}else if(position==1){
				str += "감독이름"
			}else{
				str += "시리즈"
			}
			str += " : <input type=\"text\" id=\"searchName\" size=\"20\" onkeyup=\"searchInfo(event,'"+position+"')\">"
				+"<table border=\"1\" width=\"400\" id=\"searchTable\">"
				+"<input type=\"button\" value=\"등록\" onclick=\"insertForm('"+position+"')\">"
				+"<input type=\"button\" value=\"취소\" onclick=\"removeForm()\">"
			+"</div>";
			$("body").append(str);
			$("#searchName").focus();
		}
		function searchInfo(event,position){
			$("#insertForm").remove();
			$("#searchTable").empty();
			if(position=='series'){
				var th = "<tr>"
					+"<th>시리즈명</th>"
					+"<th>시즌</th>"
				+"</tr>";
				$("#searchTable").append(th);
				var name = event.target.value;
				$.ajax({
					url:"<c:url value='/content/serieslist'/>",
					data:{"name":name},
					dataType:"json",
					success:function(data){
						$(data).each(function(i,json) {
							var str = "<tr>"
								+"<td><a href=\"javascript:false;\" onclick=\"selectInfo('"
										+position+"',"+json.series_num+",'"+json.series_name+"')\">"
										+json.series_name+"</a></td>"
								+"<td>"+json.season+"</td>"
							+"</tr>";
							$("#searchTable").append(str);
						})
					}
				});
			}else{
				var th = "<tr>"
					+"<th>이름</th>"
					+"<th>출생년도</th>"
					+"<th>성별</th>"
					+"<th>데뷔작</th>"
				+"</tr>";
				$("#searchTable").append(th);
				var name = event.target.value;
				$.ajax({
					url:"<c:url value='/content/stafflist'/>",
					data:{"position":position,"staff_name":name},
					dataType:"json",
					success:function(data){
						$(data).each(function(i,json) {
							var str = "<tr>"
								+"<td><a href=\"javascript:false;\" onclick=\"selectInfo("
										+position+","+json.staff_num+",'"+json.staff_name+"')\">"
										+json.staff_name+"</a></td>"
								+"<td>"+json.staff_age+"</td>"
								+"<td>"+json.staff_gender+"</td>"
								+"<td>"+json.staff_debut+"</td>"
							+"</tr>";
							$("#searchTable").append(str);
						})
					}
				});
			}
		}
		function selectInfo(position,num,name){
			$("#sForm").remove();
			if(position==0){
				var str = "<span id=\"staff"+num+"\">"+name+" <input type=\"hidden\""
					+"name=\"staff"+num+"\" value=\""+num+"\"></span>";
			}else if(position==1){
				var str = "<span id=\"staff"+num+"\">"+name+" <input type=\"hidden\""
					+"name=\"staff"+num+"\" value=\""+num+"\"></span>";
			}else{
				var str = "<span id=\"series"+num+"\">"+name+" <input type=\"hidden\""
					+"name=\"series\" value=\""+num+"\"></span>";
			}
			str += "<a href=\"javascript:false;\" onclick=\"removeInfo(event,'"+position+"',"+num+")\"\">-</a>";
			if(position==0){
				$("#actor").append(str);
			}else if(position==1){
				$("#director").append(str);
			}else{
				$("#series").append(str);
				$("#addSeries").css('display', 'none');
			}
		}
		function removeInfo(event,position,num){
			if(position=='series'){
				event.target.remove();
				$("#series"+num).remove();
				$("#addSeries").css('display', 'inline');
			}else{
				event.target.remove();
				$("#staff"+num).remove();
			}
		}
		function insertForm(position){
			$("#insertForm").remove();
			$("#searchTable").empty();
			if(position=='series'){
				var form = 
				"<form onsubmit=\"return insertInfo('"+position+"')\" id=\"insertForm\">"
					+"<table border=\"1\" width=\"400\" id=\"searchTable\">"
						+"<tr>"
							+"<th>시리즈명</th>"
							+"<th>시즌</th>"
						+"</tr>"
						+"<tr>"
							+"<td><input type=\"text\" size=\"8\" id=\"series_name\"></td>"
							+"<td><input type=\"text\" size=\"8\" id=\"season\"></td>"
						+"</tr>"
						+"<tr>"
							+"<td colspan=\"2\">"
								+"<input type=\"submit\" value=\"등록\">"
							+"</td>"
						+"</tr>"
					+"</table>"
				+"</form>";
			}else{
				var form = 
				"<form onsubmit=\"return insertInfo("+position+")\" id=\"insertForm\">"
					+"<table border=\"1\" width=\"400\" id=\"searchTable\">"
						+"<tr>"
							+"<th>이름</th>"
							+"<th>출생년도</th>"
							+"<th>성별</th>"
							+"<th>데뷔작</th>"
						+"</tr>"
						+"<tr>"
							+"<td><input type=\"text\" size=\"8\" id=\"staff_name\"></td>"
							+"<td><input type=\"text\" size=\"8\" id=\"staff_age\"></td>"
							+"<td><input type=\"text\" size=\"8\" id=\"staff_gender\"></td>"
							+"<td><input type=\"text\" size=\"8\" id=\"staff_debut\"></td>"
						+"</tr>"
						+"<tr>"
							+"<td colspan=\"4\">"
								+"<input type=\"submit\" value=\"등록\">"
							+"</td>"
						+"</tr>"
					+"</table>"
				+"</form>";
			}
			$("#sForm").append(form);
			
		}
		function removeForm(){
			$("#sForm").remove();
		}
		function insertInfo(position){
			if(position=='series'){
				var series_name = $("#series_name").val();
				var season = $("#season").val();
				$.ajax({
					url:"<c:url value='/content/insertSeries'/>",
					data:{"series_name":series_name,"season":season},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code == 'success'){
							$("#insertForm").remove();
						}else{
							alert("데이터등록실패!");
						}
					}
				});
			}else{
				var staff_name = $("#staff_name").val();
				var staff_age = $("#staff_age").val();
				var staff_gender = $("#staff_gender").val();
				var staff_debut = $("#staff_debut").val();
				$.ajax({
					url:"<c:url value='/content/insertStaff'/>",
					data:{"staff_position":position,"staff_name":staff_name,"staff_age":staff_age,
						"staff_gender":staff_gender,"staff_debut":staff_debut},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code == 'success'){
							$("#insertForm").remove();
						}else{
							alert("데이터등록실패!");
						}
					}
				});
			}
			return false;
		}
	</script>
</head>
<body>
	<h1>컨텐츠등록</h1>
	<form action='<c:url value="/content/insert"/>' method="post"
	enctype="multipart/form-data">
		<table id="insertTable" class="table-bordered">
			<tr>
				<th>컨텐츠 명</th>
				<td><input type="text" name="content_name"></td>
			</tr>
			<tr>
				<th>줄거리</th>
				<td><textarea rows="7" cols="30" name="content_summary"></textarea></td>
			</tr>
			<tr>
				<th>개봉/방영 일</th>
				<td><input type="date" name="release_date"></td>
			</tr>
			<tr>
				<th>시청연령</th>
				<td>
					<select name="watch_age">
						<option value="0">전체</option>
						<option value="12">12세</option>
						<option value="15">15세</option>
						<option value="19">19세</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					<select name="category_num" id="category">
					</select>
				</td>
			</tr>
			<tr>
				<th>장르</th>
				<td id="genre">
				</td>
			</tr>
			<tr>
				<th>
					시리즈
					<a href="javascript:false;" onclick="selectForm('series')" id="addSeries">+</a>
				</th>
				<td id="series">
				</td>
			</tr>
			<tr>
				<th>
					배우
					<a href="javascript:false;" onclick="selectForm(0)">+</a>
				</th>
				<td id="actor">
				</td>
			</tr>
			<tr>
				<th>
					감독
					<a href="javascript:false;" onclick="selectForm(1)">+</a>
				</th>
				<td id="director">
				</td>
			</tr>
			<tr>
				<th>포스터</th>
				<td><input type="file" name="poster"></td>
			</tr>
			<tr>
				<th>스틸컷</th>
				<td><input type="file" name="stillcut"></td>
			</tr>
			<tr>
				<th>트레일러 영상</th>
				<td><input type="file" name="trailer"></td>
			</tr>
			<tr>
				<th>영상</th>
				<td><input type="file" name="org"></td>
			</tr>
			<tr>
				<td id="btnBox" colspan="2">
					<input type="submit" value="등록" class="btn btn-default btn-sm">
					<input type="reset" value="취소" class="btn btn btn-sm">
				</td>
			</tr>
		</table>
	</form>
	<!-- 
		<div id="sForm" style="position: absolute;top: 200px;left: 200px;
		width: 400px;border: 1px solid red;background-color: lightgray;">
			배우이름 : <input type="text" id="actorName" size="20" onkeyup="searchStaff(event,0)">
			<input type="button" value="등록" onclick="insertForm()">
			<input type="button" value="취소" onclick="removeForm()">
			<form onsubmit="insertStaff(0)" id="insertForm">
				<table border="1" width="400" id="searchTable">
					<tr>
						<th>이름</th>
						<th>출생년도</th>
						<th>성별</th>
						<th>데뷔작</th>
					</tr>
					<tr>
						<td><input type="text" size="8" id="staff_name"></td>
						<td><input type="text" size="8" id="staff_age"></td>
						<td><input type="text" size="8" id="staff_gender"></td>
						<td><input type="text" size="8" id="staff_debut"></td>
					</tr>
					<tr>
						<td colspan="4">
							<input type="submit" value="등록">
						</td>
					</tr>
				</table>
			</form>
		</div>
	 -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
			var str = "<div id=\"sForm\" style=\"position: absolute;top: 200px;left: 200px;"
				+"width: 400px;border: 1px solid red;background-color: lightgray\">";
			if(position==0){
				str += "배우"
			}else{
				str += "감독"
			}
			str += "이름 : <input type=\"text\" id=\"actorName\" size=\"20\" onkeyup=\"searchStaff(event,"+position+")\">"
				+"<table border=\"1\" width=\"400\" id=\"searchTable\">"
				+"<input type=\"button\" value=\"등록\" onclick=\"insertForm("+position+")\">"
				+"<input type=\"button\" value=\"취소\" onclick=\"removeForm()\">"
			+"</div>";
			$("body").append(str);
		}
		function searchStaff(event,position){
			$("#insertForm").remove();
			$("#searchTable").empty();
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
				data:{"position":position,"name":name},
				dataType:"json",
				success:function(data){
					$(data).each(function(i,json) {
						var str = "<tr>"
							+"<td><a href=\"javascript:false;\" onclick=\"selectStaff("
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
		function selectStaff(position,num,name){
			$("#sForm").remove();
			if(position==0){
				var str = name+" <input type=\"hidden\" name=\"actor"+num+"\" value=\""+name+"\">";
				$("#actor").append(str);
			}else{
				var str = name+" <input type=\"hidden\" name=\"director"+num+"\" value=\""+name+"\">";
				$("#director").append(str);
			}
		}
		function insertForm(position){
			$("#searchTable").empty();
			var form = 
			"<form onsubmit=\"return insertStaff("+position+")\" id=\"insertForm\">"
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
			$("#sForm").append(form);
			
		}
		function removeForm(){
			$("#sForm").remove();
		}
		function insertStaff(position){
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
			return false;
		}
	</script>
</head>
<body>
	<h1>컨텐츠등록</h1>
	<form action='<c:url value="/content/insert"/>' method="post"
	enctype="multipart/form-data">
		<table>
			<tr>
				<th>컨텐츠 명</th>
				<td><input type="text" name="content_num"></td>
			</tr>
			<tr>
				<th>줄거리</th>
				<td><textarea rows="7" cols="30" name="content_summary"></textarea></td>
			</tr>
			<tr>
				<th>개봉/방영 일</th>
				<td><input type="date" name="release"></td>
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
					배우
					<a href="javascript:false;" onclick="selectForm(0)">+</a>
				</th>
				<td id="actor">
					<!-- 
					한지민 <input type="hidden" name="actor1" value="한지민">
					 -->
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
				<td><input type="file" name="content_post1"></td>
			</tr>
			<tr>
				<th>스틸컷</th>
				<td><input type="file" name="content_post2"></td>
			</tr>
			<tr>
				<th>트레일러 영상</th>
				<td><input type="file" name="trailer_file"></td>
			</tr>
			<tr>
				<th>영상</th>
				<td><input type="file" name="org_file"></td>
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
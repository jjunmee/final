<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		//등급 리스트 뿌리기
		gradelist();
	});
	
	//등급 리스트 뿌리기
	function gradelist(){
		$.ajax({
			url:"<c:url value='/grade/gradelist'/>",
			dataType:"json",
			success:function(data){
				var str1 = "<tr><th>등급이름</th><th>동시접속인원</th><th>가격</th><th>수정</th><th>삭제</th></tr>"
				$("#gradelist").append(str1);
				$(data).each(function(i,json){
					var str="<tr>";
								str+="<td id=\"grade_name" + json.grade_num + "\">" +json.grade_name+ "</td>"
								+"<td id=\"grade_person" + json.grade_num + "\">" +json.grade_person+ "</td>"
								+"<td id=\"grade_price" + json.grade_num + "\">" +json.grade_price+ "원</td>"
								+"<td id=\"gradeupdate" + json.grade_num + "\"><a href=\"javascript:false;\" onclick=\"gupdate(" + json.grade_num + ")\">수정</a></td>"
								+"<td><a href=\"javascript:false;\" onclick=\"gradedelete(" + json.grade_num + ")\">삭제</a></td>";
								str+="</tr>";
					$("#gradelist").append(str);
				});
			}
		});
	}
	//등급 삭제
	function gradedelete(num){
		$("#gradelist").empty();
		$.ajax({
			url:"<c:url value='/grade/delete'/>",
			data:{"num":num},
			dataType: "json",
			success:function(data){
				alert(data.code);
				gradelist();
			}
		});
	}
	
	//수정버튼 클릭시 요청
	function gupdate(num){
		$("#grade_name"+num).empty();
		$("#grade_person"+num).empty();
		$("#grade_price"+num).empty();
		$("#gradeupdate"+num).empty();
		$.ajax({
			url:"<c:url value='/grade/updateForm'/>",
			data:{"num":num},
			dataType:"json",
			success:function(data){
				var str1="<input type=\"text\" id=\"gradeName"+ data.grade_num +"\" value=\"" + data.grade_name + "\" >";
				var str2="<input type=\"number\" min=\"1\" max=\"10\" id=\"gradePerson"+ data.grade_num +"\" value=\"" + data.grade_person + "\" >";
				var str3="<input type=\"number\" min=\"5000\" max=\"50000\" step=\"500\" id=\"gradePrice"+ data.grade_num +"\" value=\"" + data.grade_price + "\" >";
				var str4="<a href=\"javascript:false;\" onclick=\"gradeupdateOk(" + data.grade_num + ")\">확인</a>";
				$("#grade_name" + num).append(str1);
				$("#grade_person" + num).append(str2);
				$("#grade_price" + num).append(str3);
				$("#gradeupdate" + num).append(str4);
			}
		});
	}
	
	//수정확인시 요청
	function gradeupdateOk(num){
		var genre_name = $("#gradeName" + num).val();
		var grade_person = $("#gradePerson" + num).val();
		var grade_price = $("#gradePrice" + num).val();
		$("#gradelist").empty();
		$.ajax({
			url:"<c:url value='/grade/update'/>",
			data:{"grade_num":num,"grade_name":genre_name,"grade_person":grade_person,"grade_price":grade_price},
			dataType:"json",
			success:function(data){
				alert(data.code);
				gradelist();
			}
		});
	}
</script>
<div>
<h1>등급관리</h1>
	<form method="post" action='<c:url value="/grade/insert"/>'>
		등급명<input type="text" name="grade_name" required>
		인원<input type="number" min="1" max="10" name="grade_person" required>
		가격<input type="number" min="5000" max="50000" step="500" name="grade_price" required>
		<input type="submit" value="추가">
	</form>
		<table id="gradelist">
		</table>
</div>

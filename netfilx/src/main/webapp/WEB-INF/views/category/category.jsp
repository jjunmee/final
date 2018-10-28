<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript">
	$(function(){
		var code = '${code}';
		if(code != null && code != ""){
			alert(code);
		}
		//카테고리 리스트 뿌리기
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json){
					var str="<tr>"
								+"<td id=\"cate" + json.category_num + "\">" +json.category_name+ "</td>"
								+"<td id=\"cateok" + json.category_num + "\"><a href=\"javascript:false;\" onclick=\"cupdate(" + json.category_num + ")\">수정</a></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/category/delete?num=" + json.category_num + "\">삭제</a></td>"
							+"</tr>";
					$("#categorylist").append(str);
				});
			}
		});
		//장르 리스트 뿌리기
		$.ajax({
			url:"<c:url value='/category/genrelist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json){
					var str="<tr>"
								+"<td>" +json.category_name+ "</td>"
								+"<td id=\"genre" + json.genre_num + "\">" +json.genre_name+ "</td>"
								+"<td id=\"genreok" + json.genre_num + "\"><a href=\"javascript:false;\" onclick=\"gupdate(" + json.genre_num +"," + json.category_num+ ")\">수정</a></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/genre/delete?num=" + json.genre_num + "\">삭제</a></td>"
							+"</tr>";
					$("#genrelist").append(str);
				});
			}
		});
		
		//장르등록옵션에 카테고리 리스트 뿌리는거 요청
		cateselect();
	});
	
	//카테고리리스트 장르등록 옵션에 뿌리기
	function cateselect(){
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json) {
					var str = "<option value=\""+json.category_num+"\">"
						+json.category_name+"</option>";
					$("#category").append(str);
				});
			}
		});
	}
	
	//장르 수정버튼 클릭시 요청
	function cupdate(num){
		$("#genre"+num).empty();
		$("#genreok"+num).empty();
		$.ajax({
			url:"<c:url value='/genre/genrename'/>",
			data:{"num":num},
			dataType:"json",
			success:function(data){
				var str1="<input type=\"text\" id=\"genreName"+ num +"\" value=\"" + data.genre_name + "\" >";
				var str2="<a href=\"javascript:false;\" onclick=\"gupdateOk(" + num + ")\">확인</a>";
				$("#genre" + num).append(str1);
				$("#genreok" + num).append(str2);
			}
		});
	}
	//카테고리 수정버튼 클릭시 요청
	function cupdate(num){
		$("#cate"+num).empty();
		$("#cateok"+num).empty();
		$.ajax({
			url:"<c:url value='/category/categoryname'/>",
			data:{"num":num},
			dataType:"json",
			success:function(data){
				var str1="<input type=\"text\" id=\"cateName"+ num +"\" value=\"" + data.category_name + "\" >";
				var str2="<a href=\"javascript:false;\" onclick=\"cupdateOk(" + num + ")\">확인</a>";
				$("#cate" + num).append(str1);
				$("#cateok" + num).append(str2);
			}
		});
	}
	
	//수정확인시 요청
	function cupdateOk(num){
		var category_name = $("#cateName"+num).val();
		$("#cate"+num).empty();
		$("#cateok"+num).empty();
		$.ajax({
			url:"<c:url value='/category/update'/>",
			data:{"category_name":category_name,"category_num":num},
			dataType:"json",
			success:function(data){
				var name = data.updatename;
				var str = "<a href=\"javascript:false;\" onclick=\"cupdate(" + data.updatenum + ")\">수정</a>";
				$("#cate" + num).append(name);
				$("#cateok" + num).append(str);
				$("#category").empty();
				cateselect();
			}
		});
	}
</script>
<div>
<h1>분류</h1>
	<form method="post" action='<c:url value="/category/insert"/>'>
		분류 
		<input type="text" name="category_name">
		<input type="submit" value="추가">
	</form>
		<table border="1" id="categorylist" width="800">
			<tr>
				<th>분류</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</table>
<h1>장르</h1>
	<form method="post" action='<c:url value="genre/insert"/>'>
		장르 
		<select name="category_num" id="category">
		</select>
		<input type="text" name="genre_name">
		<input type="submit" value="추가">
	</form>
		<table border="1" id="genrelist" width="800">
			<tr>
				<th>컨텐츠번호</th>
				<th>장르</th>
				<th>수정</th>
				<th>삭제</th>
				<td>
					<select name="g_c_list">
						<option value=""></option>
					</select>
				</td>
			</tr>
		</table>
</div>

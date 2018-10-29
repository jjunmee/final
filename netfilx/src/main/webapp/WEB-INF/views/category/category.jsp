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
		categorylist();

		//장르 리스트 뿌리기
		genrelist();
		
		//장르등록시 옵션에 카테고리 리스트 뿌리는거 요청
		cateselect();
	});
	
	//카테고리 리스트 뿌리기
	function categorylist(){
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json){
						var str="<tr>";
					if(json.category_name == "미정"){
								str+="<td id=\"cate" + json.category_num + "\" colspan=\"3\">" +json.category_name+ "</td>";
					}else{
								str+="<td id=\"cate" + json.category_num + "\">" +json.category_name+ "</td>"
								+"<td id=\"cateok" + json.category_num + "\"><a href=\"javascript:false;\" onclick=\"cupdate(" + json.category_num + ")\">수정</a></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/category/delete?num=" + json.category_num + "\">삭제</a></td>";
					}
								str+="</tr>";
					$("#categorylist").append(str);
				});
			}
		});
	}
	
	//장르 리스트 뿌리기
	function genrelist(){
		$.ajax({
			url:"<c:url value='/category/genrelist'/>",
			dataType:"json",
			success:function(data){
				var str1 = "<tr><th>컨텐츠번호</th><th>장르</th><th>수정</th><th>삭제</th></tr>"
				$("#genrelist").append(str1);
				$(data).each(function(i,json){
					var str="<tr>"
								+"<td id=\"gcate" + json.genre_num + "\">" +json.category_name+ "</td>"
								+"<td id=\"genre" + json.genre_num + "\">" +json.genre_name+ "</td>"
								+"<td id=\"genreok" + json.genre_num + "\"><a href=\"javascript:false;\" onclick=\"gupdate(" + json.genre_num + "," + json.category_num+ ")\">수정</a></td>"
								+"<td><a href=\"${pageContext.request.contextPath }/genre/delete?num=" + json.genre_num + "\">삭제</a></td>"
							+"</tr>";
					$("#genrelist").append(str);
				});
			}
		});
	}
	
	//카테고리리스트 장르등록 옵션에 뿌리기
	function cateselect(){
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json) {
					var str1 = "<option value=\""+json.category_num+"\">"
						+json.category_name+"</option>";
					var str2 = "<input type=\"checkbox\" name=\"gcate_check\" value=\"" + json.category_num + "\">" + json.category_name;
					$("#category").append(str1);
					$("#gcate_check_div").append(str2);
				});
				
			}
		});
	}
	
	//장르 수정시 장르의 카테고리 선택하는 창에 옵션뿌리기
	function gcselect_option(gnum){
		$.ajax({
			url:"<c:url value='/content/categorylist'/>",
			dataType:"json",
			success:function(data){
				$(data).each(function(i,json) {
					var str1 = "<option value=\""+json.category_num+"\">"
						+json.category_name+"</option>";
					$("#gcate_select"+ gnum).append(str1);
				});
			}
		});
	}
	
	//장르 수정버튼 클릭시 요청
	function gupdate(gnum,cnum){
		$("#gcate"+gnum).empty();
		$("#genre"+gnum).empty();
		$("#genreok"+gnum).empty();
		$.ajax({
			url:"<c:url value='/genre/genrename'/>",
			data:{"gnum":gnum},
			dataType:"json",
			success:function(data){
				var str1="<input type=\"text\" id=\"genreName"+ data.genre_num +"\" value=\"" + data.genre_name + "\" >";
				var str2="<a href=\"javascript:false;\" onclick=\"gupdateOk(" + data.genre_num + "," + data.category_num+ ")\">확인</a>";
				var str3="<select name=\"gcateselect\" id=\"gcate_select" + data.genre_num + "\"><option value=\""+data.category_num+"\" selected=\"selected\">"
				+data.category_name+"(기존)</option></select>";
				$("#genre" + gnum).append(str1);
				$("#genreok" + gnum).append(str2);
				$("#gcate" + gnum).append(str3);
				gcselect_option(data.genre_num);
			}
		});
	}
	
	//장르 수정확인시 요청
	function gupdateOk(gnum,cnum){
		var genre_name = $("#genreName"+gnum).val();
		var category_num = $("#gcate_select" + gnum + " option:selected").val();
		$("#gcate"+gnum).empty();
		$("#genre"+gnum).empty();
		$("#genreok"+gnum).empty();
		$.ajax({
			url:"<c:url value='/genre/update'/>",
			data:{"genre_name":genre_name,"genre_num":gnum,"category_num":category_num},
			dataType:"json",
			success:function(data){
				var cname = data.category_name;
				var gname = data.genre_name;
				var str = "<a href=\"javascript:false;\" onclick=\"gupdate(" + data.genre_num + "," + data.category_num+ ")\">수정</a>";
				$("#gcate" + gnum).append(cname);
				$("#genre" + gnum).append(gname);
				$("#genreok" + gnum).append(str);
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
	 
	//카테고리 수정확인시 요청
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
				$("#gcate_check_div").empty();
				cateselect();
				//장르리스트 지우기
				$("#genrelist").empty();
				//장르리스트 다시 뿌리기
				genrelist();
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
	<form method="post" action='<c:url value="/genre/insert"/>'>
		장르 
		<select name="category_num" id="category">
		</select>
		<input type="text" name="genre_name">
		<input type="submit" value="추가">
	</form>
		<div id="gcate_check_div"></div>
		<table border="1" id="genrelist" width="800">
		</table>
</div>

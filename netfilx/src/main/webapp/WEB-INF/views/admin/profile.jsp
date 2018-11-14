<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/dist/jquery.vm-carousel.css'/>">
<script src="<c:url value='/resources/js/profile/admin-profile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/dist/jquery.vm-carousel.js'/>"></script>

<div class="container">
	<div class="row col-sm-6">
		<select class="" id="pro_group_sel" onchange="sel_group(this.value);">
			<option>Profile group list</option>
			<c:forEach var="list" items="${profile_group }">
			<option value="${list.pro_group_no }">${list.pro_group_name }</option>	
			</c:forEach>
		</select>
		<button  class="btn btn-default sm-4" onclick="pro_group_del()">삭제</button>
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }">
	</div>
	<div class="row col-sm-6">
		<form method="post" action="<c:url value='/admin/profile/groupInput'/>">
			<input type="text" name="pro_group_name" id="pro_group_name">
			<input type="submit"  class="btn btn-default" value="추가">
			<p>추가시 변경 불가능 삭제 후 재등록 바랍니다.</p>
		</form>
	</div>
	
	<div class="row col-sm-8">
		<button class="btn btn-default" onclick="pimg_del()">선택 삭제</button>
		<input type="hidden" id="pimg_no">
		<!-- 슬라이드 -->
		<div id="proImg-slide"></div>
	</div>
	<div class="row col-sm-4">
		<form method="post" action="<c:url value='/admin/profile/imgInput'/>" enctype="multipart/form-data">
			<input type="file" name="file1" id="file1">
			<input type="hidden" name="pro_group_no" id="pro_group_no" value="${pro_group_no }" >
			<input type="submit"  class="btn btn-default" value="추가">
			<p>추가시 변경, 삭제 불가(사용중인 사람이 있을 시) 관리자에게 문의 바랍니다.</p>
		</form>
	</div>
</div>

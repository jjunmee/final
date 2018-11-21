<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/dist/jquery.vm-carousel.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/profile.css'/>">
<script src="<c:url value='/resources/js/profile/admin-profile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/dist/jquery.vm-carousel.js'/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>
<div class="container list">
	<div class="row">
		<div class="col-sm-11 col-md-11">
		<select class="form-control" id="pro_group_sel" onchange="sel_group(this.value);">
			<option>Profile group list</option>
			<c:forEach var="list" items="${profile_group }">
			<option value="${list.pro_group_no }">${list.pro_group_name }</option>	
			</c:forEach>
		</select>
		</div>
		<div class="col-sm-1 col-md-1">
		<button  class="btn btn-danger " onclick="pro_group_del()" >삭제</button>
		</div>
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }">
	</div>
	<div class="row">
		<form method="post" action="<c:url value='/admin/profile/groupInput'/>">
		<div class="col-sm-11 col-md-11">
			<input type="text" name="pro_group_name" id="pro_group_name" class="form-control">
		</div>
		<div class="col-sm-1 col-md-1">	
			<input type="submit"  class="btn btn-primary" value="추가">
		</div>
		<div class="col-sm-5 col-md-5">	
			<p>추가시 변경 불가능 삭제 후 재등록 바랍니다.</p>
		</div>
		</form>
	</div>
	<div class="row">
	<form method="post" action="<c:url value='/admin/profile/imgInput'/>" enctype="multipart/form-data" onsubmit="return group_ck()">
		<div class="col-sm-11 col-md-11">	
		<input type="file" name="file1" id="file1" class="form-control">
		</div>
		<input type="hidden" name="pro_group_no" id="pro_group_no" value="${pro_group_no }" >
		<div class="col-sm-1 col-md-1">	
		<input type="submit"  class="btn btn-primary" value="추가">
		</div>
		<div class="col-sm-5 col-md-5">	
		<p>추가시 변경, 삭제 불가(사용중인 사람이 있을 시) 관리자에게 문의 바랍니다.</p>
		</div>
	</form>
	</div>
	<div class="row">
	<button class="btn btn-danger btn-lt" onclick="pimg_del()">선택 삭제</button>
	<input type="hidden" id="pimg_no">
	</div>
	<div class="row">
		<!-- 슬라이드 -->
			<div id="proImg-slide"></div>
	</div>
</div>

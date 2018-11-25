<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/dist/jquery.vm-carousel.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/profile.css'/>"> 
<script src="<c:url value='/resources/js/profile/admin-profile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/dist/jquery.vm-carousel.js'/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>
<script type="text/javascript">
jQuery(function($){
	$('.vmcarousel-normal').vmcarousel({
	    centered: false,
	    start_item: 0,
	    autoplay: false,
	    infinite: false
	 });
});
</script>
<div class="list">
<c:if test="${!empty(s_profile_num) }">
	<div class="container">
		<table>
		<tr>
			<td class="col-sm-1">
				<a href="javascript:history.go(-1)">
					<i class="glyphicon glyphicon-arrow-left" aria-hidden="true"></i>
				</a>
			</td>
			<td class="col-sm-4">
				<h2>프로필 변경</h2>
				<h3>프로필 아이콘을 선택하세요</h3>
			</td>
			<td class="col-sm-7">
				<img src="${pimg_src }" width="10"  style="float: right;">
			</td>
		<tr>
		</table>
	</div>
</c:if>
<c:if test="${!empty(pro_list) }">
	<c:forEach var="G_list" items="${group_list }">
	<div class="container">
	<h3>${G_list.pro_group_name } </h3>
		<div class="vmcarousel-normal">
		<c:forEach var="I_list" items="${pro_list }">
			<c:if test="${G_list.pro_group_no eq I_list.pro_group_no }">
				<c:choose>
					<c:when test="${empty(s_profile_num) }">
						<a href="<c:url value='/profile/user/insertForm?first=${first }&pimg_src=${I_list.pimg_src }&pimg_num=${I_list.pimg_num }'/>">
							<img src="${I_list.pimg_src }" width="120" height="120">
						</a>					
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/profile/user/updateFormView?profile_num=${s_profile_num }&n_pimg_src=${I_list.pimg_src }&n_pimg_num=${I_list.pimg_num }'/>">
							<img src="${I_list.pimg_src }" width="120" height="120">
						</a>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
		</div>
	</div>
	</c:forEach>
</c:if>
</div>
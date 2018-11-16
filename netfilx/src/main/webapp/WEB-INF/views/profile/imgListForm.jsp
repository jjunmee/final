<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/dist/jquery.vm-carousel.css'/>">
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
<c:if test="${!empty(pro_list) }">
	<c:forEach var="G_list" items="${group_list }">
	<div class="container">
	<h1>${G_list.pro_group_name } </h1>
		<div class="vmcarousel-normal">
		<c:forEach var="I_list" items="${pro_list }">
			<c:if test="${G_list.pro_group_no eq I_list.pro_group_no }">
				<a href="<c:url value='/profile/user/insertForm?first=${first }&pimg_src=${I_list.pimg_src }&pimg_num=${I_list.pimg_num }'/>">
					<img src="${I_list.pimg_src }" width="150">
				</a>					
			</c:if>
		</c:forEach>
		</div>
	</div>
	</c:forEach>
</c:if>

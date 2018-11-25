<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$.get("<c:url value='/content/categorylist'/>",
				function(data) {
					$(data).each(function(i, json) {
						if(${sessionScope.profile_num} != null && json.category_name != '미정'){
							str = 
								"<li><a href=\""
									+"<c:url value='/content/userView"
									+"?profile_num=${sessionScope.profile_num }&category_num="+json.category_num+"'/>"
								+"\">"
									+json.category_name
								+"</a></li>";
							$("#mainHead").append(str);
						}
					});
		});
	});
	function searchFocus(event) {
		var searchText = document.getElementById("searchText");
		if(event == 'in'){
			$("#searchText").animate({
				"width":"300px"
			});
			searchText.placeholder = "제목, 이름, 장르";
		}else{
			$("#searchText").animate({
				"width":"55px"
			});
			searchText.placeholder = "검색";
		}
	}
	function searchContent() {
		var txt = document.getElementById("searchText").value;
		$.get("<c:url value='/content/searchContent'/>",
				{"txt":txt},
				function(data) {
					$(data).each(function(i, json) {
						if(json.category_name != '미정'){
							str = 
								"<li><a href=\""
									+"<c:url value='/content/userView"
									+"?profile_num=${sessionScope.profile_num }&category_num="+json.category_num+"'/>"
								+"\">"
									+json.category_name
								+"</a></li>";
							$("#mainHead").append(str);
						}
					});
		});
	}
</script>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Profile Password</h4>
      </div>
      <form method="post" id="modalProfile" action="<c:url value='/profile/user/getInfo'/>">
      <div class="modal-body">
        <input type="password" id="p_password" name="p_password" min="4" max="4" placeholder="비밀번호입력">
        <input type="hidden" id="profile_num" name="profile_num" value=""/>
      </div>
      <div class="modal-footer">
      	 <input type="submit" class="btn btn-default" value="완료">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
      </form>
    </div>
  </div>
</div>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="<c:url value='/'/>">
      	<img src='<c:url value="/resources/images/mainlogo.png"/>' style="width: 80px;">
      </a>
    </div>
    <div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav" id="mainHead">
          <c:if test="${sts eq 1 }">
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">관리자<span class="caret"></span></a>
            <ul class="dropdown-menu">
	          <li><a href="<c:url value='/admin/profile'/>">프로필 관리</a></li>
	          <li><a href="<c:url value='/content/insert'/>">컨텐츠등록</a></li>
	          <li><a href="<c:url value='/content/list'/>">컨텐츠목록</a></li>
	          <li><a href="<c:url value='/staff/list'/>">스테프 관리</a></li>
	          <li><a href="<c:url value='/series/list'/>">시리즈 관리</a></li>
	          <li><a href="<c:url value='/category/category'/>">카테고리관리</a></li>
              <li><a href="<c:url value='/grade/grade'/>">등급관리</a></li>
              <li><a href="<c:url value='/admin/userlist'/>">회원관리</a></li>
              <li><a href="<c:url value='/admin/paychart'/>">매출통계</a></li>
            </ul>
          </li>
          </c:if>
          <li><a href="<c:url value='/survey/list?code=1'/>">설문</a></li>
          <li><a href="<c:url value='/content/userView?profile_num=${sessionScope.profile_num }'/>">홈</a></li>
        </ul>
        
        <ul class="nav navbar-nav" style="float: right;margin-right: 20px">
	          <c:choose>
		          <c:when test="${id eq null }">
		         	 <li><a href="<c:url value='/loginForm'/>">로그인</a></li>
		          </c:when>
		          <c:otherwise>
		          	<c:if test="${!empty(profile_num) }">
			          <li class="dropdown" onclick="profile('${pageContext.request.contextPath }')"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><img alt="profile" src="${pimg_src }" width="30"><span class="caret"></span></a>
			            <ul class="dropdown-menu" id="profile_row">	
			              <li><a href="<c:url value='/profile/user/index'/>">프로필</a></li>
			              <li><a href="<c:url value='/mypage/myinfo'/>">계정</a></li>
			              <li><a href="<c:url value='/qna/list'/>">고객센터</a></li>
				          <li><a href="<c:url value='/logout'/>">로그아웃</a></li>
			            </ul>
			          </li>
			          </c:if>
		          </c:otherwise>
	          </c:choose>
        </ul>
        <ul class="nav navbar-nav" style="float: right;">
          <li id="dropdown" onclick="alarm_view('${pageContext.request.contextPath }')"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
          	<i class="glyphicon glyphicon-bullhorn btn-lg" style="color: white;padding: 0px 0px;">
	          	<c:if test="${alarm_count ne '0'}">
	          		<span style="color: red;margin-left: -6px;">${alarm_count }</span>
	          	</c:if>
          	</i></a>
            <ul class="dropdown-menu" id="alarm_row"></ul>
          </li>
         </ul>
        <input type="text" id="searchText" placeholder=" 검색" 
        	onfocus="searchFocus('in')" onfocusout="searchFocus('out')" onkeyup="searchContent()"
        	style="float: right;margin-top: 10px;width: 55px;">
      </div>
    </div>
  </div>
</nav>
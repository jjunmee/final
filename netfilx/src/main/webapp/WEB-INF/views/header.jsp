<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <input type="text" id="p_password" name="p_password" min="4" max="4" placeholder="비밀번호입력">
        <input type="hidden" id="profile_num" name="profile_num" value=""/>
      </div>
      <div class="modal-footer">
      	 <input type="submit" class="btn btn-default" value="전환">
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
        <ul class="nav navbar-nav">
          <li><a href="<c:url value='/survey/list?code=1'/>">설문</a></li>
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">민성작업 <span class="caret"></span></a>
            <ul class="dropdown-menu">
	          <li><a href="<c:url value='/content/insert'/>">컨텐츠등록</a></li>
	          <li><a href="<c:url value='/content/list'/>">컨텐츠목록</a></li>
	          <li><a href="<c:url value='/staff/list'/>">스테프 관리</a></li>
	          <li><a href="<c:url value='/series/list'/>">시리즈 관리</a></li>
	          <li><a href="<c:url value='/content/userView?profile_num=${sessionScope.profile_num }'/>">콘텐츠 뷰</a></li>
            </ul>
          </li>
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">미현작업<span class="caret"></span></a>
            <ul class="dropdown-menu">
	          <li><a href="<c:url value='/category/category'/>">카테고리관리</a></li>
              <li><a href="<c:url value='/qna/list'/>">문의게시판</a></li>
              <li><a href="<c:url value='/qna/chat'/>">채팅</a></li>
              <li><a href="<c:url value='/grade/grade'/>">등급관리</a></li>
            </ul>
          </li>
          <c:if test="${sts eq 1 }">
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">관리자<span class="caret"></span></a>
            <ul class="dropdown-menu">
	          <li><a href="<c:url value='/admin/profile'/>">프로필 관리</a></li>
            </ul>
          </li>
          </c:if>
        </ul>
        
        <ul class="nav navbar-nav" style="float: right;">
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
			              <li><a href="#">고객센터</a></li>
				          <li><a href="<c:url value='/logout'/>">로그아웃</a></li>
			            </ul>
			          </li>
			          </c:if>
		          </c:otherwise>
	          </c:choose>
        </ul>
      </div>
    </div>
  </div>
</nav>
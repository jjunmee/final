<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">WebSiteName</a>
    </div>
    <div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav">
          <li><a href="<c:url value='/loginForm'/>">로그인</a></li>
          <li><a href="<c:url value='/survey/list?code=1'/>">설문</a></li>
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">민성작업 <span class="caret"></span></a>
            <ul class="dropdown-menu">
	          <li><a href="<c:url value='/content/insert'/>">컨텐츠등록</a></li>
	          <li><a href="<c:url value='/content/list'/>">컨텐츠목록</a></li>
            </ul>
          </li>
          <li><a href="<c:url value='/category/category'/>">카테고리관리</a></li>
          <li><a href="<c:url value='/mypage/myinfo'/>">계정관리</a></li>
          <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지 <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">프로필</a></li>
              <li><a href="#">계정</a></li>
              <li><a href="#">고객센터</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>    



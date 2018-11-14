<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(function(){
		var user=document.getElementById("userId");
		if(user.getAttribute("value")!=null && user.getAttribute("value")!=''){
			var userId=user.getAttribute("value");
			$.ajax({				
				url:"<c:url value='/survey/surveyInCheck?userId="+userId+"'/>",
				dataType:"json",
				success:function(data){
					$(data).each(function(i,json){
						var sNum=json;
						var spanId="surveyInSpan"+sNum;
						var aTagId="aTag"+sNum;
						if(document.getElementById(spanId)!=null){							
							var surveySpan=document.getElementById(spanId);
							surveySpan.innerHTML="참여";
							var aTag=document.getElementById(aTagId);
							aTag.onclick=function(){
								alert("이미 참여한 설문입니다.");
							}
							aTag.removeAttribute("href");
						}
					});
				}
			});
		}
		
	});
	function setPageNum(pageNum){
		$("#pageNum").val(pageNum);
		$("#listForm").submit();
	}
	function idCheck(n,snum){
		var userId=document.getElementById("userId");
		if(userId.getAttribute("value")==null || userId.getAttribute("value")==''){
			alert('먼저 로그인을 해주세요');
		}else{
			if(n==0){//나의설문지
				location.href="<c:url value='/survey/mySurvey'/>";
			}else if(n==1){//설문구매
				location.href="<c:url value='/survey/surveyInsert1'/>";
			}else if(n==2){
				location.href="<c:url value='/survey/surveyDetail?surveyNum="+snum+"'/>";
			}
		}
	}
	

</script>
<style type="text/css">
	.surveyList{padding-left: 80px;padding-top: 90px;height:700px;}
	.surveyList .surBtn{padding-left: 73%;padding-bottom: 10px;}
	.surveyList .leftBox{width:14%;float: left} 
	.surveyList .centerBox{width:78%;float:left} 
</style>
<div class="surveyList">
	<div class="surBtn"><input type="button" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="javascript:idCheck(0);">나의 설문지</a>
		</div>
	</div>
	
	<div id="listBox" class="centerBox">
		<div id="listTable">		
			<table>
				<tr>
					<th>번호</th>
					<th>설문제목</th>
					<th>조사인원</th>
					<th>배당금</th>
					<th>등록일</th>
					<c:choose>
						<c:when test="${code==1 }">						
							<th>마감기한</th>
							<th>참여여부</th>
						</c:when>
						<c:when test="${code==2 }">
							<th>종료일</th>
						</c:when>
					</c:choose>					
				</tr>
				<c:forEach var="vo" items="${list }">
					<tr> 
						<td>${vo.surveyNum }</td>
					<c:if test="${code==1 }">
						<td><a href="javascript:idCheck(2,${vo.surveyNum })" id="aTag${vo.surveyNum }">${vo.surveyName }</a></td>						
					</c:if>
					<c:if test="${code==2 }">
						<td>${vo.surveyName }</td>
					</c:if>
						<td>${vo.joinNum }</td>
						<td>${Math.round(vo.spoint/vo.joinNum) }포인트</td>
						<td>${vo.surveyStart }</td>
						<td>${vo.surveyEnd }</td>	
					<c:if test="${code==1 }">
						<td><span id="surveyInSpan${vo.surveyNum }">미참여</span></td>
					</c:if>
					</tr>
				</c:forEach>	
			</table>
		</div>	
		<div>
			<c:choose>
				<c:when test="${pageUtil.pageNum>pageUtil.pageBlockCount }">
					<a href="javascript:setPageNum(${pageUtil.startPageNum-1 });">[이전]</a>
				</c:when>
				<c:otherwise>
					[이전]
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageUtil.startPageNum }" end="${pageUtil.endPageNum }">
				<c:choose>
					<c:when test="${pageUtil.pageNum==i }">
						<a href="<c:url value='/survey/list?code=${code }&pageNum=${i }&field=${field }&keyword=${keyword }'/>">
							<span style="color:blue;">[${i }]</span>
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/survey/list?code=${code }&pageNum=${i }&field=${field }&keyword=${keyword }'/>">
							<span style="color:gray;">[${i }]</span>
						</a>
					</c:otherwise>
				</c:choose>			
			</c:forEach>
			<c:choose>
				<c:when test="${pageUtil.endPageNum!=pageUtil.totalPageCount }">
					<a href="javascript:setPageNum(${pageUtil.endPageNum+1 });">[다음]</a>
				</c:when>
				<c:otherwise>
					[다음]
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<form id="listForm" action="<c:url value='/survey/list'/> method='post'">
				<select name="field">
					<option value=""></option>
					<option value=""></option>
					<option value=""></option>
				</select>
				<input type="hidden" id="userId" value="${sessionScope.id }">
				<input type="text" name="keyword" value="${keyword }">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</div>

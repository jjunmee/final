<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link type='text/css' href="<c:url value='/resources/css/survey.css'/>" rel='stylesheet' media='screen' />

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
		if(n==0){//나의설문지
			location.href="<c:url value='/survey/mySurvey'/>";
		}else if(n==1){//설문구매
			location.href="<c:url value='/survey/surveyInsert1'/>";
		}else if(n==2){
			location.href="<c:url value='/survey/surveyDetail?surveyNum="+snum+"'/>";
		}
	}
	function checkAll(){
		var chk=document.getElementsByName("check");
		if(chk[0].checked==true){
			for(var i=1;i<chk.length;i++){
				chk[i].checked=true;
			}
		}else{
			for(var i=1;i<chk.length;i++){
				chk[i].checked=false;
			}
		}
	} 
	function check1(){
		var chk=document.getElementsByName("check");
		for(var i=1;i<chk.length;i++){
			if(chk[i].checked==false){
				chk[0].checked=false;
			}
		}
	}
	function delete1(){
		var code=document.getElementById("code").value;
		var userSts=document.getElementById("userSts").value;
		var delNumArr="";
		var chk=document.getElementsByName("check");
		for(var i=1;i<chk.length;i++){
			if(chk[i].checked==true){
				delNumArr+=chk[i].value+",";
			}
		}
		delNumArr=delNumArr.substring(0, delNumArr.lastIndexOf(","));//맨끝 콤마 지우기
		if(delNumArr==''){
			alert("삭제할 대상을 선택하세요");
			return false;
		}
		if(confirm("삭제하시겠습니까?")){
			location.href="<c:url value='/survey/delete?delNumArr="+delNumArr+"&code="+code+"&userSts="+userSts+"'/>";
		}
	}
	function submit(){
		var sort=document.getElementsByName("sort")[0].value;
		location.href="<c:url value='/survey/list?pageNum=${pageUtil.pageNum}&sort="+sort+"&code=${code}&field=${field}&keyword=${keyword}'/>";
	}

</script>
<style type="text/css">
	td{text-align: center;}
	#surveyName{text-align: left;}
	
</style>
<div class="surveyList">
	<div class="topBox">
		<c:if test="${userSts=='admin' }">
			<div class="delBox"><input type="button" value="삭제" onclick="delete1()"></div>
		</c:if>
		<div id="orderBox">
			<select name="sort" onchange="submit()">
				<option value="surveyStart"
				<c:if test="${sort=='surveyStart' }">selected="selected"</c:if>>등 록 일 순</option>
				<option value="surveyEnd"
				<c:if test="${sort=='surveyEnd' }">selected="selected"</c:if>>마 감 일 순</option>
				<option value="expensive"
				<c:if test="${sort=='expensive' }">selected="selected"</c:if>>배 당 금 순</option>
			</select>
		</div>
		<div class="searchForm">
			<form id="listForm" action="<c:url value='/survey/list'/>" method="post">
				<select name="field" >
					<option value="surveyName" >제 목</option>
					<option value="surveyDescription">내 용</option>					
				</select>
				<input type="hidden" id="code" name="code" value="${code }">
				<input type="text" name="keyword" value="${keyword }" >
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div id="tab" class="leftBox">
		<c:if test="${userSts=='user' }">
			<div class="surBtn"><input type="button" class="surBtn" onclick="javascript:idCheck(1);" value="설문구매하러가기"></div>
		</c:if>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">진행중인 설문지</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문지</a>
		</div>
		<c:if test="${userSts=='user' }">
			<div class="leftDivBox">
				<a href="javascript:idCheck(0);">나의 설문지</a>
			</div>
		</c:if>
	</div> 
	
	<div id="listBox" class="centerBox">
		<div id="listTable">		
			<table>
				<tr>
					<c:if test="${userSts=='admin' }">
						<th><input type="checkbox" name="check" onclick="checkAll()"></th>
					</c:if>
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
				<c:set var="cnt" value="0"/>
				<c:forEach var="vo" items="${list }">
					<tr> 
					<c:if test="${userSts=='admin' }">
						<td><input type="checkbox" name="check" value="${vo.surveyNum }" onclick="check1()"></td>
					</c:if>
						<td>${vo.surveyNum }</td>
					<c:if test="${code==1 }">
						<td id="surveyName"><a href="javascript:idCheck(2,${vo.surveyNum })" id="aTag${vo.surveyNum }">${vo.surveyName }</a></td>						
					</c:if>
					<c:if test="${code==2 }">
						<td id="surveyName">${vo.surveyName }</td>
					</c:if>
						<td>${joinCntList[cnt]} / ${vo.joinNum }</td>
						<td>${Math.round(vo.spoint/vo.joinNum) }포인트</td>
						<td>${vo.surveyStart }</td>
						<td>${vo.surveyEnd }</td>	
					<c:if test="${code==1 }">
						<td><span id="surveyInSpan${vo.surveyNum }">미참여</span></td>
					</c:if>
					</tr>
					<c:set var="cnt" value="${cnt+1 }"/>
				</c:forEach>	
			</table>
		</div>	
		<div class="pageMoving">
			<c:choose>
				<c:when test="${pageUtil.pageNum>pageUtil.pageBlockCount }">
					<a href="javascript:setPageNum(${pageUtil.startPageNum-1 });">[이전]</a>
				</c:when>
				<c:otherwise>
					[이전]
				</c:otherwise>
			</c:choose>
			&nbsp;
			<c:forEach var="i" begin="${pageUtil.startPageNum }" end="${pageUtil.endPageNum }">
				<c:choose>
					<c:when test="${pageUtil.pageNum==i }">
						<a href="<c:url value='/survey/list?code=${code }&pageNum=${i }&field=${field }&keyword=${keyword }&sort=${sort }'/>">
							<span style="color:blue;">[${i }]</span>
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/survey/list?code=${code }&pageNum=${i }&field=${field }&keyword=${keyword }&sort=${sort }'/>">
							<span style="color:gray;">[${i }]</span>
						</a>
					</c:otherwise>
				</c:choose>	
				&nbsp;		
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
	</div>	
	<input type="hidden" id="userSts" value="${userSts }">
	<input type="hidden" id="userId" value="${sessionScope.id }">
</div>

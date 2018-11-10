<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	function setPageNum(pageNum){
		$("#pageNum").val(pageNum);
		$("#listForm").submit();
	}

</script>

<div class="surveyList">
	<div id="tab" class="leftBox">
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
		</div>
		<div class="leftDivBox">
			<a href="<c:url value='/survey/mySurvey'/>">나의 설문지</a>
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
						<td><a href="<c:url value='/survey/surveyDetail?surveyNum=${vo.surveyNum }'/>">${vo.surveyName }</a></td>
					</c:if>
					<c:if test="${code==2 }">
						<td>${vo.surveyName }</td>
					</c:if>
						<td>${vo.joinNum }</td>
						<td>${Math.round(vo.spoint/vo.joinNum) }포인트</td>
						<td>${vo.surveyStart }</td>
						<td>${vo.surveyEnd }</td>	
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
				<input type="text" name="keyword" value="${keyword }">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
</div>